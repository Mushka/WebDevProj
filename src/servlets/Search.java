//package servlets;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import model.*;
//
///**
// * Servlet implementation class Search
// */
//public class Search extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public Search() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		
//		
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	
//        response.setContentType("text/html");    // Response mime type
//        PrintWriter out = response.getWriter();
//  
//    	try {
//			String limit = request.getParameter("limit");
//			String offset = request.getParameter("offset");
//			String pre_title = request.getParameter("title");
//			String orderby = request.getParameter("orderby");
//					
//			if(limit==null)
//				limit = "10";
//			if(offset == null)
//				offset = "0";
//			if(pre_title == null)
//				pre_title = "";
//			
//			if(orderby == null)
//				orderby = "asc_t";
//
//			
//		String query = "SELECT * FROM movies WHERE title like '"+pre_title+"%'";
//		
//		String count_query = query;
//		
//		switch(orderby)
//		{
//		default:
//			query += " order by title";
//			break;
//		case "desc_t":
//			query += " order by title DESC";
//			break;
//		case "asc_y":
//			query += " order by year, title";
//			break;
//		case "desc_y":
//			query += " order by year DESC, title";
//			break;
//		}
//		
//		query += " LIMIT "+ limit +" OFFSET "+offset;
//
//        List<Movie> movies = Movie.getMovies(query);
//        	    
//		count_query = "SELECT COUNT(*) as count " + count_query.substring(count_query.indexOf("FROM"));
//		
//		String num_of_movies = MySQL.select(count_query).get(0).get("count").toString();
////		System.out.println(num_of_movies);
//	            
//        request.getSession().setAttribute("movies", movies);
//        request.getSession().setAttribute("offset", offset);
//        request.getSession().setAttribute("limit", limit);
//        request.getSession().setAttribute("title", pre_title);
//        request.getSession().setAttribute("num_of_movies", num_of_movies);
//        request.getSession().setAttribute("orderby", orderby);
//        
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/search.jsp");
//        dispatcher.forward(request, response);
//        
//	    } catch (Exception e)
//	    {
//			request.getSession().setAttribute("error_message", "Invalid SQL Command [Search].\n\n" + e.toString());
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
//			dispatcher.forward(request, response);
//	    }
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}
//
//}


package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.SortedSet;
import java.util.TreeSet;

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
			String orderby = request.getParameter("orderby");

			String title = request.getParameter("title");
			String year = request.getParameter("year");
			String director = request.getParameter("director");
			String fName = request.getParameter("first_name");
			String lName = request.getParameter("last_name");

			String advance =  request.getParameter("adv");
					
			if(limit==null)
				limit = "10";
			if(offset == null)
				offset = "0";
			if(title == null)
				title = "";
			if(orderby == null)
				orderby = "asc_t";

		String query = "";
		ArrayList<String> queryList = new ArrayList<String>();
		String wordsToSearch[] = title.split(" ");
		for(int k = 0; k < wordsToSearch.length; k++){	
			if(advance == null || !advance.equals("true") || "".equals(wordsToSearch) || (wordsToSearch.length == 1 && wordsToSearch[0].length() == 1))
			{
				query = "SELECT * FROM movies WHERE title like '"+title+"%'";
			}
			else
			{	
				if(k  != wordsToSearch.length - 1){
					query = "SELECT distinct m.id, title, year, director, banner_url, trailer_url "
							+ "FROM movies as m, stars_in_movies as sm, stars as s "
							+ "WHERE sm.star_id = s.id AND m.id = sm.movie_id "
							+ "AND m.title like '%" + wordsToSearch[k] + "%'";
				}else{
					query = "SELECT distinct m.id, title, year, director, banner_url, trailer_url "
							+ "FROM movies as m, stars_in_movies as sm, stars as s "
							+ "WHERE sm.star_id = s.id AND m.id = sm.movie_id "
							+ "AND m.title like '% " + wordsToSearch[k] + "%'";
				}
				if (year != null)
					query += " AND m.year like '%" + year + "'";
				if (director != null)
					query += " AND m.director like '%" + director + "%'";
				if (fName != null) 
					query += " AND s.first_name like '%" + fName + "%'";
				if (lName != null)
					query += " AND s.last_name like '%" + lName + "%'";
			}
			
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
			queryList.add(query);
    	}
		query += " LIMIT "+ limit +" OFFSET "+offset;
		String count_query = query;
		
        List<Movie> movies = new ArrayList<Movie>();
        HashMap<String, Movie>  allMovies = new HashMap<String, Movie>();
        if(advance != null|| (!("".equals(wordsToSearch[0]))) || (wordsToSearch.length != 1 && wordsToSearch[0].length() != 1)){
    		for(Movie m : Movie.getMovies(queryList.get(0)))
    			allMovies.put(m.toString(), m);
        	for(int i = 1; i < queryList.size(); i++){
                HashMap<String, Movie> copyMovies = new HashMap<String, Movie>(allMovies);	
                HashMap<String, Movie> nextWord = new HashMap<String, Movie>();
        		for(Movie m : Movie.getMovies(queryList.get(i)))
        			nextWord.put(m.toString(), m);
        		for(Entry<String, Movie> m : nextWord.entrySet())
        			copyMovies.remove(m.getKey());   		
        		for(Entry<String, Movie> m : copyMovies.entrySet())
        			allMovies.remove(m.getKey());
        	}
        	SortedSet<String> sortedMovies = new TreeSet<String>(allMovies.keySet());
        	ArrayList<String> movieFinder = new ArrayList<String>(sortedMovies);
        	for(int j = Integer.parseInt(offset); j < ((Integer.parseInt(limit) + Integer.parseInt(offset))-1); j++){
        		try{
        			movies.add(allMovies.get(movieFinder.get(j)));
        		}catch(Exception e){
        			out.print("Wtf " + j);
        			break;
        		}
        	}
        }else
        	movies = Movie.getMovies(query);
        if(advance == null || "".equals(wordsToSearch[0]) || (wordsToSearch.length == 1 && wordsToSearch[0].length() == 1))
    		count_query = "SELECT COUNT(*) as count " + count_query.substring(count_query.indexOf("FROM"));
        
        String num_of_movies =  "";
        System.out.println(count_query);
        if(advance == null || "".equals(wordsToSearch[0]) || (wordsToSearch.length == 1 && wordsToSearch[0].length() == 1))
        	num_of_movies = MySQL.select(count_query).get(0).get("count").toString();
        else 
        	num_of_movies = Integer.toString(allMovies.size());
        
        request.getSession().setAttribute("movies", movies);
        request.getSession().setAttribute("offset", offset);
        request.getSession().setAttribute("limit", limit);
        request.getSession().setAttribute("num_of_movies", num_of_movies);
        request.getSession().setAttribute("orderby", orderby);
        
        request.getSession().setAttribute("title", title);

		request.getSession().setAttribute("year", year);
		request.getSession().setAttribute("director", director);
		request.getSession().setAttribute("first_name", fName);
		request.getSession().setAttribute("last_name", lName);
		request.getSession().setAttribute("adv", advance);

        
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

