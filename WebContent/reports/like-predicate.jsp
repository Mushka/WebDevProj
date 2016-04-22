<p><strong>Our code has a MySQL class that deals with all our SQL commands.</strong><br>
<em>: /src/model/MySQL.java</em></p>

<p>This class gets passed a String that contains our query which uses the like predicate to compare the attribute genre and title. The only attribute that is not compared is our Credentials for login. These are set in our TryToLoginCustomer.java file ( /src/servlets/TryToLoginCustomer.java ).</p>

<p>Our servlets ( /src/servlets/*.java ) however contstruct all our queries that get passed to our mySQL class. </p>

<p>All the queries we constructed that included like</p>

<p><strong>- returns all the info of all actors and the movies they stared in</strong></p>
<p><em>:Used in Search.java ( /src/servlets/Search.java ) for regular search</em></p>

<p>select s.first_name as 'first', s.last_name as 'last', s.id as 'star ID', 
m.title, m.year, m.director, m.banner_url as 'banner', m.trailer_url as 'trailer', 
m.id as 'movie ID'
from stars_in_movies as sm, stars as s, movies as m
where sm.star_id = s.id and m.id = sm.movie_id
AND m.title like '"ENTER TITLE HERE"%'
(Order by also ascending and desending or by year 
is added here DESC, YEAR, TITLE)</p>

<p><strong>- shows all movies for a given genre</strong></p>
<p><em>:Used in ShowGenre.java (/src/servlets/ShowGenre.java )</em></p>

<p>select m.id, m.title, m.year, m.director, m.banner_url, m.trailer_url 
from movies as m, genres_in_movies as gm, genres as g
where m.id = gm.movie_id and g.id = gm.genre_id and g.name like '"ENTER GENRE NAME"'
(Order by also ascending and desending or by year 
is added here DESC, YEAR, TITLE)</p>


<p><strong>- shows all movie titles with more constraints</strong></p>
<p><em>:Used in Search.java ( /src/servlets/Search.java ) for advance search</em></p>

<p>select s.first_name as 'first', s.last_name as 'last', s.id as 'star ID', 
m.title, m.year, m.director, m.banner_url as 'banner', m.trailer_url as 'trailer', 
m.id as 'movie ID'
from stars_in_movies as sm, stars as s, movies as m
where sm.star_id = s.id and m.id = sm.movie_id
AND m.title like '%"ENTER TITLE HERE"%'
AND m.year like '%"ENTER YEAR HERE"
AND m.director like '%"ENTER YEAR HERE"%'
AND s.first_name like '%"ENTER FIRSTNAME HERE"%'
AND s.last_name like '%"ENTER LASTNAME HERE"%'
(Order by also ascending and desending or by year 
is added here DESC, YEAR, TITLE)</p>