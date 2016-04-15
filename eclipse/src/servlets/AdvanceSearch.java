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
public class AdvanceSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdvanceSearch() {
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

		response.getWriter().append("Served at: ").append(request.getContextPath());

		response.setContentType("text/html"); // Response mime type
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

			if (limit == null)
				limit = "10";
			if (offset == null)
				offset = "0";
			if (orderby == null)
				orderby = "asc_t";
			// title year director firstname and lastname

			if (title == null)
				title = "";
			String query = "SELECT * FROM movies WHERE title like '%" + title + "%'";

			if (year != null)
				query += " AND year like %" + year;
			if (director != null)
				query += " AND director like %" + director + "%";
			if (fName != null)
				query += " AND first_name like %" + fName + "%";
			if (lName != null)
				query += " AND last_name like %" + lName + "%";

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

			List<Movie> movies = Movie.getMovies(query);

			for (Movie m : movies) {
				m.setGenres(Movie.getGenres(m.getId()));
				m.setStars(Movie.getStars(m.getId()));
			}

			// String num_of_movies = "0";

			query = "SELECT COUNT(*) as count FROM movies WHERE title like '" + title + "%'";
			String num_of_movies = MySQL.select(query).get(0).get("count").toString();

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

			RequestDispatcher dispatcher = request.getRequestDispatcher("/advanceSearch.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			out.println("Invalid SQL Command. shit \n\n" + e.toString());
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
