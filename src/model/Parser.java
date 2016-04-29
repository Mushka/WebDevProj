package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;

import org.xml.sax.helpers.DefaultHandler;

public class Parser extends DefaultHandler{
	
	List<Movie> myMovies;
	HashSet<String> myGenres;
	int lnCount = 1;

	
	private String tempVal;
	private Movie tempMovie;
	private ArrayList<String> tempGenre;
	
	public Parser(){
		this.myMovies = new ArrayList<Movie>(); 
		this.myGenres = new HashSet<String>();
	}
	
	public void runParser(){
		parseDocument();
		printMovies();
		printGenres();
	}
	
	public void parseDocument(){
		//get a factory
		SAXParserFactory spf = SAXParserFactory.newInstance();
		try {
		
			//get a new instance of parser
			SAXParser sp = spf.newSAXParser();
			
			//parse the file and also register this class for call backs
			sp.parse("/home/josh/Documents/122B_Movie_Sources/mains243.xml", this);
			
		}catch(SAXException se) {
			se.printStackTrace();
		}catch(ParserConfigurationException pce) {
			pce.printStackTrace();
		}catch (IOException ie) {
			ie.printStackTrace();
		}
	}
	
	public void printMovies(){
		System.out.println("No of Movies '" + myMovies.size() + "'.");
		Iterator it = myMovies.iterator();
		int counter = 1;
		while(it.hasNext()) {
			Movie temp = (Movie) it.next();
			if(temp.getYear() == 1111){
				System.out.println("" + counter++ + " "+ temp.toString());
			}
		}
	}
	public void printGenres(){
		System.out.println("\nNo of Genres '" + myGenres.size() + "'.");
		ArrayList<String> allGenres = new ArrayList<String>();
		for(String s : myGenres)
			allGenres.add(s);
		Collections.sort(allGenres);
		for(String s : allGenres){
			System.out.println(s);
		}
	}
	
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		//reset
		tempVal = "";
		if(qName.equalsIgnoreCase("film")) {
			tempMovie = new Movie(0,"",0,"","","" );
		}
		if(qName.equalsIgnoreCase("cats")){
			tempGenre = new ArrayList<String>();
		}
	}
	public void characters(char[] ch, int start, int length) throws SAXException {
		tempVal = new String(ch,start,length);
	}

	public void endElement(String uri, String localName, String qName) throws SAXException {
		if(qName.equalsIgnoreCase("cats")){
			tempMovie.setGenres(tempGenre);
			addGenres(tempGenre);
			tempGenre.clear();
		}if(qName.equalsIgnoreCase("film")) {
			//add it to the list
			myMovies.add(tempMovie);
			
		//This add	
			
		//id, title, year, director, banner_url, trailer_url, stars, genre
		//id is unneeded when entered in the database, and is created upon insertion
		}else if(qName.equalsIgnoreCase("t")){
			tempMovie.setTitle(tempVal.trim());
		}else if(qName.equalsIgnoreCase("year")){
			try{
				tempMovie.setYear(Integer.parseInt(tempVal.trim()));
			}catch(Exception e){
				System.out.println(lnCount++ +" "+e.getMessage() + tempMovie.getTitle());
				tempMovie.setYear(9999);
			}
		}else if (qName.equalsIgnoreCase("dirn")) {
			tempMovie.setDirector(tempVal.trim());
		}else if (qName.equalsIgnoreCase("cat")){
			tempGenre.add(tempVal.trim());
		}
		
	}
	public void addGenres(ArrayList<String> genres){
		for(String s : genres){
			if(!myGenres.contains(s))
				myGenres.add(s);
		}
	}

	public static void main(String[] args) {
		Parser spe = new Parser();
		spe.runParser();
	}

}
