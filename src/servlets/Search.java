package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


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
		String count_query= "";
		String wordsToSearch[] = title.split(" ");
		ArrayList<String> values = new ArrayList<String>();
		ArrayList<String> fixedWords = new ArrayList<String>();
		String fuzzyCheck = request.getParameter("fuzzy_search");
		for(int k = 0; k < wordsToSearch.length; k++){	
			if((k != wordsToSearch.length -1)||(wordsToSearch.length == 1))
				fixedWords.add("%"+wordsToSearch[k] +"%");
			else{
				fixedWords.add("% "+wordsToSearch[k] +"%");
				fixedWords.add(wordsToSearch[k] +"%");
			}
    	}
		if(advance == null || !advance.equals("true") || (wordsToSearch.length == 1 && wordsToSearch[0].length() == 1))
		{
			query = "SELECT * FROM movies as m WHERE title like ?";
			values.add(title+"%");
		}
		else
		{	
			if(fuzzyCheck == null){
				query = "SELECT distinct m.id, title, year, director, banner_url, trailer_url "
							+ "FROM movies as m, stars_in_movies as sm, stars as s "
							+ "WHERE sm.star_id = s.id AND m.id = sm.movie_id ";
				if(!"".equals(title.trim())){
					query += "AND MATCH(m.title) AGAINST (? IN BOOLEAN MODE)";
					values.add(title+"*");
				}
				for(int i = 0; i < fixedWords.size() -1; i++){
					if(i != fixedWords.size() - 2){
						query += " AND m.title like ?";
						values.add(fixedWords.get(i));
					}else{
						query += " AND (m.title like ?";
						values.add(fixedWords.get(i));
						query += " OR m.title like ?)";
						values.add(fixedWords.get(i+1));
						break;
					}
				}
				if (!"".equals(year)){
					query += " AND m.year like ?";
					values.add("%"+ year);
				}
				if (!"".equals(director)){
					query += " AND m.director like ?";
					values.add("%"+director+"%");
				}
				if (!"".equals(fName)){ 
					query += " AND s.first_name like ?";
					values.add("%"+fName+"%");
				}
				if (!"".equals(lName)){
					query += " AND s.last_name like ?";
					values.add("%"+lName+"%");
				}
			}else{
				System.out.println("WTF");
				query += "DROP FUNCTION IF EXISTS edth; ";
				MySQL.createFunction(query);
				query = "CREATE FUNCTION edth RETURNS INTEGER SONAME 'libedth.so';";
				MySQL.createFunction(query);
				query = "SELECT distinct m.id, title, year, director, banner_url, trailer_url "
						+ "FROM movies as m, stars_in_movies as sm, stars as s "
						+ "WHERE sm.star_id = s.id AND m.id = sm.movie_id ";
				if (!"".equals(title)){
					query += "AND edth(title, ?,3)";
					values.add(title);
				}
				if (!"".equals(year)){
					query += " AND m.year like ?";
					values.add("%"+year);
				}
				if (!"".equals(director)){
					query += " AND edth(m.director, ?,2)";
					values.add(director);
				}
				if (!"".equals(fName)){ 
					query += " AND edth(s.first_name, ?,2)";
					values.add(fName);
				}
				if (!"".equals(lName)){
					query += " AND edth(s.last_name, ?,2)";
					values.add(lName);
				}
			}
			
		}
		count_query = query;
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
		query += " LIMIT ? OFFSET ?";
        if(advance == null)
    		count_query = "SELECT COUNT(*) as count " + count_query.substring(count_query.indexOf("FROM"));
        else
    		count_query = "SELECT COUNT(distinct m.id) as count " + count_query.substring(count_query.indexOf("FROM"));
        String num_of_movies = MySQL.selectPrepare(count_query, values).get(0).get("count").toString();     
		values.add(limit);
		values.add(offset);
        List<Movie> movies = new ArrayList<Movie>();
        System.out.println(query);
        movies = Movie.getMoviesPrepare(query, values);   
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
		request.getSession().setAttribute("fuzzy_search", fuzzyCheck);

        
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
