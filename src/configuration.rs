#[derive(Clone)]
pub struct Configuration {
    pub is_production: bool,
    pub port: u16,
}

#[cfg(feature = "dev")]
pub fn get_configuration() -> Configuration {
    Configuration {
        is_production: false,
        port: 3000,
    }
}

#[cfg(not(feature = "dev"))]
pub fn get_configuration() -> Configuration {
    Configuration {
        is_production: true,
        port: 80,
    }
}
