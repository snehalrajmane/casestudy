<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%--   <%@ page import="dao.Merger" %> 
       <%@ page import="dao.NessusReportParser" %>  --%>
       <%@ page import="dao.DatabaseManager" %> 
       <%@ page import="dao.Database" %> 
       <%@ page import="dao.Severity" %> 
   <%@ page import="java.util.ArrayList" %>
   <%@ page import="java.util.List" %>
  
   <%@ page import="java.sql.CallableStatement" %> 
   <%@ page import="java.io.File" %> 
   <%@ page import="java.util.Map" %> 
   <%@ page import="java.util.HashMap" %>
   <%@ page import="java.sql.ResultSet" %> 
   <%@ page import= "java.util.Calendar" %> 
   <%@ page import ="java.sql.PreparedStatement" %> 
   <%@ page import ="java.sql.Statement" %> 
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Director | Dashboard</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />

        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <!-- Theme style -->
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
        <link href="css/style2.css" rel="stylesheet" type="text/css" />
         <link href="css/login.css" rel="stylesheet" type="text/css" />
        <script src="tablefilter.js"></script>
        
        
        
        
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


<link rel="stylesheet
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	<link href="css/mystyle.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	
	<script src="dropzone.js"></script>
 <link rel="stylesheet" href="dropzone.css">
<link rel="stylesheet" type="text/css" href="css/form.css">





 <!-- <link href="modal.css" rel="stylesheet" type="text/css" />  -->







<script type="text/javascript">


(function(document) {
	'use strict';

	var LightTableFilter = (function(Arr) {

		var _input;
    var _select;

		function _onInputEvent(e) {
			_input = e.target;
			var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
			Arr.forEach.call(tables, function(table) {
				Arr.forEach.call(table.tBodies, function(tbody) {
					Arr.forEach.call(tbody.rows, _filter);
				});
			});
		}
    
		function _onSelectEvent(e) {
			_select = e.target;
			var tables = document.getElementsByClassName(_select.getAttribute('data-table'));
			Arr.forEach.call(tables, function(table) {
				Arr.forEach.call(table.tBodies, function(tbody) {
					Arr.forEach.call(tbody.rows, _filterSelect);
				});
			});
		}

		function _filter(row) {
      
			var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
			row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';

		}
    
		function _filterSelect(row) {
     
			var text_select = row.textContent.toLowerCase(), val_select = _select.options[_select.selectedIndex].value.toLowerCase();
			row.style.display = text_select.indexOf(val_select) === -1 ? 'none' : 'table-row';

		}

		return {
			init: function() {
				var inputs = document.getElementsByClassName('light-table-filter');
				var selects = document.getElementsByClassName('select-table-filter');
				Arr.forEach.call(inputs, function(input) {
					input.oninput = _onInputEvent;
				});
				Arr.forEach.call(selects, function(select) {
         select.onchange  = _onSelectEvent;
				});
			}
		};
	})(Array.prototype);

	document.addEventListener('readystatechange', function() {
		if (document.readyState === 'complete') {
			LightTableFilter.init();
		}
	});

})(document);

</script> 























 

</head>
    <body class="skin-black">
        <!-- header logo: style can be found in header.less -->
       <%String uname=(String)session.getAttribute("name"); %>
<%--          <% 
         String NessusPath="",QualysPath="";
         int a;
	
	// ArrayList<String> list = (ArrayList<String>)session.getAttribute("FilePathList"); 
	Map<String,String> map= (HashMap<String,String>)session.getAttribute("map");

	/*  out.println("List Value is");
 		for(String st:list)
		out.println(st); */ 
 	for (String key : map.keySet()) {
	 if(key.equalsIgnoreCase("Nessus"))
		 NessusPath=map.get(key);
	 else
		 QualysPath=map.get(key);
	
	 // out.println("key: " + key + " value: " + map.get(key));
	}%>
	 
 	
	<% if(QualysPath.equalsIgnoreCase(""))
	{
		a = DatabaseManager.getInstance().getMaxVulMapID();
		NessusReportParser nessus = new NessusReportParser(NessusPath);
		nessus.sortVulnerabilities();
		nessus.insertVulnerabilityDetails();
		String Epath=request.getRealPath("/")+"images/"+"CSV.xls";
		session.setAttribute("ExcelPath",Epath);
		nessus.writeExcel("D:\\csv4.xls");
		File NessusFileDelete=new File(NessusPath);
		
	}
	
	%>
	<% 
	//else{
	Merger mergeVul = new Merger(NessusPath,QualysPath,"","");
		  a = DatabaseManager.getInstance().getMaxVulMapID();
		 
			/* int b = DatabaseManager.getInstance().getMaxVulMapID(); */
		/* ResultSet rs=DatabaseManager.getInstance().showVulnerability(a,b); 
		 session.setAttribute("before",a);*/
		mergeVul.mergeVulnerabilities();
		mergeVul.sortVulnerabilities();
		mergeVul.insertVulnerabilityDetails();
		//out.println("\n"+"Writing to Excel File");
		//mergeVul.writeExcel("D:\\CS.xls");
		String Epath=request.getRealPath("/")+"images/"+"CSV.xls";
		mergeVul.writeExcel(Epath);
		
	//	out.println("Completed");
		session.setAttribute("ExcelPath",Epath);
		/* int a = DatabaseManager.getInstance().getMaxVulMapID();
		int b = DatabaseManager.getInstance().getMaxVulMapID();
		
		out.println("a="+a+"\tb="+b); */
		
		
		File NessusFileDelete=new File(NessusPath);
		File QualysFileDelete=new File(QualysPath);
		//NessusFileDelete.delete();
		//QualysFileDelete.delete();
	//}
	%> --%> 
        
        
