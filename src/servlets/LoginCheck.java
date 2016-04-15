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
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		
		
		
//		request.getSession()
		
//		
//		HttpServletRequest req = (HttpServletRequest) request;
//		
//		String user_name = (String)req.getSession().getAttribute("user_name");
		
//		if(user_name == null)
//		{
//////			((HttpServletResponse) response).sendRedirect(".");
////	        RequestDispatcher dispatcher = request.getRequestDispatcher(".");
////	        dispatcher.forward(request, response);
//		}
//		else
//		{
//			// pass the request along the filter chain
//			chain.doFilter(request, response);
//		}
		
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
