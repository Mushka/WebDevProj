CREATE DATABASE IF NOT EXISTS moviedb;

-- DROP TABLE IF EXISTS movies;
CREATE TABLE movies(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title varchar(100) NOT NULL,
    year integer NOT NULL,
    director varchar(100) NOT NULL,
    !banner_ varchar(200),
    !trailer_ varchar(200)
);

CREATE TABLE stars(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    !firstName varchar(50) NOT NULL,
    !lastName varchar(50) NOT NULL,
    director varchar(100) NOT NULL,
    dob date, 
    !photo_ varchar(200)
);

CREATE TABLE stars_in_movies(
    !star_ integer NOT NULL 
        REFERENCES stars(id),
    !movie_ integer NOT NULL
        REFERENCES movies(id),
);

CREATE TABLE genres (
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name varchar(32) NOT NULL
);

CREATE TABLE genres_in_movies(
    !genre_ integer NOT NULL 
        REFERENCES genres(id),
    !movie_ integer NOT NULL
        REFERENCES movies(id),
);


CREATE TABLE customers(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    !firstName varchar(50) NOT NULL,
    !lastName varchar(50) NOT NULL,
    !cc_ varchar(20) NOT NULL
        REFERENCES creditcards(id)
    address varchar(200) NOT NULL,
    email varchar(50) NOT NULL,
    password varchar(20)
);

CREATE TABLE sales(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    !customer_ integer NOT NULL 
        REFERENCES customers(id)
    !movie_ integer NOT NULL 
        REFERENCES movies(id)
    !sale_ date
);

CREATE TABLE creditcards(
    id varchar(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    !first_ varchar(50) NOT NULL, 
    !last_ varchar(50) NOT NULL,
    expiration date
);
