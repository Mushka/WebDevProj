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
public class ShoppingCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShoppingCart() {
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
			Map<String, Integer> shopping_cart = (Map<String, Integer>) request.getSession().getAttribute("shopping_cart");

			if (shopping_cart == null)
				System.out.println("ERROR: CART IS EMPTY");
			

			for (Map.Entry<String, Integer> item : shopping_cart.entrySet()) {
				Movie m = Movie.getMovie(Integer.parseInt(item.getKey()));
				m.setGenres(Movie.getGenres(m.getId()));
				m.setStars(Movie.getStars(m.getId()));
			}
			
			request.getSession().setAttribute("shopping_cart", shopping_cart);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/reviewShoppingCart.jsp");
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
