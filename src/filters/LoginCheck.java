package filters;

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

		System.out.println("relative_path: " + request.getRequestURI().substring(request.getContextPath().length()));
		String relative_path = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println("uri: " + uri);
		System.out.println("relative_path: " + relative_path);
		System.out.println("---");


//		System.out.println("getContextPath: " + request.getContextPath());
//		System.out.println("getAuthType: " + request.getAuthType());
//		System.out.println("getRequestURI: " + request.getRequestURI());

		//uri.endsWith("SearchAjax") because we need to access this from android
		if(uri.endsWith(".css") || uri.endsWith(".ttf") || uri.endsWith(".js") || uri.endsWith(".png") || uri.endsWith("TryToLoginCustomer") || uri.endsWith("login.html") || uri.endsWith("login_emp.html") || uri.endsWith("_dashboard") || uri.endsWith("TryToLoginEmployee") || relative_path.startsWith("/_dashboard") || uri.contains("reports") || uri.endsWith("SearchAjax") || uri.endsWith("AndroidGetMovie") || uri.endsWith("AndroidGetStar") || uri.endsWith("AndroidLogin") || uri.endsWith("AndroidSearch"))
			chain.doFilter(req,res);
		else
		{
		    HttpServletResponse response = (HttpServletResponse) res;
			HttpSession session = request.getSession();
		
		    if (session == null || session.getAttribute("user_id") == null) {
//		        RequestDispatcher dispatcher = request.getRequestDispatcher("login.html");
//		        dispatcher.forward(request, response);
				response.sendRedirect(request.getContextPath() + "/login.html");
		        
		    }
		    else
		    {
		    	
//		    	System.out.println("YAY");
				chain.doFilter(req,res);
		    }
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