//package servlets;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import model.*;
//
///**
// * Servlet implementation class Search
// */
//public class Search extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public Search() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		
//		
//        response.setContentType("text/html");    // Response mime type
//        PrintWriter out = response.getWriter();
//  
//    	try {
//			String limit = request.getParameter("limit");
//			String offset = request.getParameter("offset");
//			String orderby = request.getParameter("orderby");
//
//			String title = request.getParameter("title");
//			String year = request.getParameter("year");
//			String director = request.getParameter("director");
//			String fName = request.getParameter("first_name");
//			String lName = request.getParameter("last_name");
//
//			String advance =  request.getParameter("adv");
//			
////			System.out.println(advance);
//					
//			if(limit==null)
//				limit = "10";
//			if(offset == null)
//				offset = "0";
//			if(title == null)
//				title = "";
//			if(orderby == null)
//				orderby = "asc_t";
//
//		String query = "";
//		ArrayList<String> queryList = new ArrayList<String>();
//		if(advance == null || !advance.equals("true"))
//		{
//			query = "SELECT * FROM movies WHERE title like '"+title+"%'";
//		}
//		else
//		{
//			
//			query = "SELECT distinct m.id, title, year, director, banner_url, trailer_url "
//					+ "FROM movies as m, stars_in_movies as sm, stars as s "
//					+ "WHERE sm.star_id = s.id AND m.id = sm.movie_id "
//					+ "AND m.title like '%" + title + "%'";
//
//			if (year != null)
//				query += " AND m.year like '%" + year + "'";
//			if (director != null)
//				query += " AND m.director like '%" + director + "%'";
//			if (fName != null) 
//				query += " AND s.first_name like '%" + fName + "%'";
//			if (lName != null)
//				query += " AND s.last_name like '%" + lName + "%'";
//		}
//
//
//		String count_query = query;
//		
//		switch(orderby)
//		{
//		default:
//			query += " order by title";
//			break;
//		case "desc_t":
//			query += " order by title DESC";
//			break;
//		case "asc_y":
//			query += " order by year, title";
//			break;
//		case "desc_y":
//			query += " order by year DESC, title";
//			break;
//		}
//		
//		query += " LIMIT "+ limit +" OFFSET "+offset;
//		
//        List<Movie> movies = null;
//        List<Movie> allMovies = null;
//        if(advance == null){
//        	allMovies = Movie.getMovies(queryList.get(0));
//        	for(int i = 1; i < queryList.size(); i++ ){
//        		List<Movie> copyMovies = new ArrayList<Movie>(allMovies);
//        		List<Movie> nextWord = Movie.getMovies(queryList.get(i));
//        		copyMovies.removeAll(nextWord);
//        		allMovies.removeAll(copyMovies);
//        	}
//        	/*
//        	for(int j = Integer.parseInt(offset); j < ((Integer.parseInt(limit) + Integer.parseInt(offset))-1); j++){
//        		try{
//        			movies.add(allMovies.get(j));
//        		}catch(Exception e){
//        			out.print("Wtf " + j);
//        			break;
//        		}
//        	}*/
//        	movies = new ArrayList<Movie>(allMovies);
//        	
//        }else
//        	movies = Movie.getMovies(query);
//        String num_of_movies = "";
//        //if(advance == null)
//    	//	count_query = "SELECT COUNT(distinct m.id) as count " + count_query.substring(count_query.indexOf("FROM"));
//		/*
//        if(advance == null)
//			num_of_movies = Integer.toString(movies.size());
//		else
//        	num_of_movies = MySQL.select(count_query).get(0).get("count").toString();
//        */
//        request.getSession().setAttribute("movies", movies);
//        request.getSession().setAttribute("offset", offset);
//        request.getSession().setAttribute("limit", limit);
//        request.getSession().setAttribute("num_of_movies", num_of_movies);
//        request.getSession().setAttribute("orderby", orderby);
//        
//        request.getSession().setAttribute("title", title);
//
//		request.getSession().setAttribute("year", year);
//		request.getSession().setAttribute("director", director);
//		request.getSession().setAttribute("first_name", fName);
//		request.getSession().setAttribute("last_name", lName);
//
//		request.getSession().setAttribute("adv", advance);
//
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/search.jsp");
//		dispatcher.forward(request, response);
//        //out.print(new Gson().toJson(movies));
//
//	    } catch (Exception e)
//	    {
//	    	out.print("false");
//	    }
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}
//
//}


