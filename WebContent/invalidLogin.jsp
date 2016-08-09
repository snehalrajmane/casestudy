 <%@ page language="java" 
      contentType="text/html; charset=windows-1256"
      pageEncoding="windows-1256"
   %>

   <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"    
      "http://www.w3.org/TR/html4/loose.dtd">

   <html>

      <head>
         <meta http-equiv="Content-Type" 
            content="text/html; charset=windows-1256">
         <title>Invalid Login</title>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%@ include file="header.jsp"%>
      </head>
	
      <body>
         <center>
            <h1>Sorry, you are not a registered user! Please sign up first</h1>
            
            <h3><a href="signup.jsp"> Click Here to Sign Up Page</a></h3>
            <br>
            <br>
            <%session.setAttribute("Exception","Anything"); %>
            <br><%@ include file="footer.jsp"%>
         </center>
      </body>
	
   </html>