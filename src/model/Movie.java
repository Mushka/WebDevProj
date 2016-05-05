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
import com.google.gson.Gson;


public class Movie {

	private int id;
	private String title;
	private int year;
	private String director;
	private String bannar_url;
	private String trailer_url;
	private ArrayList<Star> stars = null;
	private ArrayList<String> genres = null;

	
	public Movie() {
		super();
		this.id = -1;
		this.title = null;
		this.year = -1;
		this.director = null;
		this.bannar_url = null;
		this.trailer_url = null;
	}
	
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
	public void addToGenres(String s){
		this.genres.add(s);
	}

	public ArrayList<String> getGenres() {
		return genres;
	}
	
	public String toString()
	{
		return "Id: " + id + " " + "Title: " + title + " " + "Year: " + year + " " + "Director: " + director + " ";
	}
	
	public String toJson()
	{
		return new Gson().toJson(this);
	}
	
	public static Movie getMovie(int id)
	{
		Movie m = null;
		String query = "select * from movies where id = " + id;
		
		ArrayList<Map<String, Object>> results;
		try {
			results = MySQL.select(query);

			// m = new Movie(((Integer) results.get(0).get("id")).intValue(), results.get(0).get("title").toString(), ((Integer)results.get(0).get("year")).intValue(),
			// 			results.get(0).get("director").toString(), results.get(0).get("banner_url").toString(), results.get(0).get("trailer_url").toString());

			
			Map<String, Object> row = results.get(0);
			
			//there was a get id from the row but it is also passed in
			
			String title = row.get("title").toString();
			int year = ((Integer)row.get("year")).intValue();
			String director = row.get("director").toString();
			
			String banner_url = "";
			if(row.get("banner_url") != null)
				banner_url = row.get("banner_url").toString();
			
			String trailer_url = "";
			if(row.get("trailer_url") != null)
				trailer_url = row.get("trailer_url").toString();
			
			m = new Movie(id, title, year, 
					director, banner_url, trailer_url);
		
	        m.setGenres(Movie.getGenres(id));
	        m.setStars(Movie.getStars(id));
	 
		} catch (Exception e) {

			e.printStackTrace();
		    System.out.println("Invalid SQL Command. [Movie.getMovie()]\n\n" + e.toString());
		    return null;
		}
		
		return m;
	}

	public static ArrayList<Movie> getMovies(String query) {

		ArrayList<Movie> movies = new ArrayList<Movie>();

		ArrayList<Map<String, Object>> results;
		try {
			results = MySQL.select(query);

			for (Map<String, Object> row : results)
			{
				
				int id = ((Integer) row.get("id")).intValue();
				String title = row.get("title").toString();
				int year = ((Integer)row.get("year")).intValue();
				String director = row.get("director").toString();
				
				String banner_url = "";
				if(row.get("banner_url") != null)
					banner_url = row.get("banner_url").toString();
				
				String trailer_url = "";
				if(row.get("trailer_url") != null)
					trailer_url = row.get("trailer_url").toString();
				

				Movie m = new Movie(id, title, year, 
						director, banner_url, trailer_url);
			
		        m.setGenres(Movie.getGenres(m.getId()));
		        m.setStars(Movie.getStars(m.getId()));
		        
				movies.add(m);
			}

		} catch (Exception e) {

			e.printStackTrace();
		    System.out.println("Invalid SQL Command. [Movie.getMovies()]\n\n" + e.toString());
		    
		    movies = new ArrayList<Movie>();

		}

		return movies;
	}

	public static ArrayList<String> getGenres(int m_id) {
		ArrayList<String> genres = new ArrayList<String>();

		String query = "select g.name as 'genre' "
				+ "from movies as m, genres_in_movies as gm, genres as g where m.id = gm.movie_id and g.id = gm.genre_id and m.id = "
				+ m_id + " " + "order by g.name, m.title, m.year, m.director;";

		ArrayList<Map<String, Object>> results = null;

		try {
			results = MySQL.select(query);

			for (Map<String, Object> row : results)
				genres.add(row.get("genre").toString());
			
		} catch (Exception e) {

			e.printStackTrace();
		     System.out.println("Invalid SQL Command. [Movie.getGenres()]\n\n" + e.toString());
		     
		     genres = new ArrayList<String>();
		}

		return genres;
	}
	

	public static ArrayList<Star> getStars(int m_id) {
    	
    	ArrayList<Star> stars = new ArrayList<Star>();
    	
        String query =     		
	              "select s.id, s.first_name, s.last_name, s.dob, s.photo_url "
	              + "from movies as m, stars as s, stars_in_movies as sm where m.id = sm.movie_id and s.id = sm.star_id and m.id = " + m_id + " "
	              + "order by s.first_name, s.last_name;";

		ArrayList<Map<String, Object>> results = null;

		try {
			results = MySQL.select(query);

			for (Map<String, Object> row : results)
			{

				int s_id = ((Integer) row.get("id")).intValue();
				String first_name = row.get("first_name").toString();
				String last_name = row.get("last_name").toString();
				
				String dob = "";
				if(row.get("dob") != null)
					dob = row.get("dob").toString();
				
				String photo_url = "";
				if(row.get("photo_url") != null)
					photo_url = row.get("photo_url").toString();

				stars.add(new Star(s_id, first_name, last_name, dob, photo_url));
			}
					
		} catch (Exception e) {

			e.printStackTrace();
		     System.out.println("Invalid SQL Command. [Movie.getStars()]\n\n" + e.toString());
		     
		     stars = new ArrayList<Star>();
		}

		return stars;
	}
	
}
