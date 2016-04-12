package tester;

//slight change 2
/* A servlet to display the contents of the MySQL movieDB database */

import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class TomcatTest extends HttpServlet
{
    public String getServletInfo()
    {
       return "Servlet connects to MySQL database and displays result of a SELECT";
    }

    // Use http GET

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException
    {
        String loginUser = Credentials.admin;
        String loginPasswd = Credentials.password;
        String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

        response.setContentType("text/html");    // Response mime type

        // Output stream to STDOUT
        PrintWriter out = response.getWriter();
//
//        out.println("<HTML><HEAD><TITLE>MovieDB</TITLE></HEAD>");
//        out.println("<BODY><H1>MovieDB</H1>");


        try
           {
              Class.forName("org.gjt.mm.mysql.Driver");
              //Class.forName("com.mysql.jdbc.Driver").newInstance();

              // Connection dbcon = 
              // // Declare our statement
              // Statement statement = dbcon.createStatement();


              String username = request.getParameter("username");
              String password = request.getParameter("password");


              String query = "select * from customers where email like '"+username+"' and password like '"+password+"'";


                // out.println("Processing: " + command);

                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
                Statement selectStmt = db_connection.createStatement();
                ResultSet results = selectStmt.executeQuery(query);

                // out.println();

                boolean empty = true;

                String user_name = "";

                while(results.next()){

                  empty = false;

                  user_name = results.getString("first_name");

                  break;
                }

                results.close();
                selectStmt.close();
                db_connection.close();

                if(empty)
                {
//                  out.println("Invalid Credentials. ");
                    out.print("false");

                    
//                    request.getSession().setAttribute("empty", empty);
//                    
//                    RequestDispatcher dispatcher = request.getRequestDispatcher("/tryagain.jsp");
//                    dispatcher.forward(request, response);
                }
                else
                {
                    out.println("Welcome "+ user_name + ".");  
//                    RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
//                    dispatcher.redi
                }
                
                
                
                
              } catch (Exception e)
              {
                out.println("Invalid SQL Command.\n\n" + e.toString());
              }

        
        
        	
        
              // String query = "SELECT * from creditcards";

              // // Perform the query
              // ResultSet rs = statement.executeQuery(query);

              // out.println("<TABLE border>");

              // // Iterate through each row of rs
              // while (rs.next())
              // {
              //     String m_ID = rs.getString("ID");
              //     String m_FN = rs.getString("first_name");
              //     String m_LN = rs.getString("last_name");
              //     out.println("<tr>" +
              //                 "<td>" + m_ID + "</td>" +
              //                 "<td>" + m_FN + "</td>" +
              //                 "<td>" + m_LN + "</td>" +
              //                 "</tr>");
              // }

              // out.println("</TABLE>");



              // rs.close();
              // statement.close();
              // dbcon.close();




            // Enumeration paramNames = request.getParameterNames();
            
            // while(paramNames.hasMoreElements()) {
            //    String paramName = (String)paramNames.nextElement();
            //    out.print("<tr><td>" + paramName + "</td>\n<td>");
            //    String[] paramValues =
            //           request.getParameterValues(paramName);
            //    // Read single valued data
            //    if (paramValues.length == 1) {
            //      String paramValue = paramValues[0];
            //      if (paramValue.length() == 0)
            //        out.println("<i>No Value</i>");
            //      else
            //        out.println(paramValue);
            //    } else {
            //        // Read multiple valued data
            //        out.println("<ul>");
            //        for(int i=0; i < paramValues.length; i++) {
            //           out.println("<li>" + paramValues[i]);
            //        }
            //        out.println("</ul>");
            //    }
            // }
            // out.println("</tr>\n</table>\n</body></html>");
            // }
        // catch (SQLException ex) {
        //       while (ex != null) {
        //             out.println ("SQL Exception:  " + ex.getMessage ());
        //             ex = ex.getNextException ();
        //         }  // end while
        //     }  // end catch SQLException

        // catch(java.lang.Exception ex)
        //     {
        //         out.println("<HTML>" +
        //                     "<HEAD><TITLE>" +
        //                     "MovieDB: Error" +
        //                     "</TITLE></HEAD>\n<BODY>" +
        //                     "<P>SQL error in doGet: " +
        //                     ex.getMessage() + "</P></BODY></HTML>");
        //         return;
        //     }
         out.close();
    }

    public void doPost(HttpServletRequest request,
                     HttpServletResponse response)
      throws ServletException, IOException {
     doGet(request, response);
  }
}