#[derive(Clone)]
pub struct Configuration {
    pub is_production: bool,
}

pub fn get_configuration() -> Configuration {
    Configuration {
        is_production: is_production(),
    }
}

#[cfg(feature = "dev")]
fn is_production() -> bool {
    false
}

#[cfg(not(feature = "dev"))]
fn is_production() -> bool {
    true
}
