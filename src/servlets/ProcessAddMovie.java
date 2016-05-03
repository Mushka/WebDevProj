package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import model.Credentials;

/**
 * Servlet implementation class AddMovie
 */
public class ProcessAddMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessAddMovie() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		PrintWriter out = response.getWriter();
		
		String title_m = request.getParameter("title_m");
		String year_m = request.getParameter("year_m");
		String director_m = request.getParameter("director_m");
		
		
		if(title_m == null)
			title_m = "";
		
		if(year_m == null)
			year_m = "";
		
		if(director_m == null)
			director_m = "";
		
		

//		if(title_m == null || title_m == "" || year_m == null || year_m == "" || director_m == null || director_m == "")
//		{
//			// fuck shit up
//		}
		
		if(year_m == null || year_m == "")
			year_m = "-1";

		// not required
		String banner_url_m = request.getParameter("banner_url_m");
		// not required		
		String trailer_url_m = request.getParameter("trailer_url_m");
		
		String first_name_s = request.getParameter("first_name_s");
		String last_name_s = request.getParameter("last_name_s");

//		if(first_name_s == null || first_name_s == "" || last_name_s == null || last_name_s == "")
//		{
//			// fuck shit up
//			// or possibly just not do star qureries 
//		}
		
		if(first_name_s == null)
			first_name_s = "";
		
		if(last_name_s == null)
			last_name_s = "";
		
		
		// this part satisfies the constraint: "If the [tables] has a single
		// name, add it as his last_name and assign an empty string ("") to
		// first_name."

		if ("".equals(first_name_s) && "".equals(last_name_s)) {
			first_name_s = "";
			last_name_s = "";
		} else if ("".equals(first_name_s)) {
			// nothing is needed because single named is already in last
		} else if ("".equals(last_name_s)) {
			last_name_s = first_name_s;
			first_name_s = "";
		}

		// not required
		String dob_s = request.getParameter("dob_s");
		
		if(dob_s != null && dob_s != "")
		{
			if(!isValidDate(dob_s))
			{
				System.out.println("WTF MAN??");
				dob_s = "";
			}
		}
		
		// not required
		String photo_url_s = request.getParameter("photo_url_s");
		
		String genre = request.getParameter("genre");

//		if(genre == null || genre == "")
//		{
//			// fuck shit up
//			// or possibly just not do genre qureries 
//		}
		
		if(genre == null)
			genre = "";
		
	
//		response.getWriter().append(title_m + ", " + year_m + ", " + director_m + ", " + banner_url_m + ", " + trailer_url_m + ", " + first_name_s + ", " + last_name_s + ", " + dob_s + ", " + genre);
		
	
		try {
			
			String loginUser = Credentials.admin;
			String loginPasswd = Credentials.password;
			String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);

		    CallableStatement stmt = db_connection.prepareCall("{call add_movie(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
		    stmt.setString(1, title_m);
		    stmt.setInt(2, isValidYear(year_m));
		    stmt.setString(3, director_m);


		    if(banner_url_m == null || banner_url_m == "")
		    	stmt.setNull(4, java.sql.Types.VARCHAR);
		    else
		    	stmt.setString(4, banner_url_m);

		    if(trailer_url_m == null || trailer_url_m == "")
		    	stmt.setNull(5, java.sql.Types.VARCHAR);
		    else
		    	stmt.setString(5, trailer_url_m);

		    stmt.setString(6, first_name_s);
		    stmt.setString(7, last_name_s);

		    if(dob_s == null || dob_s == "")
		    	stmt.setNull(8, java.sql.Types.DATE);
		    else
		    	stmt.setString(8, dob_s);


		    if(photo_url_s == null || photo_url_s == "")
		    	stmt.setNull(9, java.sql.Types.VARCHAR);
		    else
		    	stmt.setString(9, photo_url_s);

		    stmt.setString(10, genre);
		    stmt.registerOutParameter(11, java.sql.Types.VARCHAR);
		    stmt.registerOutParameter(12, java.sql.Types.VARCHAR);
		    stmt.registerOutParameter(13, java.sql.Types.VARCHAR);


			stmt.execute();
			
			String star_id = stmt.getString(11);
			String genre_id = stmt.getString(12);
			String output = stmt.getString(13);
			
			if("".equals(output))
				output = "Nothing changed in the database.";
			
//		    response.getWriter().append("\n\nstar_id: " + star_id + "\ngenre_id: " + genre_id);
//		    response.getWriter().append("\n\noutput:\n" + output);
			
			out.println(output);
		      
		    stmt.close();
			db_connection.close();
		} catch (Exception e) {
			System.out.println("Invalid SQL Command. [MySql.select()]\n\n" + e.toString());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	


	protected static boolean isValidDate(String inDate) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);
	    try {
	      dateFormat.parse(inDate.trim());
	    } catch (ParseException pe) {
	      return false;
	    }
	    return true;
	}
	
	protected static int isValidYear(String year) {

		int to_return = -1;
	    try {
	    	to_return = Integer.parseInt(year);
	    	return to_return;
	    } catch (NumberFormatException e) {
		    return to_return;
	    }
	}

}
