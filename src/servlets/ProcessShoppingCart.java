package servlets;

//slight change 2
/* A servlet to display the contents of the MySQL movieDB database */

import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import model.*;

public class ProcessShoppingCart extends HttpServlet
{
	public String getServletInfo()
	{
		return "Servlet connects adds items to the shopping cart";
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		response.setContentType("text/html");    // Response mime type
		// Output stream to STDOUT
		PrintWriter out = response.getWriter();
		try
		{

			String id = request.getParameter("id");
			String dec = request.getParameter("dec");
			String del = request.getParameter("del");
			
			Integer shopping_cart_size = (Integer) request.getSession().getAttribute("shopping_cart_size");
			
			if(shopping_cart_size == null)
				shopping_cart_size = 0; 

			Map<String, Integer> shopping_cart = (Map<String, Integer>)  request.getSession().getAttribute("shopping_cart");
			
			if(shopping_cart != null)
			{
				
				if(del != null)
				{
					shopping_cart.remove(id);
					--shopping_cart_size;
				}
				
				else
				{
					int count = shopping_cart.containsKey(id) ? shopping_cart.get(id) : 0;
					
					if("true".equalsIgnoreCase(dec))
					{
						shopping_cart.put(id, count - 1);
						--shopping_cart_size;
					}
					else
					{
						shopping_cart.put(id, count + 1);
						++shopping_cart_size;
					}
					
				}

			}
			else
			{
				shopping_cart = new HashMap<String, Integer>();
				shopping_cart.put(id, 1);
				++shopping_cart_size;
			}
			
			out.println(shopping_cart.toString());
			System.out.println("Shopping cart: " + shopping_cart.toString());
			
			request.getSession().setAttribute("shopping_cart", shopping_cart);
			request.getSession().setAttribute("shopping_cart_size", shopping_cart_size);

				
		} catch (Exception e)
		{
			System.out.println("Invalid SQL Command.\n\n" + e.toString());
			out.print("false");
		}

		out.close();
	}

	public void doPost(HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {
		doGet(request, response);
	}
}