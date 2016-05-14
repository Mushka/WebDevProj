package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;
/**
 * Servlet implementation class ShowMovie
 */
public class AndroidGetMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AndroidGetMovie() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        response.setContentType("text/html");    // Response mime type
        PrintWriter out = response.getWriter();
				
    	try {
			String movie_id = request.getParameter("movie_id");
						
			if(movie_id==null)
			{
            	out.print("false");
				return;
			}
			if(!isValidNumber(movie_id))
			{
            	out.print("false");
				return;	
			}
		
	       	Movie movie = Movie.getMovie(Integer.parseInt(movie_id));
	       	
	       	if(movie == null)
	       	{
	       		//movie not found
            	out.print("false");
				return;	
			}		       
	       	
            out.print(new Gson().toJson(movie));
	
	    } catch (Exception e){
	    	
			request.getSession().setAttribute("error_message", "Invalid SQL Command [ShowGenre].\n\n" + e.toString());
			RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
			dispatcher.forward(request, response);
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	protected static boolean isValidNumber(String num) {
	    try {
	    	Integer.parseInt(num);
	    	return true;
	    } catch (NumberFormatException e) {
		    return false;
	    }
	}

}
