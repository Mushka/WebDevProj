import java.sql.*;
import java.util.Scanner;
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class MyJDBCConnector
{

	private static String user = "";
	private static String password = "";

	public static void insertIntoTable(String tableName, BufferedReader in) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);
		DatabaseMetaData databaseMetaData = db_connection.getMetaData();
		
		String catalog = null;
		String schemaPattern = null;
		String columnNamePattern = null;
		String[] types = null;

		ResultSet tableMetadata = databaseMetaData.getColumns(catalog, schemaPattern, tableName, columnNamePattern);

		ArrayList<String> cols = new ArrayList<String>();
		ArrayList<Object> values = new ArrayList<Object>();
		ArrayList<Integer> type = new ArrayList<Integer>();

		while(tableMetadata.next())
		{
		    String columnName = tableMetadata.getString(4);
		    int    columnType = tableMetadata.getInt(5); 

		    //this checks to see if it auto increment is on, if it is, skip this column. 
		    // according to (under getAttributes): https://docs.oracle.com/javase/7/docs/api/java/sql/DatabaseMetaData.html 
		    if(tableMetadata.getString(23).equalsIgnoreCase("yes"))
		    	continue; 

		    //this checks to see if it can be not NULL. 
		    String required = "";
		    if(tableMetadata.getString(18).equalsIgnoreCase("yes"))
		    	required = " [not required]";
			
			cols.add(columnName);
			type.add(columnType);

			String inputString = "";
			int intInt = 0;
		
			switch(columnType)
			{
				case 4: 
					intInt = getInt(columnName + required, in);
					values.add(intInt);
					break;
				case 12:
					inputString = getString(columnName+ required, in);
					values.add(inputString);
					break;
				case 91:
					inputString = getString(columnName + " (yyyy-mm-dd)" + required, in);
					values.add(inputString);
					break;
			}
		}

		// we are going to build up a query string. I did it this way because it is general and works for any table in any schema. 

		String query = "insert into " + tableName + " (";


		// this is the cols to insert into
		for(int i = 0; i < cols.size(); ++i)
			query += (i < cols.size()-1) ? cols.get(i) + ", " : cols.get(i);

		query += ") values (";

		// this part satisfies the constraint: "If the [tables] has a single name, add it as his last_name and assign an empty string ("") to first_name."

		String first_name = "";
		String last_name = "";

		for(int i = 0; i < values.size(); ++i)
		{

			String value = values.get(i).toString();

			if("first_name".equals(cols.get(i)))
				first_name = value;

			if("last_name".equals(cols.get(i)))
				last_name = value;
		}

		if("".equals(first_name) && "".equals(last_name))
		{
			first_name = null;
			last_name = null;
		}
		else if("".equals(first_name))
		{
			// nothing is needed because single named is already in last name
		}
		else if("".equals(last_name))
		{
			last_name=first_name;
			first_name="";
		}

		// this is the values for the cols we mentioned above
		for(int i = 0; i < values.size(); ++i)
		{

			if(type.get(i) == 4)
			{
				query += (i < values.size()-1) ? (int) values.get(i) + ", " : (int) values.get(i);
			}
			else if (type.get(i) == 12 || type.get(i) == 91)
			{

				String value = (String) values.get(i);

				if("first_name".equals(cols.get(i)))
				{
					if(first_name == null)
						query += (i < values.size()-1) ? "NULL" + ", " :  "NULL";
					else
						query += (i < values.size()-1) ? "\"" + first_name + "\"" + ", " :  "\"" + first_name + "\"";
				}

				else if("last_name".equals(cols.get(i)))
				{
					if(last_name == null)
						query += (i < values.size()-1) ? "NULL" + ", " :  "NULL";
					else
						query += (i < values.size()-1) ? "\"" + last_name + "\"" + ", " :  "\"" + last_name + "\"";
				}

				else
				{
					if("".equals(value))
						query += (i < values.size()-1) ? "NULL" + ", " :  "NULL";
					else
						query += (i < values.size()-1) ? "\"" + value + "\"" + ", " :  "\"" + value + "\"";
				}
			}
		}

		query += ");";

		db_connection.close();

		processUpdateInsertDelete("Insert", query);
	}


	public static void processSelect(String command) throws Exception
	{
		try
		{

			System.out.println("Processing: " + command);

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);
			Statement selectStmt = db_connection.createStatement();
			ResultSet results = selectStmt.executeQuery(command);
			ResultSetMetaData metadata = results.getMetaData();

			System.out.println();

			boolean empty = true;

			while(results.next()){

				empty = false;

				for(int i = 1; i <= metadata.getColumnCount(); ++i)
				{
					String output = metadata.getColumnName(i) + ": ";

					if(results.getObject(i) != null)
						output += results.getObject(i).toString();
					else
						output += "NULL";

					System.out.println(output);
				}

				System.out.println();
			}

			results.close();
			selectStmt.close();
			db_connection.close();

			if(empty)
				System.out.println("Nothing found.");
			
		} catch (Exception e)
		{
			System.out.println("Invalid SQL Command.\n\n" + e.toString());
		}
	}

	public static void processUpdateInsertDelete(String type, String command) throws Exception
	{
		try
		{

			System.out.println("Processing: " + command);

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);
			Statement update = db_connection.createStatement();

			int n = update.executeUpdate(command); 

			update.close();
			db_connection.close();

			System.out.println(type + " Successful. Rows Affected: " + n);

			
		} catch (Exception e)
		{

			if(e.toString().contains("FOREIGN KEY (`cc_id`) REFERENCES `creditcards` (`id`)"))
				System.out.println("Invalid SQL Command: Creditcard not in database.");
			else
				System.out.println("Invalid SQL Command.\n\n" + e.toString());
		}
	}

	public static void processCommand(String command) throws Exception
	{
		
		if(command.toLowerCase().startsWith("select"))
		{
			processSelect(command);
		}
		else if(command.toLowerCase().startsWith("update"))
		{
			processUpdateInsertDelete("Update", command);
		}
		else if(command.toLowerCase().startsWith("insert"))
		{
			processUpdateInsertDelete("Insert", command);
		}
		else if(command.toLowerCase().startsWith("delete"))
		{
			processUpdateInsertDelete("Delete", command);
		}
		else
		{
			System.out.println("Invalid SQL Command.");
		}

	}

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

	// this helped: http://tutorials.jenkov.com/jdbc/databasemetadata.html
	public static void getMetaData()  throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);
		DatabaseMetaData databaseMetaData = db_connection.getMetaData();
		
		String catalog = null;
		String schemaPattern = null;
		String tableNamePattern = null;
		String[] types = null;
		String columnNamePattern = null;

		ResultSet tables = databaseMetaData.getTables(catalog, schemaPattern, tableNamePattern, types);

		while(tables.next()) {
		    String tableName = tables.getString(3);
		    System.out.println(tableName+":");

			ResultSet tableMetadata = databaseMetaData.getColumns(catalog, schemaPattern, tableName, columnNamePattern);

			while(tableMetadata.next()){
			    String columnName = tableMetadata.getString(4);
			    int    columnType = tableMetadata.getInt(5);  

				String columnTypeString = getColumnTypeString(columnType);

			    System.out.println("- " + columnName + ": " + columnTypeString);
			}

			System.out.println();

		}

		db_connection.close();
	}

	public static void tryToLoginCustomer(String email, String user_pass) throws Exception
	{
		String query = "select * from customers where email like '"+email+"' and password like '"+user_pass+"'";

		try
		{

			// System.out.println("Processing: " + command);

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", user, password);
			Statement selectStmt = db_connection.createStatement();
			ResultSet results = selectStmt.executeQuery(query);
			ResultSetMetaData metadata = results.getMetaData();

			System.out.println();

			boolean empty = true;

			String user_name = "";

			while(results.next()){

				empty = false;

				user_name = results.getString("first_name");

				break;
			}

			results.close();
			selectStmt.close();
			db_connection.close();

			if(empty)
				System.out.println("Invalid Credentials. ");
			else
				System.out.println("Welcome "+ user_name + ".");				
			
		} catch (Exception e)
		{
			System.out.println("Invalid SQL Command.\n\n" + e.toString());
		}
	
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

	public static void exit_message()
	{
		System.out.println("Bye");
	}


	public static boolean processOption(int option, BufferedReader in) throws Exception
	{
		switch(option)
		{
			
			case -1:
				System.out.println("Logged out.");
				if(tryTologin(in)) // if they don't want to login it will 'fall' into the next case and print bye and return
					break;
			case 0:
				exit_message();
				return false;

			case 1:
				int id = getInt("id", in); // e.g. 872003
				if(id != -2)
				{
					String query = 
					"select s.first_name, s.last_name, s.id as 'star_id', m.id as 'movie_id', m.title, m.year, m.director, m.banner_url, m.trailer_url " +  
					"from stars_in_movies as sm, stars as s, movies as m " +
					"where sm.star_id = s.id and m.id = sm.movie_id and s.id = " + id + 
					" order by s.first_name, s.last_name, m.title;";

					processSelect(query);
				}
				else
					System.out.println("Invalid ID");

				break;

			case 2:

				String first_name = getString("first name", in);
				String last_name = getString("last name", in);

				String f_query = "";
				String l_query = "";

				if(!"".equals(first_name))
					f_query = "and s.first_name like \"" + first_name + "\"" + " ";
				if(!"".equals(last_name))
					f_query =  "and s.last_name like \"" + last_name + "\"";

				String query = 
				"select s.first_name, s.last_name, s.id as 'star_id', m.id as 'movie_id', m.title, m.year, m.director, m.banner_url, m.trailer_url " +  
				"from stars_in_movies as sm, stars as s, movies as m " +
				"where sm.star_id = s.id and m.id = sm.movie_id " + f_query + l_query +
				" order by s.first_name, s.last_name, m.title;";
				processSelect(query);
				break;

			case 3:
				insertIntoTable("stars", in);
				break;

			case 4:
				insertIntoTable("customers", in);				
				break;

			case 5:
				String cc_id = getString("creditcard", in);
				processUpdateInsertDelete("delete", "delete from customers where cc_id = \"" + cc_id + "\"");		
				break;

			case 6:
				cc_id = getString("creditcard", in);
				processSelect("select * from customers where cc_id = \"" + cc_id + "\"");
				System.out.println();				
				break;

			case 7:

				getMetaData();
				break;

			case 8:
				String command = getString("SQL Command", in);				
				processCommand(command);
				break;

			case 9:
				String table = getString("table", in);				
				insertIntoTable(table, in);
				break;			
	
			case 10:
				table = getString("table", in);				
				processSelect("select * from "+ table);
				break;
			case 11:
				String user_email = getString("email", in);	
				String user_pass = getString("password", in);	
				tryToLoginCustomer(user_email, user_pass);			
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
		System.out.println(" 2: Search by first and/or last name:");
		System.out.println(" 3: Insert a new star into the database");
		System.out.println(" 4: Insert customer into the database");
		System.out.println(" 5: Delete customer by creditcard");
		System.out.println(" 6: View customer by creditcard");
		System.out.println(" 7: View database metadata");
		System.out.println(" 8: SQL Command");
		System.out.println(" 9: Insert into [table]");
		System.out.println("10: View all in [table]");
		System.out.println("11: Log in as a customer");

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

	public static boolean askToLogin(BufferedReader in)
	{
		System.out.println("\nDo you want to login?");
		String ans = getString("[Y/N]", in);

		if("yes".equalsIgnoreCase(ans) || "y".equalsIgnoreCase(ans) || "1".equalsIgnoreCase(ans))
			return true;
		else
			return false;
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
				System.out.println("Unknown Error.\n\n" + e.toString());
			return false;

		}

		return true;
	}

	public static boolean tryTologin(BufferedReader in) throws Exception
	{
		
		while(true)
		{
			if(!askToLogin(in))
				return false;

			if(login(in))
			{
				System.out.println("Logged in.");
				return true;
			}
		}
	}

	public static void main(String [] args) throws Exception
	{

		if(!databaseStatus())
			return;

		BufferedReader inp = new BufferedReader (new InputStreamReader(System.in));

		if(!tryTologin(inp))
		{
			exit_message();
			return;
		}

		boolean running = true;
		while(running){

			printMenu();
			int option = getresponse(inp);
			running = processOption(option, inp);
		}

    	inp.close();

	}

}
