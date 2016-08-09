<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="css/style2.css"> 
 <link href="css/mystyle.css" rel="stylesheet">
    
    
    <link href="css/login.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>
  <div class="login-form">
     <h1>Vulnerability Management System</h1>
     <h2>"Secure to Assure"</h2>
     <form role="form" action="LoginServlet" method="post" id="login-form" autocomplete="off">
     <div class="form-group ">
       <input type="text" class="form-control" name="un" placeholder="Username" id="UserName">
       <i class="fa fa-user"></i>
     </div>
     <div class="form-group log-status">
       <input type="password" class="form-control" name="pw" placeholder="Password" id="Passwod">
       <i class="fa fa-lock"></i>
     </div>
     
      <span class="alert">Invalid Credentials</span>
      <!-- <a class="link" href="#">Lost your password?</a> -->
     <!-- <button type="button" class="log-btn" >Log in</button> -->
      <input type="submit" id="btn-login" class="log-btn" value="Log in">
     
    </form>
   </div>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

        <script src="js/index.js"></script>
       
    
    
</body>
 <div id="footer">
<%@ include file="footer.jsp" %>
</div>
</html>