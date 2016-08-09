

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.util.URLEncoder;

/**
 * Servlet implementation class InsertServlet
 */
//@WebServlet("/InsertServlet")
public class InsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	System.out.println("Inside doGet of InsertServlet");
	}
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		
		System.out.println("Inside doPost of InsertServlet");
		String fn=request.getParameter("firstname");
		String ln=request.getParameter("lastname");
		String uname=request.getParameter("username");
		String pass=request.getParameter("password");
		HttpSession session=request.getSession(false);
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		UserBean bean= new UserBean();
		
		bean.setFirstName(fn);
		bean.setLastName(ln);;
		bean.setUserName(uname);;
		bean.setPassword(pass);
		System.out.println(bean);
		
		try {
			UserDAO.insertValuesToDB(bean);
		} catch (UserExistException e) {
			// TODO Auto-generated catch block
			/*out.println("<script type=\"text/javascript\">");
		       out.println("alert('User Already exist');");
		       
		       out.println("</script>");*/
			session.setAttribute("Exception","true");
			System.out.println("oopssss!!!"+e.getMessage());
			response.sendRedirect("UserExist.jsp");
			return;
			//response.setHeader("Refresh", "0; URL=http://localhost:8080/FinalLogin/signup.jsp");
		       //response.sendRedirect("signup.jsp");    
			
			/*out.println("<html><body>User Already Exist!!!!</body></html>");
			*/
			
			//e.printStackTrace();
		}
		session.setAttribute("Exception","false");
		String Exceptionvalue=(String)session.getAttribute("Exception");
		if(Exceptionvalue.equalsIgnoreCase("true"))
		{
			//response.setHeader("Refresh", "0; URL=http://localhost:8080/FinalLogin/signup.jsp");
			session.setAttribute("Exception","true");
			request.setAttribute("sess","poo");
			//RequestDispatcher rd=request.getRequestDispatcher("signup.jsp");
			
			//request.getSession().setAttribute("message", message);
	
			//rd.forward(request, response);
			System.out.println("Exception occured");
			
			
			//response.sendRedirect("signup.jsp?loginMsg=" + URLEncoder.encode(message));
			response.sendRedirect("UserExist.jsp");
		}
		else{
		RequestDispatcher rd=request.getRequestDispatcher("SignUpSuccess.jsp");
		rd.forward(request, response);
		}
	}

}
