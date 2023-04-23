use serde::Serialize;

#[derive(Serialize)]
pub struct Flags {
    pub title: String,
    pub description: String,
}
