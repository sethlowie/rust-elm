mod configuration;
mod flags;

use actix_files as fs;
use actix_web::{
    web::{self, Data},
    App, HttpResponse, HttpServer,
};
use configuration::Configuration;
use handlebars::Handlebars;
use serde_json::json;

async fn index(
    handlebars: web::Data<Handlebars<'_>>,
    config: web::Data<Configuration>,
) -> HttpResponse {
    match serde_json::to_string(&flags::Flags {
        title: "Rust Elm".to_string(),
        description: "Production ready web apps with Elm, Rust, and TailwindCSS".to_string(),
    }) {
        Ok(flags) => {
            let json = json!({ "flags": flags, "isProd": config.is_production });
            let body = handlebars.render("index", &json).unwrap();
            HttpResponse::Ok().body(body)
        }
        Err(_) => HttpResponse::InternalServerError().body("Failed to parse flags"),
    }
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
    let config = configuration::get_configuration();
    HttpServer::new(move || {
        App::new()
            .app_data(handlebars_ref.clone())
            .app_data(web::Data::new(config.clone()))
            // index route
            .route("/", web::get().to(index))
            .service(fs::Files::new("/dist", "./dist").show_files_listing())
    })
    // TODO: configurable port
    .bind(("127.0.0.1", 3000))?
    .run()
    .await
}
