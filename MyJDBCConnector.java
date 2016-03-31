import java.sql.*;

public class MyJDBCConnector
{

	// public static List<Map<String, Object>> select (String table)

	public static void main(String [] args) throws Exception{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection db_connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "root");
		Statement selectStmt = db_connection.createStatment();
		ResultSet results = selectStmt.executeQuery("select * from people;");

		while(results.next()){
			System.out.println("ID:" + results.getInt("id"));
		}

		results.close();
		selectStmt.close();
		db_connection.close();
	}


}
