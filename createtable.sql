drop database if exists moviedb;
CREATE DATABASE IF NOT EXISTS moviedb;

USE moviedb;


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
    director varchar(100) NOT NULL,
    dob date, 
    photo_url varchar(200)
);

CREATE TABLE stars_in_movies(
    star_id integer NOT NULL REFERENCES stars(id),
    movie_id integer NOT NULL REFERENCES movies(id)
);

CREATE TABLE genres (
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(32) NOT NULL
);

CREATE TABLE genres_in_movies(
    genre_id integer NOT NULL REFERENCES genres(id),
    movie_id integer NOT NULL REFERENCES movies(id)
);


CREATE TABLE customers(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    cc_id varchar(20) NOT NULL REFERENCES creditcards(id),
    address varchar(200) NOT NULL,
    email varchar(50) NOT NULL,
    password varchar(20)
);

CREATE TABLE sales(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id integer NOT NULL REFERENCES customers(id),
    movie_id integer NOT NULL REFERENCES movies(id),
    sale_date date
);

CREATE TABLE creditcards(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(50) NOT NULL, 
    last_name varchar(50) NOT NULL,
    expiration date
);
