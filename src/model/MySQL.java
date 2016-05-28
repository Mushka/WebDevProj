package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

public class MySQL {

	@SuppressWarnings("finally")
	public static ArrayList<Map<String, Object>> select(String query) throws Exception {

		ArrayList<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();

		try {
			String loginUser = Credentials.admin;
			String loginPasswd = Credentials.password;
			String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
			
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource datasource = (DataSource) envContext.lookup("jdbc/moviedb");

			Connection db_connection = null;
			
			if(datasource == null){
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			}else
				db_connection = datasource.getConnection();
			
			Statement selectStmt = db_connection.createStatement();

			ResultSet results = selectStmt.executeQuery(query);

			ResultSetMetaData metadata = results.getMetaData();

			while (results.next()) {
				Map<String, Object> row = new HashMap<String, Object>();
				for (int i = 1; i <= metadata.getColumnCount(); ++i)
					row.put(metadata.getColumnName(i), results.getObject(i));

				rows.add(row);
			}

			results.close();
			selectStmt.close();
			db_connection.close();
		} catch (Exception e) {
			System.out.println("Invalid SQL Command. [MySql.select()]\n\n" + e.toString());
			rows = null;
		} finally {
			return rows;
		}

	}
	
	@SuppressWarnings("finally")
	//last two have to be a limit and offset
	public static ArrayList<Map<String, Object>> selectPrepare(String query, ArrayList<String> values) throws Exception {

		ArrayList<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();

		try {
			String loginUser = Credentials.admin;
			String loginPasswd = Credentials.password;
			String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource datasource = (DataSource) envContext.lookup("jdbc/moviedb");
			Connection db_connection = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			if(datasource == null){
				db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			}else{
				db_connection = datasource.getConnection();
			}
			PreparedStatement selectStmt = db_connection.prepareStatement(query);
			System.out.println("7");
			for(int i = 0; i < values.size(); i++){
				if(!values.get(i).equals("")){
					if(i < values.size()-2)
						selectStmt.setString(i+1, values.get(i));
					else{
						try{
							selectStmt.setInt(i+1, Integer.parseInt(values.get(i)));
						}
						catch(Exception e ){
							System.out.println("No Limit and Offset set: " + query);
							selectStmt.setString(i+1, values.get(i));
						}
					}
				}else{
					System.out.println("This is a problem");
				}
			}
			System.out.println("This one " + selectStmt.toString());
			ResultSet results = selectStmt.executeQuery();

			ResultSetMetaData metadata = results.getMetaData();

			while (results.next()) {
				Map<String, Object> row = new HashMap<String, Object>();
				for (int i = 1; i <= metadata.getColumnCount(); ++i)
					row.put(metadata.getColumnName(i), results.getObject(i));

				rows.add(row);
			}

			results.close();
			selectStmt.close();
			db_connection.close();
		} catch (Exception e) {
			System.out.println("Invalid SQL Command. [MySql.selectPrepare()]\n\n" + e.toString());
			rows = null;
		} finally {
			return rows;
		}

	}

	public static int processInsert(String query) throws Exception {

		try {

			String loginUser = Credentials.masterAdmin;
			String loginPasswd = Credentials.masterPassword;
			//String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
			String loginUrl = "jdbc:mysql://" + Credentials.masterUrl + ":3306/moviedb";


			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource datasource = (DataSource) envContext.lookup("jdbc/moviedb");

			Connection db_connection = null;
			if(datasource == null){
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			}else
				db_connection = datasource.getConnection();
			Statement update = db_connection.createStatement();
			
			int n = update.executeUpdate(query);

			update.close();
			db_connection.close();

			return n;

		} catch (Exception e) {

			System.out.println("Invalid SQL Command. [MySql.insert()]\n\n" + e.toString());
			return -1;
		}
	}
	public static boolean createFunction(String query) throws Exception {

		try {

			String loginUser = Credentials.admin;
			String loginPasswd = Credentials.password;
			String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
			
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource datasource = (DataSource) envContext.lookup("jdbc/moviedb");

			Connection db_connection = null;
			if(datasource == null){
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			}else
				db_connection = datasource.getConnection();
			Statement update = db_connection.createStatement();
			
			boolean n = update.execute(query);

			update.close();
			db_connection.close();

			return n;

		} catch (Exception e) {

			System.out.println("Invalid SQL Command. [MySql.createFunction()]\n\n" + e.toString());
			return false;
		}
	}

	public static String getMetaData() throws Exception {

		String schema = "";

		try {
			String loginUser = Credentials.admin;
			String loginPasswd = Credentials.password;
			String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource datasource = (DataSource) envContext.lookup("jdbc/moviedb");

			Connection db_connection = null;
			if(datasource == null){
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			}else
				db_connection = datasource.getConnection();
			DatabaseMetaData databaseMetaData = db_connection.getMetaData();

			String catalog = null;
			String schemaPattern = null;
			String tableNamePattern = null;
			String[] types = null;
			String columnNamePattern = null;

			ResultSet tables = databaseMetaData.getTables(catalog, schemaPattern, tableNamePattern, types);

			while (tables.next()) {
				String tableName = tables.getString(3);
				// System.out.println(tableName+":");
				schema += tableName + ":\n";

				ResultSet tableMetadata = databaseMetaData.getColumns(catalog, schemaPattern, tableName,
						columnNamePattern);

				while (tableMetadata.next()) {
					String columnName = tableMetadata.getString(4);
					int columnType = tableMetadata.getInt(5);

					String columnTypeString = getColumnTypeString(columnType);

					// System.out.println("- " + columnName + ": " +
					// columnTypeString);
					schema += "- " + columnName + ": " + columnTypeString + "\n";
				}

				// System.out.println();
				schema += "\n";

			}

			db_connection.close();
		} catch (Exception e) {

			System.out.println("Invalid SQL Command. [MySql.getMetaData()]\n\n" + e.toString());
			schema = "whoops";
		}
		
		return schema;

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
	
}
