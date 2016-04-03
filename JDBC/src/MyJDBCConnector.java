import java.sql.*;
import java.util.Scanner;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class MyJDBCConnector
{

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

	// public static List<Map<String, Object>> select (String table)
	public static void deleteCustomerViaCC(String creditcard) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Connect to the test database
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb","root", "");

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
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb","root", "");

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
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb","root", "");

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

		// String   catalog           = null;
		// String   schemaPattern     = null;
		// String   tableNamePattern  = "stars";
		// String   columnNamePattern = null;


		// ResultSet result = databaseMetaData.getColumns(
		//     catalog, schemaPattern,  tableNamePattern, columnNamePattern);

		// while(result.next()){
		//     String columnName = result.getString(4);
		//     int    columnType = result.getInt(5);  

		// 	String columnTypeEnglish =  getColumnTypeString(columnType);

		//     System.out.println("Table: " + tableNamePattern + " | Column name: " + columnName + " | Column type: " + columnTypeEnglish);
		// }

		// update.close();
		db_connection.close();
	}

	public static void insertCustomer(String first_name, String last_name, String cc_id, String address, String email, String password, String date) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Connect to the test database
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb","root", "");

		// create update DB statement -- deleting second record of table; return status
		Statement update = db_connection.createStatement();


		// NEED TO UPDATE CREDITCARD TABLE FIRST

		// 		int retID = update.executeUpdate("INSERT INTO creditcards (id, first_name, last_name, expiration, address, email, password)" + 
		// CREATE TABLE creditcards(
		//     id varchar(20) NOT NULL PRIMARY KEY,
		//     first_name varchar(50) NOT NULL, 
		//     last_name varchar(50) NOT NULL,
		//     expiration date NOT NULL
		// );
		int retID = update.executeUpdate("INSERT INTO creditcards (id, first_name, last_name, expiration)" + 
		"VALUES (\"" + cc_id + "\", \"" + first_name + "\", \"" + last_name + "\", \"" + date + "\"); ");

		retID = update.executeUpdate("INSERT INTO customers (first_name, last_name, cc_id, address, email, password)" + 
		"VALUES (\"" + first_name + "\", \"" + last_name + "\", \"" + cc_id + "\", \"" + address + "\", \"" + email + "\", \"" + password + "\"); ");
		// System.out.println("retID = " + retID);


		update.close();
		db_connection.close();
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
		System.out.println("4: Insert a new star into the database");
		System.out.println("5: Insert customer into the database");
		System.out.println("6: Delete customer by creditcard");
		System.out.println("7: View customer by creditcard");
		System.out.println("8: View database metadata");

		System.out.println("0: Quit");

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
			value = 0;
		}

		System.out.println("");
		System.out.println("Output: ");
		return value;
	}

	public static int getInt(String inputToGet, BufferedReader in)
	{
		System.out.print("Enter " + inputToGet + ": ");
		int value = -1;
		String input = "";
		try{

		    input = in.readLine();
		    value = Integer.parseInt(input);
		}
		catch(Exception e)
		{
			value = -1;
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
				//implement another menu :( TODO

				first_name = getString("first name", in);
				last_name = getString("last name", in);
				System.out.println();
				
				getMoviesOfStar(first_name, last_name);
				break;

			case 4:
				// If the star has a single name, add it as his last_name and assign an empty string ("") to first_name.

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

		// Scanner in = new Scanner(System.in);

		BufferedReader inp = new BufferedReader (new InputStreamReader(System.in));
    	// String x = inp.readLine();
    	// System.out.println("Output: " + x);
		boolean running = true;
		System.out.println("Welcome to the Movie DB.");
		while(running){

			printMenu();
			int option = getresponse(inp);
			running = processOption(option, inp);
		}

    	inp.close();
		

	}


}
