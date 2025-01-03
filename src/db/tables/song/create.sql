CREATE TABLE song (
 id SERIAL PRIMARY KEY,
 year INT,
 title VARCHAR(255),
 artist VARCHAR(255),
 src VARCHAR(255),
 genre_id INT
);
