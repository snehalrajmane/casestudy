


import java.text.*;
import java.util.*;
import java.sql.*;

import dao.Database;

public class UserDAO 	
{
   static Connection currentCon = null;
   static ResultSet rs = null;  
   
   
  /* private DatabaseManager() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException
   {
          this.conn=Database.getInstance().getConn();
   }*/

	
   public static UserBean login(UserBean bean) {
	   
	 //  this.conn=Database.getInstance().getConn();
	
      //preparing some objects for connection 
      Statement stmt = null;    
	
      String username = bean.getUsername();    
      String password = bean.getPassword();   
	    
      String searchQuery =
            "select * from users where UserName='"
                     + username
                     + "' AND Password='"
                     + password
                     + "'";
	    
   // "System.out.println" prints in the console; Normally used to trace the process
   System.out.println("Your user name is " + username);          
   System.out.println("Your password is " + password);
   System.out.println("Query: "+searchQuery);
	    
   try 
   {
      //connect to DB 
	   currentCon = Database.getInstance().getConn();
      
      stmt=currentCon.createStatement();
      rs = stmt.executeQuery(searchQuery);	        
      boolean more = rs.next();
	       
      // if user does not exist set the isValid variable to false
      if (!more) 
      {
         System.out.println("Sorry, you are not a registered user! Please sign up first");
         bean.setValid(false);
      } 
	        
      //if user exists set the isValid variable to true
      else if (more) 
      {
         String UName = rs.getString("UserName");
         String Password = rs.getString("Password");
         String lastName = rs.getString("LastName");
         String firstName = rs.getString("FirstName");
	     	
         System.out.println("Welcome " + UName);
         bean.setUserName(UName);
         bean.setPassword(Password);
         bean.setFirstName(firstName);
         bean.setLastName(lastName);
         bean.setValid(true);
      }
   } 

   catch (Exception ex) 
   {
      System.out.println("Log In failed: An Exception has occurred! " + ex);
   } 
	    
   //some exception handling
   finally 
   {
     /* if (rs != null)	{
         try {
            rs.close();
         } catch (Exception e) {}
            rs = null;
         }
	
      if (stmt != null) {
         try {
            stmt.close();
         } catch (Exception e) {}
            stmt = null;
         }
	
      if (currentCon != null) {
         try {
            currentCon.close();
         } catch (Exception e) {
         }

         currentCon = null;
      }*/
   }

return bean;
	
   }	
   
   public UserDAO() {
	super();
	// TODO Auto-generated constructor stub
}

public static void insertValuesToDB(UserBean bean) throws UserExistException{
	   
	   
	int flag=0;
	   try {
		   currentCon=Database.getInstance().getConn();
	   String query="insert into users values(?,?,?,?);";
	   
	    CallableStatement cs = currentCon.prepareCall("call sp_createUser(?,?,?,?,?)");
	   //PreparedStatement ps=currentCon.prepareStatement(query);
		System.out.println();
		cs.setString(1, bean.getFirstName());
		cs.setString(2, bean.getLastName());
		cs.setString(3, bean.getUsername());
		cs.setString(4, bean.getPassword());
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.executeQuery();
		String str=cs.getString(5);
		System.out.println("Answer of Callable is"+str);
		if(str.equalsIgnoreCase("false"))
		{
			throw new UserExistException();
		}
		//int i=ps.executeUpdate();
		
		/*if(i>0){
			System.out.println("Record insert to DB with details as:"+bean);
		}
		else{
			System.out.println("Record not inserted some problem..........");
		}*/
	}
	   /*catch(UserExistException ue)
	   {
		   System.out.println("User already exist");
		   
	   }*/
	   
	   catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (InstantiationException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (IllegalAccessException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
   }
}