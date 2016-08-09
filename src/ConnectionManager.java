

import java.sql.*;
import java.util.*;


public class ConnectionManager {

   static Connection con;
   static String url;
         
   public static Connection getConnection()
   {
     
      try
      {
         String url = "jdbc:mysql://localhost:3306/voltage"; 
         // assuming "DataSource" is your DataSource name

         Class.forName("com.mysql.jdbc.Driver");
         System.out.println("****************************Driver loaded**********************");
         
         try
         {            	
            con = DriverManager.getConnection(url,"root","root@123"); 
            System.out.println("Connection Object..........................."+con);
             								
         // assuming your SQL Server's	username is "username"               
         // and password is "password"
              
         }
         
         catch (SQLException ex)
         {
            ex.printStackTrace();
         }
      }

      catch(ClassNotFoundException e)
      {
         System.out.println(e);
      }

   return con;
}
}