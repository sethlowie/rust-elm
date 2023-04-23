use std::time::{Duration, Instant, SystemTime};

use actix::prelude::*;
use actix_web::{web, App, Error, HttpRequest, HttpResponse};
use actix_web_actors::ws;
use std::fs;

const HEARTBEAT_INTERVAL: Duration = Duration::from_millis(5);
const FILE_PATH: &str = "./dist/main.css";

async fn dev_server(req: HttpRequest, stream: web::Payload) -> Result<HttpResponse, Error> {
    let res = ws::start(FileWatcherWebsocket::new(), &req, stream);
    println!("Dev server started");
    res
}

// create actix web configuration function
pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.service(web::resource("/dev-server").route(web::get().to(dev_server)));
}

pub struct FileWatcherWebsocket {
    hb: Instant,
    modified: SystemTime,
}
impl FileWatcherWebsocket {
    pub fn new() -> Self {
        let metadata = fs::metadata(FILE_PATH).unwrap();
        let modified = metadata.modified().unwrap();

        Self {
            hb: Instant::now(),
            modified,
        }
    }

    /* This is not a great implementation as it will create a new
     * process that watches the files on every browser connection.
     *
     * This function needs to be updated to push the ctx.addr into a list
     * and then send a msg to every client in the list. We also need to deal
     * with client disconnects and reconnects.
     *
     * Reconnects should be handled by the client trying to reconnect on fail.
     * */

    fn watch_files(&mut self, ctx: &mut <Self as Actor>::Context) {
        ctx.run_interval(HEARTBEAT_INTERVAL, |act, ctx| {
            let modified = fs::metadata(FILE_PATH).unwrap().modified().unwrap();
            if modified.duration_since(act.modified).unwrap() > Duration::from_millis(0) {
                act.modified = modified;
                println!("Sending file changes event! {}", &FILE_PATH);
                ctx.text("file_changed")
            }

            ctx.ping(b"");
        });
    }
}

struct FileChanged;

impl Message for FileChanged {
    type Result = ();
}

impl Handler<FileChanged> for FileWatcherWebsocket {
    type Result = ();

    fn handle(&mut self, _msg: FileChanged, ctx: &mut Self::Context) {
        println!("Sending file changes event!");
        ctx.text("File changed");
    }
}

impl Actor for FileWatcherWebsocket {
    type Context = ws::WebsocketContext<Self>;

    fn started(&mut self, ctx: &mut Self::Context) {
        println!("Websocket Client connected!");
        self.watch_files(ctx);
    }
}

impl StreamHandler<Result<ws::Message, ws::ProtocolError>> for FileWatcherWebsocket {
    fn handle(&mut self, msg: Result<ws::Message, ws::ProtocolError>, ctx: &mut Self::Context) {
        match msg {
            Ok(ws::Message::Ping(msg)) => {
                self.hb = Instant::now();
                ctx.pong(&msg);
            }
            Ok(ws::Message::Pong(_)) => {
                self.hb = Instant::now();
            }
            Ok(ws::Message::Text(text)) => ctx.text(text),
            Ok(ws::Message::Binary(bin)) => ctx.binary(bin),
            Ok(ws::Message::Close(reason)) => {
                ctx.close(reason);
                ctx.stop();
            }
            _ => ctx.stop(),
        }
    }
}
