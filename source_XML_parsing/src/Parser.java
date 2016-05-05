import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Map.Entry;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;


import org.xml.sax.Attributes;
import org.xml.sax.SAXException;

import org.xml.sax.helpers.DefaultHandler;

import java.sql.*;

public class Parser extends DefaultHandler{
	
	
	private HashMap<String, Movie> myMovies;
	private HashMap<String, String> myMovieIds;
	private HashMap<String, String> myGenresIds;
	private HashMap<String, Star> myStars;
	private HashMap<String, String> myStarIds;
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
	private String tempDirector;
	
	private boolean checker = false;
	
	private Connection dbcon = null;
	
	public Parser(String f, boolean printToConsole){
		this.movieFile = f;
		this.starFile = "";
		this.castFile = "";
		this.type = XMLtype.Movies;
		this.myMovies = new HashMap<String,Movie>(); 
		this.myMovieIds = new HashMap<String, String>();
		this.myGenresIds = new HashMap<String, String>();
		runParser(printToConsole);
	}
	
	public Parser(String fileNameMovies, String fileNameStars, String fileNameCast, boolean printToConsole){
		this.movieFile = fileNameMovies;
		this.starFile = fileNameStars;
		this.castFile = fileNameCast;
		this.type = XMLtype.Movies;
		this.myMovies = new HashMap<String,Movie>(); 
		this.myMovieIds = new HashMap<String, String>();
		this.myGenresIds = new HashMap<String, String>();
		this.myStars = new HashMap<String, Star>(); 
		this.myStarIds = new HashMap<String, String>();
		this.duplicateMovieActorChecker = new HashSet<String>();
		runParser(printToConsole);
	}
	
	public void runParser(boolean print){
		parseDocument();
		//removeStarsWithoutMovies();
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
		System.out.println("\nNo of Genres '" + myGenresIds.size() + "'.");
		ArrayList<String> allGenres = new ArrayList<String>();
		for(Entry<String, String> s : myGenresIds.entrySet())
			allGenres.add(s.getKey());
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
		for(String s : actorsToRemove){
			myStars.remove(s);
			myStarIds.remove(s);
		}
	}

