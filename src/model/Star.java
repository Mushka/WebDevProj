package model;

import java.util.ArrayList;
import java.lang.StringBuilder;

public class Star {
	
	private int id;
	private String first_name;
	private String last_name;
	private String full_name;
	private String dob;
	private String photo_url;
	private ArrayList<Movie> starred_in = null;

	public Star() {
		super();
		this.id = -1;
		this.first_name = null;
		this.last_name = null;
		this.dob = null;
		this.photo_url = null;
		this.starred_in = null;
	}	

	public Star(int id, String first_name, String last_name, String dob, String photo_url,
			ArrayList<Movie> starred_in) {
		super();
		this.id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.dob = dob;
		this.photo_url = photo_url;
		this.starred_in = starred_in;
		
		this.full_name = getName();
	}

	public Star(int id, String first_name, String last_name, String dob, String photo_url) {
		super();
		this.id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.dob = dob;
		this.photo_url = photo_url;
		
		this.full_name = getName();
	}
	
	public String toString(){
		StringBuilder starInfo = new StringBuilder();
		starInfo.append(this.id + " ");
		starInfo.append(this.first_name + " ");
		starInfo.append(this.last_name + " ");
		starInfo.append("" + this.dob + " ");
		starInfo.append(this.photo_url + "\n");
		if(null != starred_in){
			starInfo.append("Starred in:\n");
			for(Movie s : starred_in)
				starInfo.append(s.toString() + "\n");
		}
		return starInfo.toString();
	}
	
	public void addToStarred_in(Movie m){
		if(null != starred_in){
			starred_in.add(m);
		}
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
		this.full_name = getName();
	}


	public String getLast_name() {
		return last_name;
	}


	public void setLast_name(String last_name) {
		this.last_name = last_name;
		this.full_name = getName();
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
