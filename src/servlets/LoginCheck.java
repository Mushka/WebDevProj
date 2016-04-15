package servlets;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginCheck
 */
public class LoginCheck implements Filter {

    /**
     * Default constructor. 
     */
    public LoginCheck() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		HttpServletRequest request = (HttpServletRequest)req;
		String uri = request.getRequestURI();

		System.out.println("Uri: " + uri);

//		System.out.println("getContextPath: " + request.getContextPath());
//		System.out.println("getAuthType: " + request.getAuthType());
//		System.out.println("getRequestURI: " + request.getRequestURI());

		
		if(uri.endsWith("css") || uri.endsWith("ttf") || uri.endsWith("TryToLoginCustomer"))
			chain.doFilter(req,res);
		else
		{
		    HttpServletResponse response = (HttpServletResponse) res;
			HttpSession session = request.getSession();
		
		    if (session == null || session.getAttribute("user_name") == null) {
		        RequestDispatcher dispatcher = request.getRequestDispatcher("login.html");
		        dispatcher.forward(request, response);
//				response.sendRedirect("login.html");
		        
		    }
		    else
		    {
		    	
		    	System.out.println("YAY");
				chain.doFilter(req,res);
		    }
		}

	
//		request.getSession()
		
//		
//		HttpServletRequest req = (HttpServletRequest) request;
////		
//		String user_name = (String)req.getSession().getAttribute("user_name");
//		
//		if(user_name == null)
//		{
//////			((HttpServletResponse) response).sendRedirect(".");
//	        RequestDispatcher dispatcher = request.getRequestDispatcher(".");
//	        dispatcher.forward(request, response);
//		}
//		else
//		{
//			// pass the request along the filter chain
//			chain.doFilter(request, response);
//		}
		
//		chain.doFilter(req,res);
		
//		HttpServletRequest request = (HttpServletRequest) req;
//	    HttpServletResponse response = (HttpServletResponse) res;
//	    HttpSession session = request.getSession(false);
//
//	    if (session == null || session.getAttribute("user_name") == null) {
////	        response.sendRedirect("index.html"); // No logged-in user found, so redirect to login page.
//	        
//	        RequestDispatcher dispatcher = request.getRequestDispatcher("index.html");
//	        dispatcher.forward(request, response);
//	        
//	    } else {
//	        chain.doFilter(req, res); // Logged-in user found, so just continue request.
//	    }
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
