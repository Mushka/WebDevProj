drop procedure if exists add_movie;
DELIMITER //
CREATE PROCEDURE add_movie(IN title_m varchar(100), IN year_m integer, IN director_m varchar(100), IN banner_url_m varchar(200), IN trailer_url_m varchar(200), IN first_name_s varchar(50), IN last_name_s varchar(50), IN dob_s date, IN photo_url_s varchar(200), name_g varchar(32), OUT star_id varchar(10), OUT genre_id varchar(10), OUT output varchar(300))
BEGIN

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- INITIALIZE NEEDED VARIABLES 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	DECLARE genre_provided INTEGER DEFAULT 0;
	DECLARE star_provided INTEGER DEFAULT 0;
	DECLARE movie_provided INTEGER DEFAULT 0;

	set output = "";

	IF name_g != "" THEN
		SET genre_provided = 1;
	END IF;

	IF last_name_s != "" THEN
		SET star_provided = 1;
	END IF;

	IF title_m != "" and year_m != -1 and director_m != "" THEN
		SET movie_provided = 1;
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- CHECK IF STAR EXISTS
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF star_provided = 1 THEN

		-- init the static variable  
		set @star_id = -1;

		PREPARE check_for_star from "SELECT id into @star_id FROM stars WHERE first_name = ? and last_name = ? limit 1";

		set @a = first_name_s;
		set @b = last_name_s;

		EXECUTE check_for_star USING @a, @b;
		DEALLOCATE PREPARE check_for_star;

		set star_id = @star_id;

	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- INSERT STAR IF IT DOESN'T EXIST
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF star_provided = 1 THEN
		IF star_id = -1 THEN
			select "star doesn't exist. inserting..." as output;

			PREPARE insert_star from "INSERT INTO stars (first_name, last_name, dob, photo_url) VALUES (?,?,?,?)";
			set @a = first_name_s;
			set @b = last_name_s;
			set @c = dob_s;
			set @d = photo_url_s;

			EXECUTE insert_star USING @a, @b, @c, @d;
			DEALLOCATE PREPARE insert_star;

			SELECT LAST_INSERT_ID() INTO star_id;
			set @star_id = star_id;
			select star_id as "Star was inserted, ID:";
			set output = concat(output, "The star '", last_name_s, "' was created. \n");

		ELSE
			select star_id;
			-- nothing needs to happen here
			set output = concat(output, "The star '", last_name_s, "' already exists.\n");
		END IF;
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- CHECK IF GENRE EXISTS
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF genre_provided = 1 THEN
		-- init static variable 
		set @genre_id = -1;

		PREPARE check_for_genre from "SELECT id into @genre_id FROM genres WHERE name = ? limit 1";

		set @a = name_g;

		EXECUTE check_for_genre USING @a;
		DEALLOCATE PREPARE check_for_genre;

		set genre_id = @genre_id;
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- INSERT GENRE IF IT DOESN'T EXIST
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF genre_provided = 1 THEN
		IF genre_id = -1 THEN
			select "genre doesn't exist. inserting..." as output;

			PREPARE insert_genre from "INSERT INTO genres (name) VALUES (?)";
			set @a = name_g;
			EXECUTE insert_genre USING @a;
			DEALLOCATE PREPARE insert_genre;

			SELECT LAST_INSERT_ID() INTO genre_id;
			set @genre_id = genre_id;
			select genre_id as "Genre was inserted, ID:";
			set output = concat(output, "The genre '", name_g, "' was created. \n");

		ELSE
			select genre_id;
			-- nothing needs to happen here
			set output = concat(output, "The genre '", name_g, "' already exists. \n");

		END IF;
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- CHECK IF MOVIE EXISTS
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	IF movie_provided = 1 THEN

		-- init the static variable 
		set @movie_id = -1;

		PREPARE check_for_movie from "SELECT id into @movie_id FROM movies WHERE title = ? and year = ? and director = ? limit 1";

		set @a = title_m;
		set @b = year_m;
		set @c = director_m;

		EXECUTE check_for_movie USING @a, @b, @c;
		DEALLOCATE PREPARE check_for_movie;

		-- set movie_id = @movie_id;
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- INSERT MOIVE IF IT DOESN'T EXIST
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF movie_provided = 1 THEN
		IF @movie_id = -1 THEN
			select "movie doesn't exist - inserting..." as output;

			PREPARE insert_movie from "INSERT INTO movies (title, year, director, banner_url, trailer_url) VALUES (?,?,?,?,?)";
			set @a = title_m;
			set @b = year_m;
			set @c = director_m;
			set @d = banner_url_m;
			set @e = trailer_url_m;

			EXECUTE insert_movie USING @a, @b, @c, @d, @e;
			DEALLOCATE PREPARE insert_movie;

			SELECT LAST_INSERT_ID() INTO @movie_id;
			-- set @movie_id = movie_id;
			select @movie_id as "Movie was inserted, ID:";
			set output = concat(output, "The movie '", title_m, "' was created. \n");

		ELSE
			select @movie_id as movie_output;
			-- nothing needs to happen here
			set output = concat(output, "The movie '", title_m, "' already exists. \n");

		END IF;
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- CHECK IF STAR ALREADY STARS IN MOVIE
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF star_provided = 1  and movie_provided = 1 THEN
		-- init the static variable 
		set @stars_in_movie_check = -1;

		PREPARE check_for_star_movie from "SELECT star_id into @stars_in_movie_check FROM stars_in_movies where star_id = ? and movie_id = ? limit 1";

		set @a = @star_id;
		set @b = @movie_id;

		EXECUTE check_for_star_movie USING @a, @b;
		DEALLOCATE PREPARE check_for_star_movie;

		-- select @stars_in_movie_check as 'stars_in_movie_check';
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- LINK STAR TO MOVIE IF NOT A STAR ALREADY
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF star_provided = 1 and movie_provided = 1 THEN
		IF @stars_in_movie_check = -1 THEN
			select "movie doesn't have this star - inserting..." as output;

			PREPARE link_star_to_moive from "INSERT INTO stars_in_movies (star_id, movie_id) VALUES (?,?)";

			set @a = @star_id ;
			set @b = @movie_id ;

			EXECUTE link_star_to_moive USING @a, @b;
			DEALLOCATE PREPARE link_star_to_moive;

			select "Star has been added to the movie";
			set output = concat(output, last_name_s, " was linked to ", title_m, ". \n");
		ELSE
			select "Movie already has this star";
			set output = concat(output, title_m, " already has ", last_name_s, " as a star. \n");

		END IF;
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- CHECK IF GENRE IS ALREADY A GENRE FOR MOVIE
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF genre_provided = 1 and movie_provided = 1 THEN
		-- init the static variable 
		set @genre_in_movie_check = -1;

		PREPARE check_for_genre_in_movie from "SELECT genre_id into @genre_in_movie_check FROM genres_in_movies where genre_id = ? and movie_id = ? limit 1";

		set @a = @genre_id;
		set @b = @movie_id;

		EXECUTE check_for_genre_in_movie USING @a, @b;
		DEALLOCATE PREPARE check_for_genre_in_movie;

		-- select @genre_in_movie_check as 'genre_in_movie_check';
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- LINK GENRE TO MOVIE IF NOT A GENRE ALREADY
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	IF genre_provided = 1 and movie_provided = 1 THEN
		IF @genre_in_movie_check = -1 THEN
			select "movie doesn't have this genre - inserting..." as output;

			PREPARE link_genre_to_moive from "INSERT INTO genres_in_movies (genre_id, movie_id) VALUES (?,?)";

			set @a = @genre_id ;
			set @b = @movie_id ;

			EXECUTE link_genre_to_moive USING @a, @b;
			DEALLOCATE PREPARE link_genre_to_moive;

			select "Genre has been added to the movie";
			set output = concat(output, name_g, " was linked to ", title_m, ". \n");
		ELSE
			select "Movie already has this genre";
			set output = concat(output, title_m, " already has ", name_g, " as a genre. \n");

		END IF;
	END IF;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	-- If a record corresponding to the star or genre exists, it is linked to the movie; 
	-- if not, it is created and then linked to the movie. 
	-- Insert a movie only if it does not exist. All necessary stars_in_movies and genres_in_movies records are also created. The procedure should output informative status messages to the user as it performs the task. If a movie's record set cannot be correctly made, the procedure needs to output a corresponding message, and no changes to the database are made.

END //
DELIMITER ;


-- This will show the data created above in mysql
drop procedure if exists viewData;
DELIMITER //
CREATE PROCEDURE viewData()
BEGIN

	select * from genres where id > 907010;
	select * from stars where id > 907022;
	select * from movies where id > 907012;

END //
DELIMITER ;

-- This will delete the data created above in mysql
drop procedure if exists deleteData;
DELIMITER //
CREATE PROCEDURE deleteData()
BEGIN

	delete from genres where id > 907010;
	delete from stars where id > 907022;
	delete from movies where id > 907012;

END //
DELIMITER ;

