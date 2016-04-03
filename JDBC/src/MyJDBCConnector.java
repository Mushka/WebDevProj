import java.sql.*;
import java.util.Scanner;

public class MyJDBCConnector
{

	// public static List<Map<String, Object>> select (String table)
	public static void deleteCustomerViaCC(String creditcard) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Connect to the test database
		Connection connection = DriverManager.getConnection("jdbc:mysql:///moviedb","root", "");

		// create update DB statement -- deleting second record of table; return status
		Statement update = connection.createStatement();
		int retID = update.executeUpdate("delete from customers where cc_id = \"" + creditcard + "\"");
		System.out.println("retID = " + retID);
	}

	public static void insertCustomer(String first_name, String last_name, String cc_id, String address, String email, String password) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Connect to the test database
		Connection connection = DriverManager.getConnection("jdbc:mysql:///moviedb","root", "");

		// create update DB statement -- deleting second record of table; return status
		Statement update = connection.createStatement();


		// NEED TO UPDATE CREDITCARD TABLE FIRST
		// 		int retID = update.executeUpdate("INSERT INTO creditcards (id, first_name, last_name, expiration, address, email, password)" + 
		// CREATE TABLE creditcards(
		//     id varchar(20) NOT NULL PRIMARY KEY,
		//     first_name varchar(50) NOT NULL, 
		//     last_name varchar(50) NOT NULL,
		//     expiration date NOT NULL
		// );

		int retID = update.executeUpdate("INSERT INTO customers (first_name, last_name, cc_id, address, email, password)" + 
		"VALUES (\"" + first_name + "\", \"" + last_name + "\", \"" + cc_id + "\", \"" + address + "\", \"" + email + "\", \"" + password + "\"); ");
		System.out.println("retID = " + retID);
	}

	public static void getCustomerByCC(String cc_id) throws Exception
	{

		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "");
		Statement selectStmt = db_connection.createStatement();
		ResultSet results = selectStmt.executeQuery("select * from customers where cc_id = \"" + cc_id + "\"");

		while(results.next()){
			System.out.println("Name: " + results.getString("first_name") + " " + results.getString("last_name") + " CC_ID: " + results.getString("cc_id"));
		}

		results.close();
		selectStmt.close();
		db_connection.close();
	}



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
		System.out.println("4: Insert customer into the database");
		System.out.println("5: Delete customer by creditcard");
		System.out.println("6: View customer by creditcard");

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
			input = 0;
			in.reset();
		}

		System.out.println("");
		System.out.println("Output: ");
		return input;
	}

	public static int getInt(String inputToGet, Scanner in)
	{
		System.out.print("Enter " + inputToGet + ": ");
		int input = -1;
		try{

		    input = in.nextInt();
		}
		catch(Exception e)
		{
			input = -1;
			in.reset();
		}

		return input;
	}

	public static String getString(String inputToGet, Scanner in)
	{
		System.out.print("Enter " + inputToGet + ": ");
		String input = "";
		try{
			input = in.next();
		}
		catch(Exception e)
		{
			input = "";
			in.reset();
		}

		return input;
	}

	public static boolean processOption(int option, Scanner in) throws Exception
	{
		switch(option)
		{
			case 1:

				int id = getInt("id", in); // 872003
				if(id != -1)
					getMoviesOfStar(id);
				else
					System.out.println("Invalid ID");
				break;
			case 2:
				String first_name = getString("first name", in);
				String last_name = getString("last name", in);
				System.out.println();
				
				getMoviesOfStar(first_name, last_name);
				break;
			case 3:
				//implement another menu :( 

				first_name = getString("first name", in);
				last_name = getString("last name", in);
				System.out.println();
				
				getMoviesOfStar(first_name, last_name);
				break;
			case 4:
				//implement another menu :( 

				first_name = getString("first name", in);
				last_name = getString("last name", in);
				String cc_id = getString("creditcard", in);
				String address = getString("address", in);
				String email = getString("email", in);
				String password = getString("password", in);
				
				insertCustomer(first_name, last_name, cc_id, address, email, password);
				System.out.println();				
				break;
			case 5:

				cc_id = getString("creditcard", in);
				deleteCustomerViaCC(cc_id);
				System.out.println();				
				break;

			case 6:

				cc_id = getString("creditcard", in);
				getCustomerByCC(cc_id);
				System.out.println();				
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
			running = processOption(option, in);
		}

		

	}


}
