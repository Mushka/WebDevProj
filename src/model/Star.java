package model;

import java.util.ArrayList;
import java.util.Date;

public class Star {
	
	private int id;
	private String first_name;
	private String last_name;
	private String dob;
	private String photo_url;
	private ArrayList<Movie> starred_in = null;


	public Star(int id, String first_name, String last_name, String dob, String photo_url,
			ArrayList<Movie> starred_in) {
		super();
		this.id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.dob = dob;
		this.photo_url = photo_url;
		this.starred_in = starred_in;
	}

	public Star(int id, String first_name, String last_name, String dob, String photo_url) {
		super();
		this.id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.dob = dob;
		this.photo_url = photo_url;
	}
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getFirst_name() {
		return first_name;
	}


	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}


	public String getLast_name() {
		return last_name;
	}


	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}


	public String getDob() {
		return dob;
	}


	public void setDob(String dob) {
		this.dob = dob;
	}


	public String getPhoto_url() {
		return photo_url;
	}


	public void setPhoto_url(String photo_url) {
		this.photo_url = photo_url;
	}
	

	public ArrayList<Movie> getStarred_in() {
		return starred_in;
	}

	public void setStarred_in(ArrayList<Movie> starred_in) {
		this.starred_in = starred_in;
	}
	
	public String getName()
	{
		return first_name + " " + last_name;
	}
	
}
