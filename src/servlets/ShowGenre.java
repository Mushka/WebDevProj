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
 * Servlet implementation class Search
 */
public class ShowGenre extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShowGenre() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

//		response.getWriter().append("Served at: ").append(request.getContextPath());

		response.setContentType("text/html"); // Response mime type
		PrintWriter out = response.getWriter();

		try {
			String limit = request.getParameter("limit");
			String offset = request.getParameter("offset");
			String genre = request.getParameter("genre");
			String orderby = request.getParameter("orderby");

			if (limit == null)
				limit = "10";
			if (offset == null)
				offset = "0";
			if (genre == null)
				genre = "Thriller";

			if (orderby == null)
				orderby = "asc_t";

			String query = "SELECT m.id, m.title, m.year, m.director, m.banner_url, m.trailer_url "
					+ "FROM movies as m, genres_in_movies as gm, genres as g "
					+ "WHERE m.id = gm.movie_id and g.id = gm.genre_id and g.name like '" + genre + "'";

			String count_query = query;

			switch (orderby) {
			default:
				query += " order by title";
				break;
			case "desc_t":
				query += " order by title DESC";
				break;
			case "asc_y":
				query += " order by year";
				break;
			case "desc_y":
				query += " order by year DESC";
				break;
			}

			query += " LIMIT " + limit + " OFFSET " + offset;

//			grabs movies with the given genre
			List<Movie> movies = Movie.getMovies(query);
			
//			gets how many movies there are on in the above query without the limit
			count_query = "SELECT COUNT(*) as count " + count_query.substring(count_query.indexOf("FROM"));
			String num_of_movies = MySQL.select(count_query).get(0).get("count").toString();

//			gets the name of all the genres order by name
			ArrayList<String> all_genres = new ArrayList<String>();
			query = "select name from genres order by name";
			ArrayList<Map<String, Object>> results = MySQL.select(query);

			for (Map<String, Object> row : results)
				all_genres.add(row.get("name").toString());

			request.getSession().setAttribute("movies", movies);
			request.getSession().setAttribute("offset", offset);
			request.getSession().setAttribute("limit", limit);
			request.getSession().setAttribute("genre", genre);
			request.getSession().setAttribute("all_genres", all_genres);
			request.getSession().setAttribute("num_of_movies", num_of_movies);
			request.getSession().setAttribute("orderby", orderby);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/showGenre.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {

			request.getSession().setAttribute("error_message", "Invalid SQL Command [ShowGenre].\n\n" + e.toString());
			RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
