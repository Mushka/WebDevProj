package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

/**
 * Servlet implementation class Search
 */
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
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
        PrintWriter out = response.getWriter();
  
    	try {
			String limit = request.getParameter("limit");
			String offset = request.getParameter("offset");
			String pre_title = request.getParameter("title");
			String orderby = request.getParameter("orderby");
					
			if(limit==null)
				limit = "10";
			if(offset == null)
				offset = "0";
			if(pre_title == null)
				pre_title = "%";
			
			if(orderby == null)
				orderby = "asc_t";

			
		String query = "SELECT * FROM movies WHERE title like '"+pre_title+"%'";
		
		switch(orderby)
		{
		default:
			query += " order by title";
			break;
		case "desc_t":
			query += " order by title DESC";
			break;
		case "asc_y":
			query += " order by year, title";
			break;
		case "desc_y":
			query += " order by year DESC, title";
			break;
		}
		
		query += " LIMIT "+ limit +" OFFSET "+offset;

        List<Movie> movies = Movie.getMovies(query);

        for(Movie m: movies)
        {
            m.setGenres(Movie.getGenres(m.getId()));
            m.setStars(Movie.getStars(m.getId()));
        }

//        String num_of_movies = "0";		
        
	    query = "SELECT COUNT(*) as count FROM movies WHERE title like '"+pre_title+"%'";
	    String num_of_movies = MySQL.select(query).get(0).get("count").toString();
	            
        request.getSession().setAttribute("movies", movies);
        request.getSession().setAttribute("offset", offset);
        request.getSession().setAttribute("limit", limit);
        request.getSession().setAttribute("title", pre_title);
        request.getSession().setAttribute("num_of_movies", num_of_movies);
        request.getSession().setAttribute("orderby", orderby);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/search.jsp");
        dispatcher.forward(request, response);
        
	    } catch (Exception e)
	    {
			request.getSession().setAttribute("error_message", "Invalid SQL Command [Search].\n\n" + e.toString());
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

}
