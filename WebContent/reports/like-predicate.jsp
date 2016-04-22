<p>Our code has a MySQL class that deals with all our SQL commands.
  : /src/model/MySQL.java

This class gets passed a String that contains our query which uses the like predicate to 
compare the attribute genre and title. The only attribute that is not compared is our 
Credentials for login. These are set in our TryToLoginCustomer.java file 
( /src/servlets/TryToLoginCustomer.java ).

Our servlets ( /src/servlets/*.java ) however contstruct all our queries that get passed 
to our mySQL class. 

All the queries we constructed were were<p></p>

- list of sql commands 

- returns all the info of all actors and the movies they stared in:

select s.first_name as 'first', s.last_name as 'last', s.id as 'star ID', 
m.title, m.year, m.director, m.banner_url as 'banner', m.trailer_url as 'trailer', 
m.id as 'movie ID'
from stars_in_movies as sm, stars as s, movies as m</br>where sm.star_id = s.id and m.id = sm.movie_id</br>order by s.first_name, s.last_name, m.title;

- returns all movies by a selected star:

select s.first_name as 'first', s.last_name as 'last', s.id as 'star ID', 
m.title, m.year, m.director, m.banner_url as 'banner', m.trailer_url as 'trailer', 
m.id as 'movie ID'
from stars_in_movies as sm, stars as s, movies as m</br>where sm.star_id = s.id and m.id = sm.movie_id and s.id = 'ENTER ID HERE'
order by s.first_name, s.last_name, m.title;

- adds a customer into the customer table

INSERT INTO customers (first_name, last_name, cc_id, address, email, password)
VALUES ('title', 'value', 'value', 'value', 'value' 'value');

- deletes a movie from the movie table 

DELETE FROM movies WHERE year = 2017

- finds all duplicate first names

select s.first_name as 'first', count(distinct s.last_name) as cnt</br>from stars_in_movies as sm, stars as s, movies as m</br>where sm.star_id = s.id and m.id = sm.movie_id</br>group by s.first_name</br>having (cnt > 1);

- finds all duplicate last_name

select s.last_name as 'last', count(distinct s.first_name) as cnt</br>from stars_in_movies as sm, stars as s, movies as m</br>where sm.star_id = s.id and m.id = sm.movie_id</br>group by s.last_name</br>having (cnt > 1);

- shows titles in alphabetical order: shows 10 movies and starts at location 0 (should increment by 10, if the limit is 10)

SELECT title FROM movies order by title LIMIT 10 OFFSET 0;

- shows genre of movie given the id if that movie 

select g.name as 'genre'
from movies as m, genres_in_movies as gm, genres as g</br>where m.id = gm.movie_id and g.id = gm.genre_id and m.id = 'ENTER ID HERE'
order by g.name, m.title, m.year, m.director;

- shows the actors associated to a given movie based upon the id of that movie (orders by firstname and lastname)

select s.first_name as 'actor firstname', s.last_name as 'actor lastname'
from movies as m, stars as s, stars_in_movies as sm</br>where m.id = sm.movie_id and s.id = sm.star_id and m.id = 'ENTER ID HERE'
order by s.first_name, s.last_name;

- shows all movie titles from any character 

select m.title</br>from movies as m</br>where m.title like 'a%';  -change a to any character

- shows all movies for a given genre

select m.id, m.title, m.year, m.director, m.banner_url, m.trailer_url 
from movies as m, genres_in_movies as gm, genres as g</br>where m.id = gm.movie_id and g.id = gm.genre_id and g.name like 'genre name'
order by g.name, m.title, m.year, m.director;</p>