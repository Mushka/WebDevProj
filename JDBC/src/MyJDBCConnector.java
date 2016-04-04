import java.sql.*;
import java.util.Scanner;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class MyJDBCConnector
{

	private static String user = "";
	private static String password = "";

	public static String getColumnTypeString(int columnType)
	{

		// according to: http://docs.oracle.com/javase/6/docs/api/constant-values.html#java.sql.Types.TIME

		switch(columnType)
		{
			case 4: 
				return "Integer";		
			case 12:
				return "Varchar";
			case 91:
				return "Date";
			default:
				return "Unknown";
		}
	}

	public static void processCommand(String command) throws Exception
	{
		
		try{

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);
			Statement selectStmt = db_connection.createStatement();

			if(command.toLowerCase().startsWith("select"))
			{
				ResultSet results = selectStmt.executeQuery(command);

				ResultSetMetaData metadata = results.getMetaData();

				System.out.println();

				while(results.next()){

					for(int i = 1; i <= metadata.getColumnCount(); ++i)
						System.out.println(metadata.getColumnName(i) + ": " + results.getObject(i).toString());
					System.out.println();
				}

				results.close();
			}
			else if(command.toLowerCase().startsWith("update"))
			{
				//do update 
			}
			else if(command.toLowerCase().startsWith("insert"))
			{
				//do insert
			}
			else if(command.toLowerCase().startsWith("delete"))
			{
				//do delete
			}

			else
			{
				System.out.println("Invalid SQL Command.");
			}

			selectStmt.close();
			db_connection.close();
		}
		catch (Exception e)
		{
			System.out.println("Invalid SQL Command.");
		}

	}

	// public static List<Map<String, Object>> select (String table)
	public static void deleteCustomerViaCC(String creditcard) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Connect to the test database
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);

		// create update DB statement -- deleting second record of table; return status
		Statement update = db_connection.createStatement();
		int retID = update.executeUpdate("delete from customers where cc_id = \"" + creditcard + "\"");
		System.out.println("retID = " + retID);

		update.close();
		db_connection.close();
	}
	public static void 	insertStar(String first_name, String last_name, String dob, String photo_url) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Connect to the test database
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);

		// create update DB statement -- deleting second record of table; return status
		Statement update = db_connection.createStatement();

		int retID = update.executeUpdate("INSERT INTO stars (first_name, last_name, date, photo_url)" + 
		"VALUES (\"" + first_name + "\", \"" + last_name + "\", \"" + dob + "\", \"" + photo_url + "\"); ");

		
		// System.out.println("retID = " + retID);


		update.close();
		db_connection.close();
	}

	// this helped: http://tutorials.jenkov.com/jdbc/databasemetadata.html
	public static void getMetaData()  throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Connect to the test database
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);

		// create update DB statement -- deleting second record of table; return status
		DatabaseMetaData databaseMetaData = db_connection.getMetaData();

		// String productName    = databaseMetaData.getDatabaseProductName();
		
		String   catalog          = null;
		String   schemaPattern    = null;
		String   tableNamePattern = null;
		String[] types            = null;
		String   columnNamePattern = null;


		ResultSet tables = databaseMetaData.getTables(catalog, schemaPattern, tableNamePattern, types);

		while(tables.next()) {
		    String tableName = tables.getString(3);
		    System.out.println(tableName+":");

			ResultSet tableMetadata = databaseMetaData.getColumns(catalog, schemaPattern, tableName, columnNamePattern);

			while(tableMetadata.next()){
			    String columnName = tableMetadata.getString(4);
			    int    columnType = tableMetadata.getInt(5);  

				String columnTypeString =  getColumnTypeString(columnType);

			    System.out.println("- " + columnName + ": " + columnTypeString);
			}

			System.out.println();

		}

		db_connection.close();
	}

	public static void insertCustomer(String first_name, String last_name, String cc_id, String address, String email, String password, String date) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);
		Statement update = db_connection.createStatement();

		// NEED TO UPDATE CREDITCARD TABLE FIRST
		// TODO apparently if it doesn't exist in CC then don't add the person; not insert into both!!!!
		int retID = update.executeUpdate("INSERT INTO creditcards (id, first_name, last_name, expiration)" + 
		"VALUES (\"" + cc_id + "\", \"" + first_name + "\", \"" + last_name + "\", \"" + date + "\"); ");

		retID = update.executeUpdate("INSERT INTO customers (first_name, last_name, cc_id, address, email, password)" + 
		"VALUES (\"" + first_name + "\", \"" + last_name + "\", \"" + cc_id + "\", \"" + address + "\", \"" + email + "\", \"" + password + "\"); ");

		update.close();
		db_connection.close();
	}

	public static void getCustomerByCC(String cc_id) throws Exception
	{

		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb",  user, password);
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
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb",  user, password);
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
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb",  user, password);
		Statement selectStmt = db_connection.createStatement();
		ResultSet results = selectStmt.executeQuery(query);

		while(results.next()){
			System.out.println("Star: " + results.getString("first") + " " + results.getString("last") + " Movie: " + results.getString("title"));
		}

		results.close();
		selectStmt.close();
		db_connection.close();
	}

	public static int getInt(String inputToGet, BufferedReader in)
	{

		//nothing uses -2; this is to give an 'invalid response' and stay in the menu; 0 is to quit

		System.out.print("Enter " + inputToGet + ": ");
		int value = -2;
		String input = "";
		try{

		    input = in.readLine();
		    value = Integer.parseInt(input);
		}
		catch(Exception e)
		{
			value = -2;
		}

		return value;
	}

	public static String getString(String inputToGet, BufferedReader in)
	{
		System.out.print("Enter " + inputToGet + ": ");
		String input = "";
		try{
			input = in.readLine();
		}
		catch(Exception e)
		{
			input = "";
		}

		return input;
	}


	public static boolean processOption(int option, BufferedReader in) throws Exception
	{
		switch(option)
		{
			
			case -1:
				System.out.println("Logged out.");
				tryTologin(in);
				break;

			case 0:
				System.out.println("Bye");
				return false;

			case 1:
				int id = getInt("id", in); // e.g. 872003
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
				//implement another menu :( TODO

				first_name = getString("first name", in);
				last_name = getString("last name", in);
				System.out.println();
				
				getMoviesOfStar(first_name, last_name);
				break;

			case 4:
				// TODO If the star has a single name, add it as his last_name and assign an empty string ("") to first_name. HOW?

				first_name = getString("first name", in);
				last_name = getString("last name", in);
				String dob = getString("dob (yyyy-mm-dd) [not required]", in);
				String photo_url = getString("photo url [not required]8", in);

				System.out.println();
				
				insertStar(first_name, last_name, dob, photo_url);
				break;
			case 5:

				first_name = getString("first name", in);
				last_name = getString("last name", in);
				String cc_id = getString("creditcard", in);
				String date = getString("expiration date (yyyy-mm-dd)", in);
				String address = getString("address", in);
				String email = getString("email", in);
				String password = getString("password", in);

				
				insertCustomer(first_name, last_name, cc_id, address, email, password, date);
				System.out.println();				
				break;
			case 6:

				cc_id = getString("creditcard", in);
				deleteCustomerViaCC(cc_id);
				System.out.println();				
				break;

			case 7:

				cc_id = getString("creditcard", in);
				getCustomerByCC(cc_id);
				System.out.println();				
				break;
			case 8:

				getMetaData();
				break;

			case 9:
				String command = getString("SQL Command", in);				
				processCommand(command);
				break;

			default:
				System.out.println("Invalid Response. Try again.");

		}

		return true;
	}

	public static int getresponse(BufferedReader in)
	{
		System.out.print("Input: ");
		

		int value = 0;
		String input = "";

		try{
			input = in.readLine();
			value = Integer.parseInt(input);
		}
		catch(Exception e)
		{
			value = -2;
		}

		System.out.println("");

		if(value != -1 && value != -2)
			System.out.println("Output: ");

		return value;
	}

	public static void printMenu()
	{
		System.out.println("\nOPTIONS:");
		System.out.println(" 1: Search by ID");
		System.out.println(" 2: Search by first and last name:");
		System.out.println(" 3: Search by first or last name");
		System.out.println(" 4: Insert a new star into the database");
		System.out.println(" 5: Insert customer into the database");
		System.out.println(" 6: Delete customer by creditcard");
		System.out.println(" 7: View customer by creditcard");
		System.out.println(" 8: View database metadata");
		System.out.println(" 9: SQL Command");


		System.out.println(" 0: Quit Program");
		System.out.println("-1: Logout");

	}

	public static boolean databaseStatus() throws Exception
	{
   		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
	   		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb");
			db_connection.close();
		}
		catch (SQLException e) 
		{
			if(e.toString().contains("com.mysql.jdbc.CommunicationsException"))
			{
				System.out.println("Database offline.");
				return false;
			}
		}

		return true;
	}

	public static boolean login(BufferedReader in) throws Exception
	{
		System.out.println("\nLogin:");

		user = getString("user", in);
		password = getString("password", in);

   		System.out.println("");

   		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
	   		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);
			db_connection.close();
		}
		catch (SQLException e) //this is the only exception that gets thrown
		{
			if(e.toString().contains("com.mysql.jdbc.CommunicationsException"))
				System.out.println("Database offline.");
			else if(e.toString().contains("Access denied"))
				System.out.println("Invalid Credentials. ");
			else
				System.out.println("Unknown Error.");
			return false;

		}

		return true;
	}

	public static void tryTologin(BufferedReader in) throws Exception
	{
		
		while(true)
		{
			if(login(in))
			{
				System.out.println("Logged in.");
				return;
			}
		}

	}



	public static void main(String [] args) throws Exception
	{

		if(!databaseStatus())
			return;

		BufferedReader inp = new BufferedReader (new InputStreamReader(System.in));

		tryTologin(inp);

		boolean running = true;
		// System.out.println("Welcome to the Movie DB.");
		while(running){

			printMenu();
			int option = getresponse(inp);
			running = processOption(option, inp);
		}

    	inp.close();
		

	}


	// QUESTIONS:
	// 1)  If the customer has a single name, add it as his last_name and assign an empty string ("") to first_name.
	// 	- They input each name 
	// 2) 


}
