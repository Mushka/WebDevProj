-- DROP DATABASE IF EXISTS moviedb;
-- CREATE DATABASE moviedb;

-- USE moviedb;

-- DROP TABLE IF EXISTS movies;
CREATE TABLE movies(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title varchar(100) NOT NULL,
    year integer NOT NULL,
    director varchar(100) NOT NULL,
    banner_url varchar(200),
    trailer_url varchar(200)
);

CREATE TABLE stars(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    dob date, 
    photo_url varchar(200)
);

CREATE TABLE stars_in_movies(
    star_id integer NOT NULL,
    movie_id integer NOT NULL,
    FOREIGN KEY (star_id) REFERENCES stars(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY(star_id, movie_id)  
);

CREATE TABLE genres (
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(32) NOT NULL
);

CREATE TABLE genres_in_movies(
    genre_id integer NOT NULL,
    movie_id integer NOT NULL,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY(genre_id, movie_id) 
);

CREATE TABLE creditcards(
    id varchar(20) NOT NULL PRIMARY KEY,
    first_name varchar(50) NOT NULL, 
    last_name varchar(50) NOT NULL,
    expiration date NOT NULL
);

CREATE TABLE customers(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    cc_id varchar(20) NOT NULL,
    address varchar(200) NOT NULL,
    email varchar(50) NOT NULL,
    password varchar(20) NOT NULL,
    FOREIGN KEY (cc_id) REFERENCES creditcards(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id integer NOT NULL,
    movie_id integer NOT NULL,
    sale_date date NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE ON UPDATE CASCADE
);

