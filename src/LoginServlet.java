

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
@SuppressWarnings("serial")
//@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
private static final long serialVersionUID = 2562294252731783855L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
		
		doPost(request, response);
		
	}
	
public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
	
	System.out.println("**********************Inside doGet of LoginServlet ******************");

try
{	    
	PrintWriter out=response.getWriter();

     UserBean user = new UserBean();
     user.setUserName(request.getParameter("un"));
     user.setPassword(request.getParameter("pw"));

     user = UserDAO.login(user);
	   		out.println("LoginServlet page");    
     if (user.isValid())
     {
	      HttpSession session = request.getSession(true);	    
          session.setAttribute("currentSessionUser",user); 
          session.setAttribute("name",request.getParameter("un"));
          response.sendRedirect("simple.jsp"); //logged-in page      		
     }
	        
     else 
          response.sendRedirect("invalidLogin.jsp"); //error page 
} 
		
		
catch (Throwable theException) 	    
{
     System.out.println(theException); 
}
       }
	}