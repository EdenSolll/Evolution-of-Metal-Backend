-- Drops existing tables
DROP TABLE IF EXISTS song CASCADE;
DROP TABLE IF EXISTS genre CASCADE;

-- Recreates song table
CREATE TABLE song (
 id SERIAL PRIMARY KEY,
 year INT,
 title VARCHAR(255),
 artist VARCHAR(255),
 src VARCHAR(255),
 genre_id INT
);

-- Recreates genre table
CREATE TABLE genre (
 id SERIAL PRIMARY KEY,
 genre VARCHAR(255),
 start_year INT,
 y_axis INT
);
