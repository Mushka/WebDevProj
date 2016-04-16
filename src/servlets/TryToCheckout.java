package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Credentials;
import model.MySQL;

/**
 * Servlet implementation class TryToCheckout
 */
public class TryToCheckout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TryToCheckout() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");    // Response mime type

		// Output stream to STDOUT
		PrintWriter out = response.getWriter();
		try
		{

			String ccn = request.getParameter("ccn");
			String exp_date = request.getParameter("exp_date");
			String first_name = request.getParameter("first_name");
			String last_name = request.getParameter("last_name");
			
			String query = "select * from creditcards where id like '"+ccn+"' and expiration like '"+exp_date+"' and first_name like '"+first_name+"' and last_name like '"+last_name+"'";

			
			ArrayList<Map<String, Object>> results = MySQL.select(query);
			
//			for(Map<String, Object> row: results)
//				
			System.out.println(results.toString());
			
			if(!results.isEmpty())
			{			
				
				Map<String, Integer> shopping_cart = (Map<String, Integer>) request.getSession().getAttribute("shopping_cart");
				String user_id = (String) request.getSession().getAttribute("user_id");
				
				if(shopping_cart != null)
				{
					for (Map.Entry<String, Integer> entry : shopping_cart.entrySet())
					{
					    System.out.println(entry.getKey() + "/" + entry.getValue());
					    
//					    
//					    String query = "INSERT INTO customers (customer_id, movie_id, sale_date) "
//					    		+ "VALUES ('title', 'value', 'value', 'value', 'value' 'value');";
//					    MySQL.processInsert(query);
					}
					
					out.print("true");
				}
				else
				{
					out.print("Shopping cart is empty");
				}
				
			}
			else
			{
				out.print("Invalid information");
			}
			

		} catch (Exception e)
		{
			out.print("something went wrong");
			System.out.println("Invalid SQL Command.\n\n" + e.toString());
		}

		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