	//used to check beginning tag and allocate space approprately 
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		//reset
		tempVal = "";
		if(this.type == XMLtype.Movies){
			if(qName.equalsIgnoreCase("film")){
				tempMovie = new Movie(0,"",0,"","","" );
				checker = true;
			}
			if(qName.equalsIgnoreCase("cats"))
				tempGenre = new ArrayList<String>();
		}else if(this.type == XMLtype.Stars){
			if(qName.equalsIgnoreCase("actor"))
				tempStar = new Star(0, "", "", "", "");
		}
	}
	
	//temp value buffer which gets changed during every tag iteration
	public void characters(char[] ch, int start, int length) throws SAXException {
		tempVal += new String(ch,start,length);
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
				if(!myMovies.containsKey(tempMovie.getTitle().toLowerCase().trim() + " " + tempMovie.getDirector().toLowerCase().trim()))
					tempMovie.setGenres(tempGenre);
				else{
					Movie movieFixer = myMovies.get(tempMovie.getTitle().toLowerCase().trim() + " " + tempMovie.getDirector().toLowerCase().trim());
					if(movieFixer.getGenres() == null)
						movieFixer.setGenres(new ArrayList<String>());
					for(String s : tempGenre){
						//System.out.println(tempMovie.getTitle() + " " + s);
						movieFixer.addToGenres(s);
					}
					myMovies.put(tempMovie.getTitle().toLowerCase().trim()+ " " + tempMovie.getDirector().toLowerCase().trim(), movieFixer);
				}
				fixGenres(tempGenre);
				break;
			case "film":
				if(!myMovies.containsKey(tempMovie.getTitle().toLowerCase().trim() + " " + tempMovie.getDirector().toLowerCase().trim()))
					myMovies.put(tempMovie.getTitle().toLowerCase().trim() + " " + tempMovie.getDirector().toLowerCase().trim(), tempMovie);
				myMovieIds.put(tempMovie.getTitle().toLowerCase().trim() + " " + tempMovie.getDirector().toLowerCase().trim(), "0");
				break;
			case "t":
				if(tempVal.contains("'"))
					tempVal =  tempVal.replaceAll("'", "''");
				if(tempVal.contains("\\"))
					tempVal = tempVal.replace("\\","\\\\");
				tempMovie.setTitle(tempVal.trim());
				break;
			case "year":
				try{ tempMovie.setYear(Integer.parseInt(tempVal.trim()));}
				catch(Exception e){ tempMovie.setYear(9999); }
				break;
			case "dirn" :
				if(checker){
					checker = false;
					if(tempVal.contains("'"))
						tempVal =  tempVal.replaceAll("'", "''");
					if(tempVal.contains("\\"))
						tempVal = tempVal.replace("\\","\\\\");
					tempMovie.setDirector(tempVal.trim());
				}
				break;
			case "cat":
				tempGenre.add(tempVal.trim());
				break;
		}
	}
	public void starEndElement(String starTag){
		if(starTag.equalsIgnoreCase("actor")){
			if(tempStar.getDob().trim().equals("")) tempStar.setDob("9999/01/01");
			myStars.put(tempStar.getName().toLowerCase().trim(), tempStar);
			myStarIds.put(tempStar.getName().toLowerCase().trim(),"0");
		}else if(starTag.equalsIgnoreCase("firstname")){
			if(tempVal.contains("'"))
				tempVal =  tempVal.replaceAll("'", "''");
			if(tempVal.contains("\\"))
				tempVal = tempVal.replace("\\","\\\\");
			tempStar.setFirst_name(tempVal.trim());
		}else if(starTag.equalsIgnoreCase("familyname")){
			if(tempVal.contains("'"))
				tempVal =  tempVal.replace("'", "''");
			if(tempVal.contains("\\"))
				tempVal = tempVal.replace("\\","\\\\");
			tempStar.setLast_name(tempVal.trim());
		}else if(starTag.equalsIgnoreCase("dob")){
			if(tempVal.trim().equals(""))
				tempVal = "9999";
			if(tempVal.contains("+"))
				tempVal = tempVal.replace("+", "");
			try{
				int test = Integer.parseInt(tempVal.trim());
				tempStar.setDob(test + "/01/01");
			}
			catch(Exception e){ tempStar.setDob("9999/01/01"); }
		}
	}
	//matches movies with their stars if they exist, if they do it fixes it in the star hash
	public void castEndElement(String castTag){
		if(castTag.equalsIgnoreCase("t")){
			if(tempVal.contains("'"))
				tempVal =  tempVal.replaceAll("'", "''");
			if(tempVal.contains("\\"))
				tempVal = tempVal.replace("\\","\\\\");
			if(tempVal.contains("&"))
				tempVal = tempVal.replace("&", "and");
			tempTitle = tempVal.toLowerCase().trim();
		}else if(castTag.equalsIgnoreCase("a")){
			tempActor = tempVal.toLowerCase().trim();
			if(!duplicateMovieActorChecker.contains(tempTitle + " " + tempDirector + " " + tempActor)){
				duplicateMovieActorChecker.add(tempTitle + " " + tempDirector + " " + tempActor);
				if((myStars.containsKey(tempActor))&&(myMovies.containsKey(tempTitle + " " + tempDirector))){
					Star starFixer = myStars.get(tempActor);
					if(starFixer.getStarred_in() == null)
						starFixer.setStarred_in(new ArrayList<Movie>());
					starFixer.addToStarred_in(myMovies.get(tempTitle+ " " + tempDirector));
					myStars.put(tempActor, starFixer);
				}
			}
		}else if(castTag.equalsIgnoreCase("is")){
			if(tempVal.contains("'"))
				tempVal =  tempVal.replaceAll("'", "''");
			if(tempVal.contains("\\"))
				tempVal = tempVal.replace("\\","\\\\");
			tempDirector = tempVal.toLowerCase().trim();
		}
	}
	
	//fixes duplicates
	public void fixGenres(ArrayList<String> genres){
		for(String s : genres){
			if(!myGenresIds.containsKey(s))
				myGenresIds.put(s, "0");
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
	
	public void printToFile(String fileLoc, String contents){
		System.out.println("Attempting to write Log File");
		try {			
			File file = new File(fileLoc);
			if (!file.exists()) 
				file.createNewFile();
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(contents);
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
		content.append("\nNo of Genres '" + myGenresIds.size() + "'.\n");
		ArrayList<String> allGenres = new ArrayList<String>();
		for(Entry<String, String> s : myGenresIds.entrySet())
			allGenres.add(s.getKey());
		Collections.sort(allGenres, String.CASE_INSENSITIVE_ORDER);
		for(String s : allGenres){
			content.append(s+"\n");
		}		
		return content.toString();
	}
	
	public void insertIntoDataBase() throws Exception{
		String loginUser = Credentials.admin;
		String loginPasswd = Credentials.password;
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb_project3_grading";		
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			this.dbcon = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
		}catch (Exception ex) {
			System.out.println("Cannot connect to the database.");
			System.exit(-1);
		}
		this.dbcon.setAutoCommit(false);
		insertMovies();
		insertStars();
		insertGenres();
		this.dbcon.commit();
		
		this.dbcon.setAutoCommit(false);
		processMoviesAndGenres();
		processStarsInMovies();
		this.dbcon.commit();
	}
	
	public void insertMovies() throws Exception{
		Statement statement = dbcon.createStatement();
		StringBuilder batchInsertQuery = new StringBuilder();
		batchInsertQuery.append("INSERT INTO movies (title, year, director) VALUES");
		for(Movie m : myMovies.values()){
				batchInsertQuery.append(" ('" + m.getTitle() + "', " + m.getYear() + ", '"+ m.getDirector() + "'),\n");
		}
		batchInsertQuery.setCharAt(batchInsertQuery.length()-2, ';');
        statement.executeUpdate(batchInsertQuery.toString());
        statement.close();
	}
	
	public void insertStars() throws Exception{
		Statement statement = dbcon.createStatement();
		StringBuilder batchInsertQuery = new StringBuilder();
		batchInsertQuery.append("INSERT INTO stars (first_name, last_name, dob) VALUES");
		for(Star s : myStars.values())
			batchInsertQuery.append(" ('" + s.getFirst_name() + "', '" + s.getLast_name() + "', '"+ s.getDob() + "'),\n");
		batchInsertQuery.setCharAt(batchInsertQuery.length()-2, ';');
        statement.executeUpdate(batchInsertQuery.toString());
        statement.close();
	}
	public void insertGenres() throws Exception{
		Statement statement = dbcon.createStatement();
		StringBuilder batchInsertQuery = new StringBuilder();
		batchInsertQuery.append("INSERT INTO genres (name) VALUES");
		for(Entry<String, String> s : myGenresIds.entrySet())	
			batchInsertQuery.append(" ('" + s.getKey() + "'),");
		batchInsertQuery.setCharAt(batchInsertQuery.length()-1, ';');
        statement.executeUpdate(batchInsertQuery.toString());
        statement.close();
	}
	public void processMoviesAndGenres() throws SQLException{
		getMovieIds();
		getGenreIds();
		HashSet<String> moviesWithGenresId = matchMoviesWithGenres();
		insertGenresWithMovies(moviesWithGenresId);
	}
	
	public void getMovieIds(){
		ArrayList<Map<String, Object>> results;
		try {
			results = MySQL.select("SELECT * FROM movies;");
		    for (Map<String, Object> row : results){
		        String id = row.get("id").toString();
		        String title = row.get("title").toString();
		        String director = row.get("director").toString();
				if(title.contains("'"))
					title =  title.replaceAll("'", "''");
				if(title.contains("\\"))
					title = title.replace("\\","\\\\");
				if(director.contains("'"))
					director =  director.replaceAll("'", "''");
				if(director.contains("\\"))
					director = director.replace("\\","\\\\");
		        if(myMovieIds.containsKey(title.toLowerCase().trim() + " " + director.toLowerCase().trim()))
		        	myMovieIds.put(title.toLowerCase().trim()+ " " + director.toLowerCase().trim(), id);
		        //else
		        	//System.out.println(title + " " + director + " " + id);
		    }
		}catch (Exception e) {System.out.println("The cluck");}
	}
	
	public void getGenreIds(){
		ArrayList<Map<String, Object>> results;
		try {
			results = MySQL.select("SELECT * FROM genres;");
		    for (Map<String, Object> row : results){
		        String id = row.get("id").toString();
		        String name = row.get("name").toString();
				if(name.contains("'"))
					name =  name.replaceAll("'", "''");
				if(name.contains("\\"))
					name = name.replace("\\","\\\\");
		        if(myGenresIds.containsKey(name.trim()))
		        	myGenresIds.put(name.trim(), id);
		    }
		}catch (Exception e) {System.out.println("The cluck");}
	}
	
	public HashSet<String> matchMoviesWithGenres(){
		HashSet<String> genMovs = new HashSet<String>();
		for(Entry<String, Movie> m : myMovies.entrySet()){
			if(m.getValue().getGenres() != null){
				for(String g : m.getValue().getGenres())
					genMovs.add(myGenresIds.get(g) + "," + myMovieIds.get(m.getKey()));
			}
		}
		return genMovs;
	}
	
	public void insertGenresWithMovies(HashSet<String> genMov) throws SQLException{
		Statement statement = dbcon.createStatement();
		StringBuilder batchInsertQuery = new StringBuilder();
		batchInsertQuery.append("INSERT INTO genres_in_movies (genre_id, movie_id) VALUES");
		for(String s : genMov)
			batchInsertQuery.append(" (" + s + "),\n");
		batchInsertQuery.setCharAt(batchInsertQuery.length()-2, ';');
        statement.executeUpdate(batchInsertQuery.toString());
        statement.close();
	}

	public void processStarsInMovies() throws SQLException{
		getStarIds();
		HashSet<String> starsWithMovieId = matchStarsWithMovies();
		insertStarsWithMovieId(starsWithMovieId);
	}
	
	public void getStarIds(){
		ArrayList<Map<String, Object>> results;
		try {
			results = MySQL.select("SELECT * FROM stars;");
		    for (Map<String, Object> row : results){
		        String id = row.get("id").toString();
		        String name = row.get("first_name").toString().trim();
		        name += " "+ row.get("last_name").toString().trim();
				if(name.contains("'"))
					name =  name.replaceAll("'", "''");
				if(name.contains("\\"))
					name = name.replace("\\","\\\\");
		        if(myStarIds.containsKey(name.toLowerCase().trim()))
		        	myStarIds.put(name.toLowerCase().trim(), id);
		    }
		}catch (Exception e) {System.out.println("The cluck");}
	}
	public HashSet<String> matchStarsWithMovies(){
		HashSet<String> starsMov = new HashSet<String>();
		for(Entry<String, Star> s : myStars.entrySet()){
			if(s.getValue().getStarred_in() != null){
				for(Movie m : s.getValue().getStarred_in())
					starsMov.add(myStarIds.get(s.getKey())+ ", " + myMovieIds.get(m.getTitle().toLowerCase().trim() + " " + m.getDirector().toLowerCase().trim()));
			}
		}
		return starsMov;
	}
	public void insertStarsWithMovieId(HashSet<String> starMov) throws SQLException{
		Statement statement = dbcon.createStatement();
		StringBuilder batchInsertQuery = new StringBuilder();
		batchInsertQuery.append("INSERT INTO stars_in_movies (star_id, movie_id) VALUES");
		for(String s : starMov)
			batchInsertQuery.append(" (" + s + "),\n");
		batchInsertQuery.setCharAt(batchInsertQuery.length()-2, ';');
        statement.executeUpdate(batchInsertQuery.toString());
        statement.close();
	}
	

	//HOW TO USE PARSER
	public static void main(String[] args) {
		String mFile = args[0];
		String sFile = args[1];
		String cFile = args[2];
		
		long startTime = System.currentTimeMillis();
		
		//Can either take a movie file or all 3 XML files, and a boolean if you want to print to console
		//Parser spe = new Parser(mFile, true);
		Parser spe = new Parser(mFile, sFile, cFile, false);
		
		try {
			spe.insertIntoDataBase();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		long estimatedTime = System.currentTimeMillis() - startTime;
		System.out.println("time: " + estimatedTime/1000.0 + " secs");

	}

}
