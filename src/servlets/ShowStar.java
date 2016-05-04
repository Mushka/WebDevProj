package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

/**
 * Servlet implementation class ShowMovie
 */
public class ShowStar extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowStar() {
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
            String star_id = request.getParameter("star_id");
                        
            if(star_id==null)
            {
				request.getSession().setAttribute("error_message", "No star was selected!");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
				return;	
            }
  
            if(!isValidNumber(star_id))
            {
				request.getSession().setAttribute("error_message", "The Star ID is invalid!");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
				return;	
			}
            
        	String query = "SELECT * FROM stars WHERE id = " + star_id;

            ArrayList<Map<String, Object>> results = MySQL.select(query);
            
            Star actor = null;
            
// 			if they pass in an int but not in the db results is empty
//          if they pass in a non int the results is null
//          > might be fixed now that I am verifying the id is an int above
    
            if(results != null && !results.isEmpty())
            {
                Map<String, Object> row = results.get(0);
                
                int s_id = ((Integer) row.get("id")).intValue();
				String first_name = row.get("first_name").toString();
				String last_name = row.get("last_name").toString();
				
				String dob = "";
				if(row.get("dob") != null)
					dob = row.get("dob").toString();
				
				String photo_url = "";
				if(row.get("photo_url") != null)
					photo_url = row.get("photo_url").toString();
				
				actor = new Star(s_id, first_name, last_name, dob, photo_url);
            }
            
            
            if(actor == null)
            {
				request.getSession().setAttribute("error_message", "That star was not found!");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
				return;
            }

            ArrayList<Movie> movies_starred_in = new ArrayList<Movie>();
            
            query = "select m.title, m.year, m.director, m.banner_url, m.trailer_url, m.id "
            		+ "from stars_in_movies as sm, stars as s, movies as m "
            		+ "where sm.star_id = s.id and m.id = sm.movie_id and s.id = " + actor.getId() + " "
            		+ "order by m.title;";
      
            results = MySQL.select(query);
            
            for(Map<String, Object> row : results)
            {
            	
            	int id = ((Integer) row.get("id")).intValue();
				String title = row.get("title").toString();
				int year = ((Integer)row.get("year")).intValue();
				String director = row.get("director").toString();
				
				String banner_url = "";
				if(row.get("banner_url") != null)
					banner_url = row.get("banner_url").toString();
				
				String trailer_url = "";
				if(row.get("trailer_url") != null)
					trailer_url = row.get("trailer_url").toString();
				

				Movie m = new Movie(id, title, year, 
						director, banner_url, trailer_url);
			
            	movies_starred_in.add(m);        
            }

            actor.setStarred_in(movies_starred_in);
            
            request.getSession().setAttribute("actor", actor);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/showActor.jsp");
            dispatcher.forward(request, response);
            
        
        
        } catch (Exception e){
        	
			request.getSession().setAttribute("error_message", "Invalid SQL Command [ShowStar].\n\n" + e.toString());
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
