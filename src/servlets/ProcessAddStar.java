package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MySQL;

/**
 * Servlet implementation class AddStar
 */
public class ProcessAddStar extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessAddStar() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

			PrintWriter out = response.getWriter();


		try {
			String addStar = "INSERT INTO stars (first_name, last_name, dob, photo_url) VALUES (";

			String first_name = request.getParameter("first_name");
			String last_name = request.getParameter("last_name");
			String dob = request.getParameter("dob");
			String photo_url = request.getParameter("photo_url");

			if (first_name == null || "".equals(first_name))
				first_name = "";
			if (last_name == null || "".equals(last_name))
				last_name = "";
			if (dob == null || "".equals(dob) || !isValidDate(dob))
				dob = "NULL";
			if (photo_url == null || "".equals(photo_url))
				photo_url = "NULL";

			// this part satisfies the constraint: "If the [tables] has a single
			// name, add it as his last_name and assign an empty string ("") to
			// first_name."

			if ("".equals(first_name) && "".equals(last_name)) {
				first_name = "NULL";
				last_name = "NULL";
			} else if ("".equals(first_name)) {
				// nothing is needed because single named is already in last
			} else if ("".equals(last_name)) {
				last_name = first_name;
				first_name = "";
			}
			
			if("NULL".equals(first_name))
				addStar += first_name + ", ";
			else
				addStar += "'" + first_name + "', ";
			
			
			if("NULL".equals(last_name))
				addStar += last_name + ", ";
			else
				addStar += "'" + last_name + "', ";
			
			
			if("NULL".equals(dob))
				addStar += dob + ", ";
			else
				addStar += "'" + dob + "', ";
			
			
			if("NULL".equals(photo_url))
				addStar += photo_url + ");";
			else
				addStar += "'" + photo_url + "');";
			
			System.out.println(addStar);
			
			int n = MySQL.processInsert(addStar);
			
//			TODO make it tell which error happened??
			
			if(n == -1)
			{
				out.println("Oh no! You didn't satisfy the requirments above.");
			}
			else
			{
				out.println("The star '" + last_name + "'' was created."); // Rows Affected: " + n);
			}

		} catch (Exception e) {
			
			request.getSession().setAttribute("error_message", "Invalid SQL Command [Search].\n\n" + e.toString());
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
		doGet(request, response);
	}
	
	protected static boolean isValidDate(String inDate) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);
	    try {
	      dateFormat.parse(inDate.trim());
	    } catch (ParseException pe) {
	      return false;
	    }
	    return true;
	}
	
}
