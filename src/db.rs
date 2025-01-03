use crate::app::AppState;
use actix_web::get;
use actix_web::web::Data;
use actix_web::HttpResponse;
use actix_web::Responder;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
pub struct Song {
    pub id: Option<i32>,
    pub year: Option<i32>,
    pub title: Option<String>,
    pub artist: Option<String>,
    pub src: Option<String>,
    pub genre_id: Option<i32>,
}

#[derive(Serialize, Deserialize)]
pub struct Genre {
    pub id: Option<i32>,
    pub genre: Option<String>,
    pub start_year: Option<i32>,
    pub y_axis: Option<i32>,
}

#[get("/songs")]
pub async fn get_songs(state: Data<AppState>) -> impl Responder {
    match sqlx::query_as!(
        Song,
        "SELECT id, year, title, artist, src, genre_id FROM song"
    )
    .fetch_all(&state.db)
    .await
    {
        Ok(songs) => HttpResponse::Ok().json(songs),
        Err(e) => HttpResponse::InternalServerError().body(e.to_string()),
    }
}

// #[get("/genre-songs")]
// pub async fn get_genre_songs(
//     state: Data<AppState>,
//     new_id: web::Query<Option<i32>>,
// ) -> impl Responder {
//     match sqlx::query_as!(Song, "SELECT * FROM song WHERE genre_id = new_id")
//         .bind(new_id)
//         .fetch_all(&state.db)
//         .await
//     {
//         Ok(songs) => HttpResponse::Ok().json(songs),
//         Err(e) => HttpResponse::InternalServerError().body(e.to_string()),
//     }
// }

#[get("/genres")]
pub async fn get_genres(state: Data<AppState>) -> impl Responder {
    match sqlx::query_as!(Genre, "SELECT id, genre, start_year, y_axis FROM genre")
        .fetch_all(&state.db)
        .await
    {
        Ok(genres) => HttpResponse::Ok().json(genres),
        Err(e) => HttpResponse::InternalServerError().body(e.to_string()),
    }
}
