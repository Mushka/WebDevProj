package model;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map.Entry;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;

import org.xml.sax.helpers.DefaultHandler;

public class Parser extends DefaultHandler{
	
	
	private HashMap<String, Movie> myMovies;
	private HashSet<String> myGenres;
	private HashMap<String, Star> myStars;
	private HashSet<String> duplicateMovieActorChecker;

	private String movieFile;
	private String starFile;
	private String castFile;
	
	private XMLtype type;
	
	private String tempVal;
	private Movie tempMovie;
	private Star tempStar;
	private ArrayList<String> tempGenre;
	
	private String tempTitle;
	private String tempActor;
	
	public Parser(String f, boolean printToConsole){
		this.movieFile = f;
		this.starFile = "";
		this.castFile = "";
		this.type = XMLtype.Movies;
		this.myMovies = new HashMap<String,Movie>(); 
		this.myGenres = new HashSet<String>();
		runParser(printToConsole);
	}
	
	public Parser(String fileNameMovies, String fileNameStars, String fileNameCast, boolean printToConsole){
		this.movieFile = fileNameMovies;
		this.starFile = fileNameStars;
		this.castFile = fileNameCast;
		this.type = XMLtype.Movies;
		this.myMovies = new HashMap<String,Movie>(); 
		this.myGenres = new HashSet<String>();
		this.myStars = new HashMap<String, Star>(); 
		this.duplicateMovieActorChecker = new HashSet<String>();
		runParser(printToConsole);
	}
	
	public void runParser(boolean print){
		parseDocument();
		removeStarsWithoutMovies();
		if(print){
			if(this.type == XMLtype.Movies){
				printMovies();
				printGenres();
			}else{
				printStars();
			}
		}
	}
	
	public void parseDocument(){
		//get a factory
		SAXParserFactory spf = SAXParserFactory.newInstance();
		try {
		
			//get a new instance of parser
			SAXParser sp = spf.newSAXParser();
			//parse the file and also register this class for call backs
			sp.parse(this.movieFile, this);
			if(!("".equals(starFile))){
				this.type = XMLtype.Stars;
				sp.parse(this.starFile, this);
			}
			if(!("".equals(castFile))){
				this.type = XMLtype.Cast;
				sp.parse(this.castFile, this);
			}
			
		}catch(SAXException se) {
			se.printStackTrace();
		}catch(ParserConfigurationException pce) {
			pce.printStackTrace();
		}catch (IOException ie) {
			ie.printStackTrace();
		}
	}
	//Completely for error checking
	public void printMovies(){
		System.out.println("No of Movies '" + myMovies.size() + "'.");
		ArrayList<String> allMovies = new ArrayList<String>();
		for(Entry<String, Movie> s : myMovies.entrySet()) {
			allMovies.add(s.getValue().toString());
		}
		Collections.sort(allMovies, String.CASE_INSENSITIVE_ORDER);
		for(String s : allMovies)
			System.out.println(s);
	}
	public void printGenres(){
		System.out.println("\nNo of Genres '" + myGenres.size() + "'.");
		ArrayList<String> allGenres = new ArrayList<String>();
		for(String s : myGenres)
			allGenres.add(s);
		Collections.sort(allGenres, String.CASE_INSENSITIVE_ORDER);
		for(String s : allGenres){
			System.out.println(s);
		}
	}
	public void printStars(){
		System.out.println("\nNo of Stars '" + myStars.size() + "'.");
		ArrayList<String> allStars = new ArrayList<String>();
		for(Entry<String, Star> s : myStars.entrySet()) {
			allStars.add(s.getValue().toString());
		}
		Collections.sort(allStars, String.CASE_INSENSITIVE_ORDER);
		for(String s : allStars)
			System.out.println(s);
	}
	//Some actors are in the actor database but have no roles
	public void removeStarsWithoutMovies(){
		ArrayList<String> actorsToRemove = new ArrayList<String>();
		for(Entry<String, Star> s : myStars.entrySet()) {
			if(s.getValue().getStarred_in() == null)
				actorsToRemove.add(s.getKey());
		}
		for(String s : actorsToRemove)
			myStars.remove(s);
	}

