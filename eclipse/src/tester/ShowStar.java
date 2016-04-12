package tester;

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
                
        String loginUser = Credentials.admin;
        String loginPasswd = Credentials.password;
        String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

        response.setContentType("text/html");    // Response mime type
        PrintWriter out = response.getWriter();
        
        try {
            String star_id = request.getParameter("star_id");
                        
            if(star_id==null)
                star_id = "658017";
            
                    
        String query = "SELECT * FROM stars WHERE id = " + star_id;

            
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
        Statement selectStmt = db_connection.createStatement();
        ResultSet results = selectStmt.executeQuery(query);
        
        
        Star actor = null;

        
        while(results.next()) 
            actor = new Star(results.getInt("id"), results.getString("first_name"), results.getString("last_name"),results.getString("dob"),results.getString("photo_url"));
        
        
        if(actor == null)
        	System.out.println("DO SOMETHING ABOUT THIS BITCH");

        
        results.close();
        selectStmt.close();
        db_connection.close();
        

        ArrayList<Movie> movies_starred_in = new ArrayList<Movie>();
        
        query = "select m.title, m.year, m.director, m.banner_url, m.trailer_url, m.id "
        		+ "from stars_in_movies as sm, stars as s, movies as m "
        		+ "where sm.star_id = s.id and m.id = sm.movie_id and s.id = " + actor.getId() + " "
        		+ "order by m.title;";
  
            
        db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
        selectStmt = db_connection.createStatement();
        results = selectStmt.executeQuery(query);
            
           
        while(results.next())
        	movies_starred_in.add(new Movie(results.getInt("id"), results.getString("title"), results.getInt("year"),results.getString("director"),results.getString("banner_url"),results.getString("trailer_url")));
        
        results.close();
        selectStmt.close();
        db_connection.close(); 
        
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
