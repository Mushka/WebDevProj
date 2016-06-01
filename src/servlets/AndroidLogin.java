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

public class AndroidLogin extends HttpServlet
{
	public String getServletInfo()
	{
		return "Servlet connects to MySQL database and displays result of a SELECT";
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		
		
		String loginUser = Credentials.admin;
		String loginPasswd = Credentials.password;
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

		response.setContentType("text/html");    // Response mime type

		// Output stream to STDOUT
		PrintWriter out = response.getWriter();
		try
		{

			String username = request.getParameter("username");
			String password = request.getParameter("password");

			String user_id = MySQL.loginCheck(username, password, "customers");

			if("".equalsIgnoreCase(user_id))
			{
				out.print("false");
			}
			else
			{
				//this prints out to the Android app
				out.print(user_id); 
				System.out.print("Logged in user id: " + user_id); 

				request.getSession().setAttribute("user_id", user_id);
			}
		

		} catch (Exception e)
		{
			out.print("false");
			System.out.println("Invalid SQL Command.\n\n" + e.toString());
		}

		out.close();
	}

	public void doPost(HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {
		doGet(request, response);
	}
}