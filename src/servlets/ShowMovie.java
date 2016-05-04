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

import model.*;
/**
 * Servlet implementation class ShowMovie
 */
public class ShowMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowMovie() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
				
        response.setContentType("text/html");    // Response mime type    	
    	try {
			String movie_id = request.getParameter("movie_id");
						
			if(movie_id==null)
			{
				request.getSession().setAttribute("error_message", "No movie was selected!");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
				return;
			}
			if(!isValidNumber(movie_id))
			{
				request.getSession().setAttribute("error_message", "The Movie ID is invalid!");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
				return;
			}
		
	       	Movie movie = Movie.getMovie(Integer.parseInt(movie_id));
	       	
	       	if(movie == null)
	       	{
				request.getSession().setAttribute("error_message", "Movie was not found!");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
			}		       
	       	
	        request.getSession().setAttribute("movie", movie);
	        
	        //TODO Create MOIVE PAGE
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/showMovie.jsp");
	        dispatcher.forward(request, response);	
	
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
