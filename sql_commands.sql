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
