// check deps fn
// - elm-watch

use actix_files as fs;
use actix_web::{
    web::{self, Data},
    App, HttpResponse, HttpServer,
};
use handlebars::Handlebars;
use serde_json::json;

async fn index(handlebars: web::Data<Handlebars<'_>>) -> HttpResponse {
    let json = json!({
        "title": "My New Post",
        "body": "This is my first post!"
    });
    let body = handlebars.render("index", &json).unwrap();
    HttpResponse::Ok().body(body)
}

fn register_handlebars() -> Data<Handlebars<'static>> {
    let mut handlebars = Handlebars::new();
    handlebars
        .register_templates_directory(".hbs", "./src/views")
        .unwrap();
    web::Data::new(handlebars)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let handlebars_ref = register_handlebars();
    HttpServer::new(move || {
        App::new()
            .app_data(handlebars_ref.clone())
            // index route
            .route("/", web::get().to(index))
            .service(fs::Files::new("/dist", "./dist").show_files_listing())
    })
    // TODO: configurable port
    .bind(("127.0.0.1", 3000))?
    .run()
    .await
}
