use crate::db::*;
use actix_web::web::{self, Data};
use sqlx::{postgres::PgPoolOptions, Pool, Postgres};
use std::env;

pub struct AppState {
    pub db: Pool<Postgres>,
}

pub fn configure_app(cfg: &mut web::ServiceConfig) {
    cfg.service(get_songs).service(get_genres);
}

pub async fn get_app_data() -> Data<AppState> {
    let songarchive_pool = PgPoolOptions::new()
        .connect(&env::var("DATABASE_URL").expect("DATABASE_URL Not set"))
        .await
        .expect("Could not connect to database");
    println!("Successfully opened conditional db connection");
    Data::new(AppState {
        db: songarchive_pool,
    })
}