<header class="header">
            <a href="simple.jsp" class="logo">
                <!-- Add the class icon to your logo image or logo icon to add the margining -->
                
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
                
               
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                    <ul class="nav navbar-nav">
                    
                    <!-- <a href="#join_form" id="join_pop">Menu</a> -->
                        <!-- Messages: style can be found in dropdown.less-->
                        <li class="dropdown messages-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-envelope"></i>
                                <span class="label label-success">4</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 4 messages</li>
                                <li>
                                    <!-- inner menu: contains the actual data -->
                                    <ul class="menu">
                                        <li><!-- start message -->
                                            <a href="#">
                                                <div class="pull-left">
                                                    <img src="img/avatar3.png" class="img-circle" alt="User Image"/>
                                                </div>
                                                <h4>
                                                    Support Team
                                                    <small><i class="fa fa-clock-o"></i> 5 mins</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li><!-- end message -->
                                        <li>
                                            <a href="#">
                                                <div class="pull-left">
                                                    <img src="img/avatar2.png" class="img-circle" alt="user image"/>
                                                </div>
                                                <h4>
                                                    Director Design Team
                                                    <small><i class="fa fa-clock-o"></i> 2 hours</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <div class="pull-left">
                                                    <img src="img/avatar.png" class="img-circle" alt="user image"/>
                                                </div>
                                                <h4>
                                                    Developers
                                                    <small><i class="fa fa-clock-o"></i> Today</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <div class="pull-left">
                                                    <img src="img/avatar2.png" class="img-circle" alt="user image"/>
                                                </div>
                                                <h4>
                                                    Sales Department
                                                    <small><i class="fa fa-clock-o"></i> Yesterday</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <div class="pull-left">
                                                    <img src="img/avatar.png" class="img-circle" alt="user image"/>
                                                </div>
                                                <h4>
                                                    Reviewers
                                                    <small><i class="fa fa-clock-o"></i> 2 days</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="footer"><a href="#">See All Messages</a></li>
                            </ul>
                        </li>
                        <li class="dropdown tasks-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-tasks"></i>
                                <span class="label label-danger">9</span>
                            </a>
                            <ul class="dropdown-menu">

                                <li class="header">You have 9 tasks</li>
                                <li>
                                    <!-- inner menu: contains the actual data -->
                                    <ul class="menu">
                                        <li><!-- Task item -->
                                            <a href="#">
                                                <h3>
                                                    Design some buttons
                                                    <small class="pull-right">20%</small>
                                                </h3>
                                                <div class="progress progress-striped xs">
                                                    <div class="progress-bar progress-bar-success" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">20% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                        <li><!-- Task item -->
                                            <a href="#">
                                                <h3>
                                                    Create a nice theme
                                                    <small class="pull-right">40%</small>
                                                </h3>
                                                <div class="progress progress-striped xs">
                                                    <div class="progress-bar progress-bar-danger" style="width: 40%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">40% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                        <li><!-- Task item -->
                                            <a href="#">
                                                <h3>
                                                    Some task I need to do
                                                    <small class="pull-right">60%</small>
                                                </h3>
                                                <div class="progress progress-striped xs">
                                                    <div class="progress-bar progress-bar-info" style="width: 60%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">60% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                        <li><!-- Task item -->
                                            <a href="#">
                                                <h3>
                                                    Make beautiful transitions
                                                    <small class="pull-right">80%</small>
                                                </h3>
                                                <div class="progress progress-striped xs">
                                                    <div class="progress-bar progress-bar-warning" style="width: 80%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">80% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                    </ul>
                                </li>
                                <li class="footer">
                                    <a href="#">View all tasks</a>
                                </li>

                            </ul>
                        </li>
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">

                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-user"></i>
                                <span><%=uname %> <i class="caret"></i></span>
                            </a>
                            <ul class="dropdown-menu dropdown-custom dropdown-menu-right">
                                <li class="dropdown-header text-center">Account</li>

                                <li>
                                    <a href="#">
                                    <i class="fa fa-clock-o fa-fw pull-right"></i>
                                        <span class="badge badge-success pull-right">10</span> Updates</a>
                                    <a href="#">
                                    <i class="fa fa-envelope-o fa-fw pull-right"></i>
                                        <span class="badge badge-danger pull-right">5</span> Messages</a>
                                    <a href="#"><i class="fa fa-magnet fa-fw pull-right"></i>
                                        <span class="badge badge-info pull-right">3</span> Subscriptions</a>
                                    <a href="#"><i class="fa fa-question fa-fw pull-right"></i> <span class=
                                        "badge pull-right">11</span> FAQ</a>
                                </li>
                                
                                
                                <!-- <li class="dropdown messages-menu1">    <a href="#join_form" id="join_pop">Sign Up</a></li> -->
                                
                                
                                
                                

                                <li class="divider"></li>

                                    <li>
                                        <a href="#">
                                        <i class="fa fa-user fa-fw pull-right"></i>
                                            Profile
                                        </a>
                                        <a data-toggle="modal" href="#modal-user-settings">
                                        <i class="fa fa-cog fa-fw pull-right"></i>
                                            Settings
                                        </a>
                                        </li>

                                        <li class="divider"></li>

                                        <li>
                                            <a href="LogoutServlet"><i class="fa fa-ban fa-fw pull-right"></i> Logout</a>
                                        </li>
                                    </ul>

                        </li>
                    </ul>
                     
                
                   
                </div>
            </nav>
        </header>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="img/dashboardlogo2.gif" class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>Hello,<%=uname %></p>

                            <!-- <a href="#"><i class="fa fa-circle text-success"></i> Online</a> -->
                        </div>
                    </div>
                    <!-- search form -->
                    <form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                            <!-- <input type="text" name="q" class="form-control" placeholder="Search..."/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
       -->                      </span>
                        </div>
                    </form>
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                       <li>
                            <a href="simple.jsp">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                        <!-- <li>
                           <a href="#join_form" id="join_pop">
                             <a href="general.jsp"> 
                                <i class="fa fa-gavel"></i> <span>General</span> -->
                               <!--  <a href="#x" class="overlay" id="join_form"></a>
        	<div class="popup">
			<br><br>
     		<img src="images/Dashboard.jpg" name="webLogo" width="175" height="100" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;
       	 	<img src="images/ProcessReport.jpg" name="webLogo1" width="175" height="100" border="0">&nbsp;&nbsp;&nbsp;&nbsp;
        	<img src="images/CustomerReportAnalysis.jpg" name="webLogo2" width="175" height="100" border="0">&nbsp;&nbsp;&nbsp;&nbsp;
        	<img src="images/Settings.jpg" name="webLogo3" width="175" height="100" border="0"><br><br><br>
			<a class="close" href="#close"></a>
            

        </div> -->
                            
                            <!-- </a>
                        </li> -->

                     <!--    <li>
                            <a href="basic_form.jsp">
                                <i class="fa fa-gavel"></i> <span>Process Reports</span>
                            </a>
                        </li> -->

                       <!--  <li class="/pages/active">
                            <a href="simple.jsp">
                                <i class="fa fa-glass"></i> <span>Simple tables</span>
                            </a>
                        </li> -->
                       <!--  <li>
                                    <a href="tables.jsp">
                                        <i class="fa fa-globe"></i> <span>New Vulnerability</span>
                                    </a>
                                </li> -->
                                
                            <li>
                            <a href="barchart.jsp">
                                <i class="fa fa-glass"></i> <span>Executive Summary</span>
                            </a>
                        </li> 
                        
					 <li>
                            <a href="tablefinalcomments.jsp">
                                <i class="fa fa-glass"></i> <span>Recent Vulnerabilities</span>
                            </a>
                        </li> 
                         <li>
                            <a href="SearchFilter.jsp">
                                <i class="fa fa-glass"></i> <span>Search Filter</span>
                            </a>
                        </li>
                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">
            
                    <div class="row">
                        <div class="col-md-12">
                            <section class="panel">
                              <header class="panel-heading">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Recent Vulnerabilities
                              </header>
                              <div class="panel-body">
                              <center>
          
  						<!-- <form id="my-awesome-dropzone"  action="Upload3" class="dropzone" method="POST"> -->  
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				  <div class="row">
                  <div class="col-lg-12">
                      <section class="panel">
                          <!-- <header class="panel-heading">
                              New Vulnerabilities Discovered</header> -->
                              
                              
                              
                              
                              
                              
                              
                              <script>
