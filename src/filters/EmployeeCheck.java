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
 * Servlet Filter implementation class EmployeeCheck
 */
public class EmployeeCheck implements Filter {

    /**
     * Default constructor. 
     */
    public EmployeeCheck() {
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

				System.out.println("Uri EC: " + uri);
				
				String relative_path = request.getRequestURI().substring(request.getContextPath().length());

//				System.out.println("getContextPath: " + request.getContextPath());
//				System.out.println("getAuthType: " + request.getAuthType());
//				System.out.println("getRequestURI: " + request.getRequestURI());

				
//				if(uri.endsWith(".css") || uri.endsWith(".ttf") || uri.endsWith(".js") || uri.endsWith("TryToLoginCustomer") || uri.endsWith("login.html") || uri.endsWith("_dashboard") || uri.endsWith("TryToLoginEmployee") || uri.contains("reports"))
//					chain.doFilter(req,res);
//				else
//				{
				    HttpServletResponse response = (HttpServletResponse) res;
					HttpSession session = request.getSession();
				
				    if (session == null || session.getAttribute("emp_email") == null) {
						response.sendRedirect(request.getContextPath() + "/login_emp.html");
				    }
				    else
				    {
				    	
//				    	System.out.println("YAY");
						chain.doFilter(req,res);
				    }
//				}
//				
				
				chain.doFilter(req,res);

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
