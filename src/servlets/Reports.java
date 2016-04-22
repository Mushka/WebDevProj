package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Movie;

/**
 * Servlet implementation class Reports
 */
public class Reports extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Reports() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		try {
//			String movie_id = request.getParameter("movie_id");
//
//			if (movie_id == null)
//				movie_id = "135001";
//
//			Movie movie = Movie.getMovie(Integer.parseInt(movie_id));
//
//			request.getSession().setAttribute("movie", movie);
//
//			// TODO Create MOIVE PAGE
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/showMovie.jsp");
//			dispatcher.forward(request, response);
//			request.getContextPath()
			String path_info = request.getPathInfo();
			
			
					
			
			
			String report_page = "";
			
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/reports.jsp");

			
			if(path_info != null)
			{				
				report_page = path_info.substring(path_info.lastIndexOf('/')+1);
//				System.out.println(report_page);
				
				
			}
			else
			{
				report_page = "index";
//				System.out.println(report_page);

		       dispatcher = request.getRequestDispatcher("/reports/reports_index.jsp");

			}
			
			request.getSession().setAttribute("report_page", report_page);
	        dispatcher.forward(request, response);

		} catch (Exception e) {

			request.getSession().setAttribute("error_message", "Invalid SQL Command [Reports].\n\n" + e.toString());
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
