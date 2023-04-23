#[derive(Clone)]
pub struct Configuration {
    pub is_production: bool,
    pub addr: String,
    pub port: u16,
}

#[cfg(feature = "dev")]
pub fn get_configuration() -> Configuration {
    Configuration {
        is_production: false,
        addr: "127.0.0.1".to_string(),
        port: 3000,
    }
}

#[cfg(not(feature = "dev"))]
pub fn get_configuration() -> Configuration {
    Configuration {
        is_production: true,
        addr: "0.0.0.0".to_string(),
        port: 80,
    }
}
