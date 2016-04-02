import java.sql.*;
import java.util.Scanner;

public class MyJDBCConnector
{

	// public static List<Map<String, Object>> select (String table)

	public static void getMoviesOfStar(int id) throws Exception
	{

		String query = 
		"select s.first_name as 'first', s.last_name as 'last', s.id as 'star ID', m.title, m.year, m.director, m.banner_url as 'banner', m.trailer_url as 'trailer', m.id as 'movie ID' " +  
		"from stars_in_movies as sm, stars as s, movies as m " +
		"where sm.star_id = s.id and m.id = sm.movie_id and s.id = " + id + 
		" order by s.first_name, s.last_name, m.title;";

		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "");
		Statement selectStmt = db_connection.createStatement();
		ResultSet results = selectStmt.executeQuery(query);

		while(results.next()){
			System.out.println("Star: " + results.getString("first") + " " + results.getString("last") + " Movie: " + results.getString("title"));
		}

		results.close();
		selectStmt.close();
		db_connection.close();
	}

	public static void getMoviesOfStar(String first_name, String last_name) throws Exception
	{

		String query = 
		"select s.first_name as 'first', s.last_name as 'last', s.id as 'star ID', m.title, m.year, m.director, m.banner_url as 'banner', m.trailer_url as 'trailer', m.id as 'movie ID' " +  
		"from stars_in_movies as sm, stars as s, movies as m " +
		"where sm.star_id = s.id and m.id = sm.movie_id and s.first_name like \"" + first_name + "\"" + " and s.last_name like \"" + last_name + "\"" +
		" order by s.first_name, s.last_name, m.title;";

		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "");
		Statement selectStmt = db_connection.createStatement();
		ResultSet results = selectStmt.executeQuery(query);

		while(results.next()){
			System.out.println("Star: " + results.getString("first") + " " + results.getString("last") + " Movie: " + results.getString("title"));
		}

		results.close();
		selectStmt.close();
		db_connection.close();
	}


	public static void printMenu()
	{
		System.out.println("\nOPTIONS:");
		System.out.println("1: Search by ID");
		System.out.println("2: Search by first and last name:");
		System.out.println("3: Search by first or last name");
		System.out.println("0: Quit");

	}

	public static int getresponse(Scanner in)
	{
		System.out.print("Input: ");
		

		int input = 0;

		try{
			input = in.nextInt();
		}
		catch(Exception e)
		{
			//input = 0;
		}


		System.out.println("");
		System.out.println("Output: ");
		return input;
	}

	public static boolean processOption(int option) throws Exception
	{
		switch(option)
		{
			case 1:
				getMoviesOfStar(872003);
				break;
			case 2:
				getMoviesOfStar("Bruce", "Willis");
				break;
			case 3:
				getMoviesOfStar("Bruce", "Willis");
				break;
			default:
				System.out.println("Bye");
				return false;
		}

		return true;
	}

	public static void main(String [] args) throws Exception
	{
		// Class.forName("com.mysql.jdbc.Driver").newInstance();
		// Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "");
		// Statement selectStmt = db_connection.createStatement();
		// ResultSet results = selectStmt.executeQuery("select * from stars;");

		// while(results.next()){
		// 	System.out.println("Star: " + results.getString("first_name") + " " + results.getString("last_name"));
		// }

		// results.close();
		// selectStmt.close();
		// db_connection.close();

		// getMoviesOfStar(872003);
		// getMoviesOfStar("Bruce", "Willis");

		Scanner in = new Scanner(System.in);
		boolean running = true;
		System.out.println("Welcome to the Movie DB.");
		while(running){

			printMenu();
			int option = getresponse(in);
			running = processOption(option);
		}

		

	}


}
