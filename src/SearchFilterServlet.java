

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DatabaseManager;

/**
 * Servlet implementation class SearchFilterServlet
 */
public class SearchFilterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchFilterServlet() {
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
		
		PrintWriter out=response.getWriter();
		int dateflag=0,severityflag=0,productflag=0;
		String productname=request.getParameter("productname");
		String severity=request.getParameter("severity");
		String date=request.getParameter("date");
		if(date.equalsIgnoreCase("")||date.equalsIgnoreCase(null))
			dateflag=1;
		if(severity.equalsIgnoreCase("")||severity.equalsIgnoreCase(null))
			severityflag=1;
		if(productname.equalsIgnoreCase("")||productname.equalsIgnoreCase(null))
			productflag=1;
		out.println("Ans="+productname+"severity="+severity+"Date="+date);
		int count=0;
		if(productflag==0 && severityflag==1&&dateflag==1)
		{
			
			DatabaseManager db;
			try {
				db = DatabaseManager.getInstance();
				ResultSet rs=db.showAllSearch(productname);
				
				while(rs.next())
				{
					count++;
				}
			} catch (InstantiationException | IllegalAccessException
					| ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			out.println("count="+count);
			
		}
		
		/*if( productflag==0 && severityflag==0&& dateflag==1)
		{
			
			
			DatabaseManager db;
			try {
				db = DatabaseManager.getInstance();
				ResultSet rs=db.showAllSearch(productname,severity);
				
				while(rs.next())
				{
					count++;
				}
			} catch (InstantiationException | IllegalAccessException
					| ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			out.println("count="+count);
		}*/
		/*if( productflag==0 && severityflag==0&& dateflag==0)
		{
			
			
			DatabaseManager db;
			try {
				db = DatabaseManager.getInstance();
				ResultSet rs=db.showAllSearch(productname,severity,date);
				
				while(rs.next())
				{
					count++;
				}
			} catch (InstantiationException | IllegalAccessException
					| ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			out.println("count="+count);
		}*/
		
		
	}

}
