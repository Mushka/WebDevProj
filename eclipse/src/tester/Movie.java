package tester;

import java.util.ArrayList;

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
	
	public Movie(int id, String title, int year, String director, String bannar_url, String trailer_url, ArrayList<Star> stars, ArrayList<String> genres) {
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
	
	public ArrayList<Star> getStars()
	{
		return stars;
	}
	
	public void setStars(ArrayList<Star> stars)
	{
		this.stars = stars;
	}
	
	public void setGenres(ArrayList<String> genres)
	{
		this.genres = genres;
	}
	
	public ArrayList<String> getGenres()
	{
		return genres;
	}
	
	
	
	


}
