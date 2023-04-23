// check deps fn
// - elm-watch

use actix_files as fs;
use actix_web::{web, App, HttpResponse, HttpServer};
use handlebars::Handlebars;
use serde_json::json;
mod dev_server;

async fn index(handlebars: web::Data<Handlebars<'_>>) -> HttpResponse {
    let json = json!({
        "title": "My New Post",
        "body": "This is my first post!"
    });
    let body = handlebars.render("index", &json).unwrap();
    HttpResponse::Ok().body(body)
}

fn is_dev() -> bool {
    true
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let mut handlebars = Handlebars::new();
    handlebars
        .register_templates_directory(".hbs", "./src/views")
        .unwrap();

    let handlebars_ref = web::Data::new(handlebars);
    HttpServer::new(move || {
        let mut app = App::new();

        // If we are in dev mode, then add in the dev_server stuff
        // to our locally running dev server.
        if is_dev() {
            app = app.configure(dev_server::config);
        }

        // Normal production server stuff
        app.app_data(handlebars_ref.clone())
            // index route
            .route("/", web::get().to(index))
            .service(fs::Files::new("/dist", "./dist").show_files_listing())
    })
    .bind(("127.0.0.1", 3000))?
    .run()
    .await
}