	//used to check beginning tag and allocate space approprately 
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		//reset
		tempVal = "";
		if(this.type == XMLtype.Movies){
			if(qName.equalsIgnoreCase("film"))
				tempMovie = new Movie(0,"",0,"","","" );
			if(qName.equalsIgnoreCase("cats"))
				tempGenre = new ArrayList<String>();
		}else if(this.type == XMLtype.Stars){
			if(qName.equalsIgnoreCase("actor"))
				tempStar = new Star(0, "", "", "", "");
		}
	}
	
	//temp value buffer which gets changed during every tag iteration
	public void characters(char[] ch, int start, int length) throws SAXException {
		tempVal = new String(ch,start,length);
	}

	//finds closing tag and checks it enters it in the appropriate data structure
	public void endElement(String uri, String localName, String qName) throws SAXException {
		if(this.type == XMLtype.Movies){
			movieEndElement(qName);
		}else if(this.type == XMLtype.Stars){
			starEndElement(qName);
		}else{
			castEndElement(qName);
		}
	}
	
	public void movieEndElement(String movieTag){
		//id is unneeded when entered in the database, and is created upon insertion
		switch(movieTag.toLowerCase()){
			case "cats":
				tempMovie.setGenres(tempGenre);
				addGenres(tempGenre);
				tempGenre.clear();
				break;
			case "film":
				myMovies.put(tempMovie.getTitle().toLowerCase().trim(), tempMovie);
				break;
			case "t":
				tempMovie.setTitle(tempVal.trim());
				break;
			case "year":
				try{ tempMovie.setYear(Integer.parseInt(tempVal.trim()));}
				catch(Exception e){ tempMovie.setYear(9999); }
				break;
			case "dirn" :
				tempMovie.setDirector(tempVal.trim());
				break;
			case "cat":
				tempGenre.add(tempVal.trim());
				break;
		}
	}
	public void starEndElement(String starTag){
		if(starTag.equalsIgnoreCase("actor"))
			myStars.put(tempStar.getName().toLowerCase().trim(), tempStar);
		else if(starTag.equalsIgnoreCase("firstname"))
			tempStar.setFirst_name(tempVal.trim());
		else if(starTag.equalsIgnoreCase("familyname"))
			tempStar.setLast_name(tempVal.trim());
		else if(starTag.equalsIgnoreCase("dob"))
			tempStar.setDob(tempVal.trim());
	}
	//matches movies with their stars if they exist, if they do it fixes it in the star hash
	public void castEndElement(String castTag){
		if(castTag.equalsIgnoreCase("t")){
			tempTitle = tempVal.toLowerCase().trim();
		}else if(castTag.equalsIgnoreCase("a")){
			tempActor = tempVal.toLowerCase().trim();
			if(!duplicateMovieActorChecker.contains(tempTitle + " " + tempActor)){
				duplicateMovieActorChecker.add(tempTitle + " " + tempActor);
				if((myStars.containsKey(tempActor))&&(myMovies.containsKey(tempTitle))){
					Star starFixer = myStars.get(tempActor);
					if(starFixer.getStarred_in() == null)
						starFixer.setStarred_in(new ArrayList<Movie>());
					starFixer.addToStarred_in(myMovies.get(tempTitle));
					myStars.put(tempActor, starFixer);
				}
			}
		}
	}
	//adds genres so no repeat genres
	public void addGenres(ArrayList<String> genres){
		for(String s : genres){
			if(!myGenres.contains(s))
				myGenres.add(s);
		}
	}
	//meant for printing what is in the data structures
	public void printLogFile(String fileLoc){
		System.out.println("Attempting to write Log File");
		try {			
			File file = new File(fileLoc);
			if (!file.exists()) 
				file.createNewFile();
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(getContent());
			bw.close();
			System.out.println("Successfully wrote to file at : " + fileLoc);

		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Could not write to file");
		}
	}
	public String getContent(){
		StringBuilder content = new StringBuilder();
		//GETS ALL MOVIE CONTENT 
		content.append("MOVIES---------------------------------------------------------------------------------------------------------------------------------------\n");
		content.append("No of Movies '" + myMovies.size() + "'.\n");
		ArrayList<String> allMovies = new ArrayList<String>();
		for(Entry<String, Movie> s : myMovies.entrySet()) {
			allMovies.add(s.getValue().toString());
		}
		Collections.sort(allMovies, String.CASE_INSENSITIVE_ORDER);
		for(String s : allMovies)
			content.append(s+"\n");
		
		//GETS ALL STAR CONTENT
		content.append("STARS----------------------------------------------------------------------------------------------------------------------------------------\n");
		content.append("\nNo of Stars '" + myStars.size() + "'.\n");
		ArrayList<String> allStars = new ArrayList<String>();
		for(Entry<String, Star> s : myStars.entrySet()) {
			allStars.add(s.getValue().toString());
		}
		Collections.sort(allStars, String.CASE_INSENSITIVE_ORDER);
		for(String s : allStars)
			content.append(s+"\n");
		
		//GETS ALL GENRES
		content.append("GENRES---------------------------------------------------------------------------------------------------------------------------------------\n");
		content.append("\nNo of Genres '" + myGenres.size() + "'.\n");
		ArrayList<String> allGenres = new ArrayList<String>();
		for(String s : myGenres)
			allGenres.add(s);
		Collections.sort(allGenres, String.CASE_INSENSITIVE_ORDER);
		for(String s : allGenres){
			content.append(s+"\n");
		}		
		return content.toString();
	}
	
	//HOW TO USE PARSER
	public static void main(String[] args) {
		String mFile = "/home/josh/Documents/122B_Movie_Sources/mains243.xml";
		String sFile = "/home/josh/Documents/122B_Movie_Sources/actors63.xml";
		String cFile = "/home/josh/Documents/122B_Movie_Sources/casts124.xml";
		
		long startTime = System.currentTimeMillis();
		
		//Parser spe = new Parser(mFile, true);
		Parser spe = new Parser(mFile, sFile, cFile, true);
		
		long estimatedTime = System.currentTimeMillis() - startTime;
		System.out.println("time: " + estimatedTime/1000.0 + " secs");
		
		spe.printLogFile("/home/josh/Documents/122B_Movie_Sources/results.txt");

	}

}
