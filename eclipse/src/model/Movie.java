package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class Movie {

	private int id;
	private String title;
	private int year;
	private String director;
	private String bannar_url;
	private String trailer_url;
	private ArrayList<Star> stars = null;
	private ArrayList<String> genres = null;

	public Movie(int id, String title, int year, String director, String bannar_url, String trailer_url) {
		super();
		this.id = id;
		this.title = title;
		this.year = year;
		this.director = director;
		this.bannar_url = bannar_url;
		this.trailer_url = trailer_url;
	}

	public Movie(int id, String title, int year, String director, String bannar_url, String trailer_url,
			ArrayList<Star> stars, ArrayList<String> genres) {
		super();
		this.id = id;
		this.title = title;
		this.year = year;
		this.director = director;
		this.bannar_url = bannar_url;
		this.trailer_url = trailer_url;
		this.stars = stars;
		this.genres = genres;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getBannar_url() {
		return bannar_url;
	}

	public void setBannar_url(String bannar_url) {
		this.bannar_url = bannar_url;
	}

	public String getTrailer_url() {
		return trailer_url;
	}

	public void setTrailer_url(String trailer_url) {
		this.trailer_url = trailer_url;
	}

	public ArrayList<Star> getStars() {
		return stars;
	}

	public void setStars(ArrayList<Star> stars) {
		this.stars = stars;
	}

	public void setGenres(ArrayList<String> genres) {
		this.genres = genres;
	}

	public ArrayList<String> getGenres() {
		return genres;
	}
	
	public String toString()
	{
		return "Id: " + id + " " + "Title: " + title + " " + "Year: " + year + " " + "Director: " + director + " ";
	}

	public static ArrayList<Movie> getMovies(String query) {

		ArrayList<Movie> movies = new ArrayList<Movie>();

		ArrayList<Map<String, Object>> results;
		try {
			results = MySQL.select(query);

			for (Map<String, Object> row : results)
				movies.add(new Movie(((Integer) row.get("id")).intValue(), row.get("title").toString(), ((Integer)row.get("year")).intValue(),
						row.get("director").toString(), row.get("banner_url").toString(), row.get("trailer_url").toString()));

		} catch (Exception e) {

			e.printStackTrace();
		    System.out.println("Invalid SQL Command. [Movie.getMovies()]\n\n" + e.toString());

		}

		return movies;
	}

	public static ArrayList<String> getGenres(int id) {
		ArrayList<String> genres = new ArrayList<String>();

		String query = "select g.name as 'genre' "
				+ "from movies as m, genres_in_movies as gm, genres as g where m.id = gm.movie_id and g.id = gm.genre_id and m.id = "
				+ id + " " + "order by g.name, m.title, m.year, m.director;";

		ArrayList<Map<String, Object>> results = null;

		try {
			results = MySQL.select(query);

			for (Map<String, Object> row : results)
				genres.add(row.get("genre").toString());
			
		} catch (Exception e) {

			e.printStackTrace();
		     System.out.println("Invalid SQL Command. [Movie.getGenres()]\n\n" + e.toString());

		}

		return genres;
	}
	

	public static ArrayList<Star> getStars(int id) {
    	
    	ArrayList<Star> stars = new ArrayList<Star>();
    	
        String query =     		
	              "select s.id, s.first_name, s.last_name, s.dob, s.photo_url "
	              + "from movies as m, stars as s, stars_in_movies as sm where m.id = sm.movie_id and s.id = sm.star_id and m.id = " + id + " "
	              + "order by s.first_name, s.last_name;";

		ArrayList<Map<String, Object>> results = null;

		try {
			results = MySQL.select(query);

			for (Map<String, Object> row : results)
            	stars.add(new Star(((Integer)row.get("id")).intValue(), row.get("first_name").toString(), row.get("last_name").toString(), row.get("dob").toString(), row.get("photo_url").toString()));
			
		for(Map<String, Object> row : results)
		{
			System.out.println("key = " + row);
			
		    Iterator it = row.entrySet().iterator();
			
		    while (it.hasNext()) {
		        Map.Entry pair = (Map.Entry)it.next();
		        System.out.println(pair.getKey() + " = " + pair.getValue());
		        it.remove(); // avoids a ConcurrentModificationException
		    }
			
		}
		
		} catch (Exception e) {

			e.printStackTrace();
		     System.out.println("Invalid SQL Command. [Movie.getStars()]\n\n" + e.toString());

		}

		return stars;
	}
	
}
