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
        PrintWriter out = response.getWriter();
        
        try {
            String star_id = request.getParameter("star_id");
                        
            if(star_id==null)
                star_id = "658017";
            
        String query = "SELECT * FROM stars WHERE id = " + star_id;

        ArrayList<Map<String, Object>> results = MySQL.select(query);
        
        Star actor = null;
        
        for(Map<String, Object> row : results)
            actor = new Star(((Integer)row.get("id")).intValue(), row.get("first_name").toString(), row.get("last_name").toString(), row.get("dob").toString(), row.get("photo_url").toString());
        
        if(actor == null)
        	System.out.println("DO SOMETHING ABOUT THIS BITCH"); //TODO

        ArrayList<Movie> movies_starred_in = new ArrayList<Movie>();
        
        query = "select m.title, m.year, m.director, m.banner_url, m.trailer_url, m.id "
        		+ "from stars_in_movies as sm, stars as s, movies as m "
        		+ "where sm.star_id = s.id and m.id = sm.movie_id and s.id = " + actor.getId() + " "
        		+ "order by m.title;";
  
        results = MySQL.select(query);
        
        for(Map<String, Object> row : results)
        	movies_starred_in.add(new Movie(((Integer) row.get("id")).intValue(), row.get("title").toString(), ((Integer)row.get("year")).intValue(),
					row.get("director").toString(), row.get("banner_url").toString(), row.get("trailer_url").toString()));        
        
        actor.setStarred_in(movies_starred_in);
        
        request.getSession().setAttribute("actor", actor);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/showActor.jsp");
        dispatcher.forward(request, response);
        
        } catch (Exception e)
        {
          out.println("Invalid SQL Command.\n\n" + e.toString());
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
