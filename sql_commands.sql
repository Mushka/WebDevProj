-- list of sql commands 

-- returns all the info of all actors and the movies they stared in:

select s.first_name as 'first', s.last_name as 'last', s.id as 'star ID', 
m.title, m.year, m.director, m.banner_url as 'banner', m.trailer_url as 'trailer', 
m.id as 'movie ID'
from stars_in_movies as sm, stars as s, movies as m
where sm.star_id = s.id and m.id = sm.movie_id
order by s.first_name, s.last_name, m.title;

-- returns all movies by a selected star:

select s.first_name as 'first', s.last_name as 'last', s.id as 'star ID', 
m.title, m.year, m.director, m.banner_url as 'banner', m.trailer_url as 'trailer', 
m.id as 'movie ID'
from stars_in_movies as sm, stars as s, movies as m
where sm.star_id = s.id and m.id = sm.movie_id and s.id = 'ENTER ID HERE'
order by s.first_name, s.last_name, m.title;

-- adds a customer into the customer table

INSERT INTO customers (first_name, last_name, cc_id, address, email, password)
VALUES ('title', 'value', 'value', 'value', 'value' 'value');

-- deletes a movie from the movie table 

DELETE FROM movies WHERE year = 2017

-- finds all duplicate first names

select s.first_name as 'first', count(distinct s.last_name) as cnt
from stars_in_movies as sm, stars as s, movies as m
where sm.star_id = s.id and m.id = sm.movie_id
group by s.first_name
having (cnt > 1);

-- finds all duplicate last_name

select s.last_name as 'last', count(distinct s.first_name) as cnt
from stars_in_movies as sm, stars as s, movies as m
where sm.star_id = s.id and m.id = sm.movie_id
group by s.last_name
having (cnt > 1);