function myFunction() {
    confirm("Confirmly add to database!");
}
</script>
                              
                              
                              
                          <%DatabaseManager dao2=DatabaseManager.getInstance();
                            		ResultSet rs1=dao2.showLastMonthVulnerability();%>
	
	<!-- <form action="HandleCommentServlet" method="post"> -->
<!-- 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
	<!-- <input id="buttonId4" type="submit" value="Update" name="button" onclick="load()"> -->
	  <form action="HandleCommentServlet2" method="post"> 
	  <!-- <a href="update"></a>  -->
	  <!-- <input type="submit"   name="hello" value="update"> -->
	  <!-- <br> -->
	  <input type="search" class="light-table-filter" data-table="table table-striped table-advance table-hover" placeholder="Filtrer" />
  
  &nbsp;&nbsp;&nbsp;
  <select type="search" class="select-table-filter" data-table="table table-striped table-advance table-hover">
    <option value="">Reset</option>  
    <option value="sda563">sda563</option>  
    <option value="sda571">sda571</option>  
    <option value="sda572">sda572</option>  
  </select><br><br>
	<div STYLE=" height: 450px; width: 1050px; font-size: 13px; overflow: auto;">
	   <table class="table table-striped table-advance table-hover" id="table1" width="100" height="100" border="1">
       <tbody>
          <tr>
             
             <th><i class="icon_calendar"></i>ProductName</th>
             <th><i class="icon_mail_alt"></i>&nbsp;&nbsp;VNAME</th>
             <th><i class="icon_pin_alt"></i>CVEID </th>
             <th><i class="icon_mobile"></i> FounBy</th>
             <th><i class="icon_cogs"></i>ToolSeverity</th>
             <th><i class="icon_cogs"></i>HPSeverity </th>
             <th><i class="icon_cogs"></i> Comments</th>
             
             <!--  <th><i class="icon_cogs"></i> MID</th> 
              <th><i class="icon_cogs"></i> VID</th> -->  
             <th><i class="icon_cogs"></i> Update</th>
          </tr>
          
	<%
	
		int m=0;
		
	while(rs1.next()){
		
		
		String VID=rs1.getString(1);
		String VNAME=rs1.getString(2);
			 String HNAME=rs1.getString(3);
			 
			String VPORT=rs1.getString(4); 
			String VFOUNDBY=rs1.getString(5);
			String VSEVERITY=rs1.getString(6);
			String MID=rs1.getString(8);
			String comment=rs1.getString(9);
			String vseverity=rs1.getString(10);
			
			// k1++;
		%>
		<%-- <input type="hidden" name="VID" value="<%=VID%>">
		<input type="hidden" name="MID" value="<%=MID%>">
		
		
		 --%>
		 <tr>
		 <td> <%=HNAME.split("\\.")[1]%> </td>
		<td><input type="hidden" name="VNAME" value="<%=VNAME%>"><%=VNAME%></td>
		<td><%=rs1.getString(7)%></td>
		<td><%=VFOUNDBY%></td>
		     <td><%=VSEVERITY%></td>   
		<%--   <%if(VSEVERITY.equalsIgnoreCase("low")) {%>
			<td style="color:GREEN;"><%=VSEVERITY%></td>
		<% }%>
		<%if(VSEVERITY.equalsIgnoreCase("medium")) {%>
			<td style="color:ORANGE;"><%=VSEVERITY%></td>
		<% }%>
		<%if(VSEVERITY.equalsIgnoreCase("HIGH")) {%>
			<td style="color:RED;"><%=VSEVERITY%></td>
		<% }%>
		<%if(VSEVERITY.equalsIgnoreCase("CRITICAL")) {%>
			<td style="color:PURPLE;"><%=VSEVERITY%></td>
		<% }%>   --%>
		  
		
		<td>
	
		<%if(vseverity.equalsIgnoreCase("low")) {
			String vseverity2=vseverity.substring(0, 1).toUpperCase()+vseverity.substring(1);
		%>
  	<select name="search">
  		<!-- <option value="low">Low</option> -->
  		<option value="medium">Medium</option>
 		<option value="high">High</option>
  		<option value="critical">Critical</option>
  		<option value="Not Vulnerable">Not Vulnerable</option>
  		<option value="<%=vseverity2%>"><%=vseverity2%></option>
  				</select>
  	
  	<%} %>
  	
  	
  	
  	<%if(vseverity.equalsIgnoreCase("medium")) {
  		String vseverity2=vseverity.substring(0, 1).toUpperCase()+vseverity.substring(1);
  	%>
  	<select name="search">
  		<option value="low">Low</option>
  		<!-- <option value="medium">Medium</option> -->
 		<option value="high">High</option>
  		<option value="critical">Critical</option>
  		<option value="Not Vulnerable">Not Vulnerable</option>
  		<option value="<%=vseverity%>" selected><%=vseverity2%></option>
  				</select>
  	
  	<%} %>
  	
  	
  	<%if(vseverity.equalsIgnoreCase("high")) {
  		String vseverity2=vseverity.substring(0, 1).toUpperCase()+vseverity.substring(1);
  	%>
  	<select name="search">
  		<option value="low">Low</option>
  		<option value="medium">Medium</option>
 		<!-- <option value="high">High</option> -->
  		<option value="critical">Critical</option>
  		<option value="Not Vulnerable">Not Vulnerable</option>
  		<option value="<%=vseverity%>" selected><%=vseverity2%></option>
  				</select>
  	
  	<%} %>
  	
  	
  	<%if(vseverity.equalsIgnoreCase("critical")) {
  	String vseverity2=vseverity.substring(0, 1).toUpperCase()+vseverity.substring(1);
  	%>
  	<select name="search">
  		<option value="low">Low</option>
  		<option value="medium">Medium</option>
 		<option value="high">High</option>
  		<!-- <option value="critical">Critical</option> -->
  		<option value="Not Vulnerable">Not Vulnerable</option>
  		
  		<option value="<%=vseverity%>" selected><%=vseverity2%></option>
  				</select>
  	
  	<%} %> 
  	
  	
  	
  	<%if(vseverity.equalsIgnoreCase("Not Vulnerable")) {
  		String vseverity2=vseverity.substring(0, 1).toUpperCase()+vseverity.substring(1);
  	%>
  	<select name="search">
  		<option value="low">Low</option>
  		<option value="medium">Medium</option>
 		<option value="high">High</option>
  		<option value="critical">Critical</option> 
  		<option value="<%=vseverity%>" selected><%=vseverity2%></option>
  				</select>
  	
  	<%} %>
  	
  	
  		<%if(vseverity.equalsIgnoreCase("")) {%>
  	<select name="search">
  		<option value="low">Low</option>
  		<option value="medium">Medium</option>
 		<option value="high">High</option>
  		<option value="critical">Critical</option> 
  		<option value="Not Vulnerable">Not Vulnerable</option>
  				</select>
  	
  	<%} %>
  	
  	 
  	
	<%-- <%=vseverity%> --%>
	</td>
	
			<td><textarea cols="50" name="comments" id="demo" placeholder="None"><%=comment%></textarea></td>
			
			 <!-- <td>  --> 
			    <!-- <form action="HandleCommentServlet" method="post" autocomplete="off">    --> 
			 <%-- <%String comment=request.getParameter("comments"); %>   --%>
			
			 <%-- <input type="hidden"   name="rowno" value=<%=rs1.getRow()%>>  --%>
			   <%-- <input type="hidden"   name="comment123" value=<%=m%>>  --%>
			   <%session.setAttribute("row",m); %>
			
		<%-- 	<%=MID%>
		   <!-- </form>     -->
			
			 </td> 
			 <td>
			  <%=VID%> </td>--%>
			  <td> 
			  <input type="hidden"   name="VID" value=<%=VID%>>
			<input type="hidden"   name="MID" value=<%=MID%>>
			 <input type="submit"   name="hello" value="update" onclick="myFunction()">
			 </td>
			
  	  	</tr>
  	  	
		<%
		  /* m++; */
		}
		
	//}

	
	
	%>
	               
                           </tbody>
                        </table>
                        </div>
                         </form>   
                      </section>
                      
                      &nbsp;&nbsp;&nbsp; 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<!-- <input id="buttonId4" type="submit" value="Download Excel File" name="button" onclick="load()"> -->
		
	 <!-- <br><br> -->
                  </div>
              </div>
              
           

              
           
	</center>
                   </div>
                            </section>
        
                                
        </div><!-- ./wrapper -->
 
        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script src="js/jquery.min.js" type="text/javascript"></script>

        <!-- Bootstrap -->
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Director App -->
        <script src="js/Director/app.js" type="text/javascript"></script>
    <<%-- /body>
      <div id="footer">
<%@ include file="footer.jsp" %>
</div> --%>


    
</html>