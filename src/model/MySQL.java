package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
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

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
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

	public static int processInsert(String query) throws Exception {

		try {

			String loginUser = Credentials.admin;
			String loginPasswd = Credentials.password;
			String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
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
	

	public static String getMetaData() throws Exception {

		String schema = "";

		try {
			String loginUser = Credentials.admin;
			String loginPasswd = Credentials.password;
			String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
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
