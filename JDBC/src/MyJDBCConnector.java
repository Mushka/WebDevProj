import java.sql.*;

public class MyJDBCConnector
{

	// public static List<Map<String, Object>> select (String table)

	public static void main(String [] args) throws Exception{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "");
		Statement selectStmt = db_connection.createStatement();
		ResultSet results = selectStmt.executeQuery("select * from stars;");

		while(results.next()){
			System.out.println("Star: " + results.getString("first_name") + " " + results.getString("last_name"));
		}

		results.close();
		selectStmt.close();
		db_connection.close();
	}


}
