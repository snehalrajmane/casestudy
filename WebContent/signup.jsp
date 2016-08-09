<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	response.setHeader("Cache-Control", "no-store,must-revalidate");
	response.setHeader("Pragma", "no-cache");
	/* response.setDateHeader("Expires", -1); */%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration Form</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
 <!-- <link rel="stylesheet" type="text/css" href="css/signupstyle.css"> -->
<link rel="stylesheet" type="text/css"
	href="css/bootstrap-responsive.css">
<link rel="stylesheet" type="text/css"
	href="css/bootstrap-responsive.min.css">
	
</head>
<body>
<br><br><%@ include file="header.jsp"%>
<% session=request.getSession(false); %>

	<br><br>
	<h1 align="center">
	
		<b>REGISTRATION FORM....</b>
	</h1>
	
	<br>
	

	 <center>
	 
	<form action="InsertServlet" method="post" autocomplete="off">
	
		<div>
			<label for="inputFirstname">First Name </label>
			<div>
				<input type="text" name="firstname" maxlength="12"
					placeholder="firstname" required></input>
			</div>
		</div>

		<div>
			<label for="inputLastname">Last Name </label>
			<div>
				<input type="text" name="lastname" maxlength="12"
					placeholder="lastname" required></input>
			</div>
		</div>

		<div>
			<label for="userName">User Name</label>
			<div>
				<input type="text" name="username" maxlength="10"
					placeholder="Ex:firstname_lastname" required></input>

			</div>
		</div>

		<div>
			<label for="passWord">Password</label>
			<div>
				<input type="password" name="password" maxlength="50"
					 required></input>
			</div>
		</div>

	 <br>

		<div>
			<div>
				 <input type="submit"
					value="Submit" />
					<input type="reset" value="Reset" />
			</div>
		</div>
		
		

	</form>

	<br><br>
	<%@ include file="footer.jsp"%>
 </center>
</body>
</html>
</body>
</html>