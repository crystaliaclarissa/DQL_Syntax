SELECT * FROM movies;
SELECT * FROM movie_country;
SELECT * FROM movie_genre;

CREATE TABLE staging (
	id VARCHAR,
	title TEXT,
	type TEXT,
	description TEXT,
	release_year INTEGER,
	age_certification TEXT,
	runtime INTEGER,
	genre TEXT [],
	production_countries TEXT []
);

SELECT * FROM staging;

COPY staging (id, title, type, description, release_year, age_certification, runtime, genre, production_countries)
FROM '/private/tmp/movies.csv' 
DELIMITER ',' 
CSV HEADER;

CREATE TABLE movies (
	id TEXT PRIMARY KEY,
	title TEXT,
	type TEXT,
	description TEXT,
	release_year INTEGER,
	age_certification TEXT,
	runtime INTEGER
);

INSERT INTO movies (id, title, type, description, release_year, age_certification, runtime)
SELECT
	id, 
	title, 
	type, 
	description, 
	release_year, 
	age_certification, 
	runtime
FROM staging;

CREATE TABLE movie_genre (
	id TEXT,
	genre TEXT,
	FOREIGN KEY (id) REFERENCES movies(id)
);

INSERT INTO movie_genre (id, genre)
SELECT
	id,
	UNNEST(genre)
FROM staging;

CREATE TABLE movie_country (
	id TEXT,
	production_country TEXT,
	FOREIGN KEY (id) REFERENCES movies(id)
);

INSERT INTO movie_country (id, production_country)
SELECT
	id,
	UNNEST (production_countries)
FROM staging;

-- DQL All movies with the production country
SELECT 
	title,
	movie_country.production_country
FROM movies
JOIN movie_country
ON
	movies.id = movie_country.id;

-- DQL Most popular movie genre
SELECT title, runtime 
FROM movies
ORDER BY runtime DESC
LIMIT 10;

SELECT 
	movies.title,
	COUNT(movie_genre.genre) as genre_count
FROM movies
JOIN movie_genre
ON
	movies.id = movie_genre.id
GROUP BY movies.title
ORDER BY genre_count DESC;

-- DQL Countries that made most movies
SELECT
	movie_country.production_country,
	COUNT(movies.id) AS total_movies
FROM movies
JOIN movie_country
ON
	movies.id = movie_country.id
GROUP BY movie_country.production_country
ORDER BY total_movies DESC;