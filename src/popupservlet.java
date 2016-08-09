

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DatabaseManager;

/**
 * Servlet implementation class popupservlet
 */
//@WebServlet("/popupservlet")
public class popupservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public popupservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
		System.out.println("**********************Inside doGet of LoginServlet ******************");

			PrintWriter out=response.getWriter();

			   //   HttpSession session = request.getSession(true);	    
		          		
		    out.println(request.getParameter("mysearch2"));
		    String optionSelected=request.getParameter("search");
		    System.out.println("selected option"+optionSelected);
		    System.out.println(request.getParameter("mysearch2"));
		    String searchValue=request.getParameter("mysearch2");
		    try {
				ResultSet rs=DatabaseManager.getInstance().showVulnerabilityFilter(optionSelected,searchValue);
				while(rs.next())
				{
					System.out.println("ans="+rs.getString(6));
				}
			} catch (InstantiationException | IllegalAccessException
					| ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		    
				
				
	}

}
