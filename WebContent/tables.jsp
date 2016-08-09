<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%--          <%@ page import="dao.Merger" %> 
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
                                <span><%=uname%> <i class="caret"></i></span>
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
                            <p>Hello,<%=uname%></p>

                            <!-- <a href="#"><i class="fa fa-circle text-success"></i> Online</a> -->
                        </div>
                    </div>
                    <!-- search form -->
                    <form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                           <!--  <input type="text" name="q" class="form-control" placeholder="Search..."/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button> -->
                            </span>
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

                        <li>
                            <a href="basic_form.jsp">
                                <i class="fa fa-gavel"></i> <span>Process Reports</span>
                            </a>
                        </li>

                       <!--  <li class="/pages/active">
                            <a href="simple.jsp">
                                <i class="fa fa-glass"></i> <span>Simple tables</span>
                            </a>
                        </li> -->
                        <li>
                                    <a href="tables.jsp">
                                        <i class="fa fa-globe"></i> <span>New Vulnerability</span>
                                    </a>
                                </li>
                                
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
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; New Vulnerabilities Discovered
                              </header>
                              <div class="panel-body">
                              <center>
          
  						<!-- <form id="my-awesome-dropzone"  action="Upload3" class="dropzone" method="POST"> -->  
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				  <div class="row">
                  <div class="col-lg-12">
                      <section class="panel">
                          <!-- <header class="panel-heading">
                              New Vulnerabilities Discovered</header> -->
                              
                              
                              
                              
                              
                              <%
                              
                              int a=(Integer)session.getAttribute("oldVulmapId");
								int count=0;
								int hcount=0,lcount=0,mcount=0,ccount=0;
								int b = DatabaseManager.getInstance().getMaxVulMapID();
								ResultSet rs=DatabaseManager.getInstance().showVulnerability(a,b);
								/* ResultSet rs4=DatabaseManager.getInstance().showAllVulnerability(); */
								Map<String,Integer> map1=new HashMap<String,Integer>();
								Map<String,Map<String,Integer>> map7=new HashMap<String,Map<String,Integer>>();
								int count1=1;
								
								
								
								/* if(rs.getRow()<=1)
									out.println("No New Vulnerabilities Found!!!");
								else{ */
                              
                              
                              
                              %>
                              
                              
                              
                              
                              
                               <form action="HandleCommentServlet" method="post"> 
                               
                               
                                <input type="search" class="light-table-filter" data-table="table table-striped table-advance table-hover" placeholder="Filtrer" />
  
  &nbsp;&nbsp;&nbsp;
  <select type="search" class="select-table-filter" data-table="table table-striped table-advance table-hover">
    <option value="">Reset</option>  
    <option value="sda563">sda563</option>  
    <option value="sda571">sda571</option>  
    <option value="sda572">sda572</option>  
  </select><br><br>
                               
                               
                                                             
                              <script>
function myFunction() {
    confirm("Confirmly add to database!");
}
</script>
                               
                          
                          <table class="table table-striped table-advance table-hover">
                           <tbody>
                              <tr>
                                 <!-- <th><i class="icon_profile"></i> VID</th> -->
                                 <th><i class="icon_mail_alt"></i>ProductNAME </th>
                               <th><i class="icon_calendar"></i>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VNAME</th>
                                 
                                 <th><i class="icon_pin_alt"></i>VPORT </th>
                                 <th><i class="icon_mobile"></i>FOUNDBY</th>
                                 <th><i class="icon_cogs"></i> ToolSeverity</th>
                                 <th><i class="icon_cogs"></i>HPESeverity</th>
             					<th><i class="icon_cogs"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Comments</th>
                                 
                                 <th><i class="icon_cogs"></i> Update</th>
                              </tr>
                              
                              
                              
                              <%
                              		
									while(rs.next())
									{
										 int VID=rs.getInt(1);
	      								String VNAME=rs.getString(2);
	     								String HNAME=rs.getString(3);
	     								String VPORT=rs.getString(4);
	     								String VFOUNDBY=rs.getString(5);
	      								String VSEVERITY=rs.getString(6);
	      								String MID=rs.getString(8);
	      								String comment=rs.getString(9);
	      								String severity=rs.getString(10);
							  %>
							  
							  
							  <%
								if(map7.containsKey(HNAME)){
								Map<String,Integer> map5=map7.get(HNAME);
								if(map7.get(HNAME).containsKey(VSEVERITY)){
								int k3=(Integer)map7.get(HNAME).get(VSEVERITY);
								//Set<String> newlist=new HashSet<String>();
								//newlist.add(VSEVERITY);
								k3++;
								map5.put(VSEVERITY,k3);
								map7.put(HNAME,map5);
							}
						else{
							map5 = map7.get(HNAME);
							map5.put(VSEVERITY, count1);
							map7.put(HNAME, map5);
							}
		
			}
			else{
				Map<String,Integer> mapp=new HashMap<String,Integer>();
				mapp.put(VSEVERITY,count1);
				map7.put(HNAME, mapp);
				}
	%>  
	
							  
							  
							  
							  
								<tr>
                                 <%-- <td><%=VID%></td> --%>
                                 <td><%=HNAME.split("\\.")[1]%></td>
                                 <td><%=VNAME%></td>
                                 <td><%=VPORT%></td>
                                 <td><%=VFOUNDBY%></td>
                                 	<%if(Severity.LOW.toString().equalsIgnoreCase(VSEVERITY)){ lcount++;%> 
									<td><%=VSEVERITY%></td><%} %>
								<% if(Severity.MEDIUM.toString().equalsIgnoreCase(VSEVERITY)){mcount++;%>
									<td><%=VSEVERITY%></td><%} %>
								<% if(Severity.HIGH.toString().equalsIgnoreCase(VSEVERITY)){hcount++;%>
									<td><%=VSEVERITY%></td><%} %>
								<%if(Severity.CRITICAL.toString().equalsIgnoreCase(VSEVERITY)){ ccount++;%> 
									<td><%=VSEVERITY%></td><%} %>
                                 
                                 
                                 
                              
							
                                  <%
                                  /* } */ 
									session.setAttribute("low",lcount);
									session.setAttribute("medium",mcount);
									session.setAttribute("high",hcount);
									session.setAttribute("critical",ccount);
									session.setAttribute("hostcount",map7);
                                  %>
                                  <% 
                                  
                                
                                  
                                  
                                  /* session.setAttribute("allhost",map72); */
                                  
                                  %>
                                  
                                  <td>
	
	<%-- <select name="search">
  		<option value="low">Low</option>
  		<option value="medium">Medium</option>
 		<option value="high">High</option>
  		<option value="critical">Critical</option>
  		<option value="<%=severity%>" selected><%=severity%></option> --%>
  	<%if(severity.equalsIgnoreCase("low")) {%>
  	<select name="search">
  		<option value="low">Low</option>
  		<option value="medium">Medium</option>
 		<option value="high">High</option>
  		<option value="critical">Critical</option>
  		<option value="<%=severity%>" selected><%=severity%></option>
  				</select>
  	
  	<%} %>
  	
  	
  	
  	<%if(severity.equalsIgnoreCase("medium")) {%>
  	<select name="search">
  		<option value="low">Low</option>
  		<!-- <option value="medium">Medium</option> -->
 		<option value="high">High</option>
  		<option value="critical">Critical</option>
  		<option value="<%=severity%>" selected><%=severity%></option>
  				</select>
  	
  	<%} %>
  	
  	
  	<%if(severity.equalsIgnoreCase("high")) {%>
  	<select name="search">
  		<option value="low">Low</option>
  		<option value="medium">Medium</option>
 		<!-- <option value="high">High</option> -->
  		<option value="critical">Critical</option>
  		<option value="<%=severity%>" selected><%=severity%></option>
  				</select>
  	
  	<%} %>
  	
  	
  	<%if(severity.equalsIgnoreCase("critical")) {%>
  	<select name="search">
  		<option value="low">Low</option>
  		<option value="medium">Medium</option>
 		<option value="high">High</option>
  		<!-- <option value="critical">Critical</option> -->
  		<option value="<%=severity%>" selected><%=severity%></option>
  				</select>
  	
  	<%} %>
  		

		
	
	</td>
	
			<td><textarea cols="50" name="comments" id="demo" placeholder="None"><%=comment%></textarea></td>
			
			
			
			
			
			
			
			 <td> 
			  <input type="hidden"   name="VID" value=<%=VID%>>
			 <input type="hidden"   name="MID" value=<%=MID%>> 
			
			 <input type="submit"   name="hello" value="update" onclick="myFunction()">
			 </td>
                       	</tr>
                       	<%} %>                 
                           </tbody>
                        </table>
                        </form>
                        <%-- <%} %> --%>
                      </section>
                      &nbsp;&nbsp;&nbsp;<form action="DownloadFileServlet" method="post"> 
		&nbsp;&nbsp;&nbsp;&nbsp;<input id="buttonId4" type="submit" value="Download Excel File" name="button" onclick="load()">
		
	</form> <br><br>
                  </div>
              </div>
              
              <% 	 
              
          	String []s1;
              int []llcount1;
              int []mmcount1;
              int []hhcount1;
              int []cccount1;
              int i=0;
	  	  	Map<String,Integer> map3=new HashMap<String,Integer>();	
	  	  s1=new String[map7.keySet().size()];
	  	  llcount1=new int[map7.keySet().size()];
	  	  mmcount1=new int[map7.keySet().size()];
	  	  hhcount1=new int[map7.keySet().size()];
	  	  cccount1=new int[map7.keySet().size()];
	  	  	for (Map.Entry<String,Map<String,Integer>> entry:map7.entrySet()) {
	  	  	map3=entry.getValue();
			//out.println("Host Name:"+entry.getKey());
			s1[i]=entry.getKey().substring(16,22);
			for(Map.Entry<String,Integer> entry2:map3.entrySet())
			{
				if(entry2.getKey().equalsIgnoreCase("LOW"))
				{
					llcount1[i]=entry2.getValue();
				}
				if(entry2.getKey().equalsIgnoreCase("MEDIUM"))
				{
					mmcount1[i]=entry2.getValue();
				}
				if(entry2.getKey().equalsIgnoreCase("HIGH"))
				{
					hhcount1[i]=entry2.getValue();
				}
				if(entry2.getKey().equalsIgnoreCase("CRITICAL"))
				{
					cccount1[i]=entry2.getValue();
				}
				//out.println("\t"+entry2.getKey() + "= " + entry2.getValue());
			}
		i=i+1;
	}

			session.setAttribute("hostname",s1);
			session.setAttribute("lowcount",llcount1);
			session.setAttribute("mediumcount",mmcount1);
			session.setAttribute("highcount",hhcount1);
			session.setAttribute("criticalcount",cccount1);
			request.setAttribute("hostname",s1);
	String []ac=(String[])session.getAttribute("hostname");
	//Calendar today = Calendar.getInstance();
	//out.println("Current Date"+today);
	
	%>	
              
            <%--   <%    
              String months[]=new String[6];
              int LowTotal[]=new int[6];
        	  int MediumTotal[]=new int[6];
        	  int HighTotal[]=new int[6];
        	  int CriticalTotal[]=new int[6];
              String[] monthName = { "January", "February", "March", "April", "May", "June", "July",
 		        "August", "September", "October", "November", "December" };
 		Calendar now = Calendar.getInstance();
 		Calendar now1 = Calendar.getInstance();
 		Calendar now2 = Calendar.getInstance();
 		java.sql.Date d1 = new java.sql.Date(now.getTimeInMillis());
		now.add(Calendar.MONTH,-6);
		java.sql.Date d2 = new java.sql.Date(now.getTimeInMillis());
		out.println("D1"+d1);
		out.println("D2"+d2);
 		
 		%> --%>
              
              
              
       <%--        
             <%  
             String months[]=new String[6];
             int LowTotal[]=new int[6];
       	  int MediumTotal[]=new int[6];
       	  int HighTotal[]=new int[6];
       	  int CriticalTotal[]=new int[6];
             String[] monthName = { "January", "February", "March", "April", "May", "June", "July",
		        "August", "September", "October", "November", "December" };
		Calendar now = Calendar.getInstance();
		Calendar now1 = Calendar.getInstance();
		Calendar now2 = Calendar.getInstance();
		Connection con = Database.getInstance().getConn();
		java.sql.Date d1 = new java.sql.Date(now.getTimeInMillis());
		now.add(Calendar.MONTH,-6);
		java.sql.Date d2 = new java.sql.Date(now.getTimeInMillis());
		months[0]=monthName[now1.get(Calendar.MONTH)];
		//System.out.println(months[0]);
		/*now1.add(Calendar.MONTH,-1);*/
		for(int k=1;k<=5;i++)
		{
			now1.add(Calendar.MONTH,-1);
			String month5= monthName[now1.get(Calendar.MONTH)];
			months[k]=month5;
			//System.out.println("Name="+months[i]);
			}
		
		for(int j=0;i<=5;i++)
		{
			java.sql.Date date4 = new java.sql.Date(now2.getTimeInMillis());
			out.println("date4="+date4);
			now2.add(Calendar.MONTH,-1);
			java.sql.Date date5 = new java.sql.Date(now2.getTimeInMillis());
			out.println("date5="+date5);
			PreparedStatement pstmt1 =con.prepareStatement("select vs_vulmap.VID ,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,DATE from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID where DATE between ? AND ?");
			pstmt1.setDate(1,date5); 
			pstmt1.setDate(2,date4); 
			ResultSet rs1 = pstmt1.executeQuery();
			int TotalLow=0,TotalMedium=0,TotalHigh=0,TotalCritical=0;
			while(rs1.next())
			{
				count++;
				if(rs1.getString(6).equalsIgnoreCase("LOW"))
				{
					TotalLow++;
				}
				if(rs1.getString(6).equalsIgnoreCase("MEDIUM"))
				{
					TotalMedium++;
				}
				if(rs1.getString(6).equalsIgnoreCase("HIGH"))
				{
					TotalHigh++;
				}
				if(rs1.getString(6).equalsIgnoreCase("CRITICAL"))
				{
					TotalCritical++;
				}
				//System.out.println("host="+rs.getInt(4));
			//	System.out.println("Vulnerability Id="+rs.getInt(1)+"\thname"+rs.getString(3)+"\tseverity  "+rs.getString(6)+"\tDate"+rs.getDate(7));
			//	out.println("Each Low="+TotalLow+"Medium="+TotalMedium+"High="+TotalHigh+"Critical="+TotalCritical);
			}
			LowTotal[j]=TotalLow;
			MediumTotal[j]=TotalMedium;
			HighTotal[j]=TotalHigh;
			CriticalTotal[j]=TotalCritical;
			out.println("Total Low="+TotalLow+"Medium="+TotalMedium+"High="+TotalHigh+"Critical="+TotalCritical);
			//java.util.Date date=now1.getTime();
		
		}
		/*for(int i=0;i<=5;i++)
		{
			System.out.println("Month="+LowTotal[i]);
		}*/
		
	 	Statement stmt=con.createStatement();
		//PreparedStatement pstmt =this.conn.prepareStatement("select * from vs_vulmap where DATE between ? AND ?"); 
		//PreparedStatement pstmt =con.prepareStatement("select vs_vulmap.VID ,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,DATE from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID where DATE between ? AND ?"); 
		//pstmt.setDate(1,d2); 
		//pstmt.setDate(2,d1); 
		//ResultSet rs3 = pstmt.executeQuery();
		//int count4=0,TotalLow=0,TotalMedium=0,TotalHigh=0,TotalCritical=0;
		//while(rs3.next())
	//	{
		//	count4++;
			/*if(rs.getString(6).equalsIgnoreCase("LOW"))
			{
				TotalLow++;
			}
			if(rs.getString(6).equalsIgnoreCase("MEDIUM"))
			{
				TotalMedium++;
			}
			if(rs.getString(6).equalsIgnoreCase("HIGH"))
			{
				TotalHigh++;
			}
			if(rs.getString(6).equalsIgnoreCase("CRITICAL"))
			{
				TotalCritical++;
			}*/
			//System.out.println("host="+rs.getInt(4));
		//	System.out.println("Vulnerability Id="+rs.getInt(1)+"\thname"+rs.getString(3)+"\tseverity  "+rs.getString(6)+"\tDate"+rs.getDate(7));
			
	//	}
		%>
		
	
              
              
               --%>
              
              
              
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				<%-- <table  width="60%>
 	 <caption>Today's Vulnerability</caption>
 	 <!-- //frame="box" -->
  <tr><th>VID</th><th>VNAME</th><th>HNAME</th><th>VPORT</th><th>VFOUNDBY</th><th>VSEVERITY</th></tr>
	<%
	int count=0;
	 int hcount=0,lcount=0,mcount=0,ccount=0;
	 
	
	 
		int b = DatabaseManager.getInstance().getMaxVulMapID();
	ResultSet rs=DatabaseManager.getInstance().showVulnerability(a,b);
	Map<String,Integer> map1=new HashMap<String,Integer>();
	Map<String,Map<String,Integer>> map7=new HashMap<String,Map<String,Integer>>();
	
	//Map<String,Map<Set<String>,Integer>> map2=new HashMap<String,Map<Set<String>,Integer>>();
	int count1=1;
	while(rs.next())
	{
		 int VID=rs.getInt(1);
	      String VNAME=rs.getString(2);
	      String HNAME=rs.getString(3);
	      String VPORT=rs.getString(4);
	      String VFOUNDBY=rs.getString(5);
	      String VSEVERITY=rs.getString(6);
	  %>
	<tr>
	<td><%=VID%></td>
	<td><%=VNAME%></td>
	<td><%=HNAME%></td>
	<td><%=VPORT%></td>
	<td><%=VFOUNDBY%></td>
<%
	if(map7.containsKey(HNAME)){
		
		Map<String,Integer> map5=map7.get(HNAME);
		
		if(map7.get(HNAME).containsKey(VSEVERITY)){
			
			
			int k3=(Integer)map7.get(HNAME).get(VSEVERITY);
			//Set<String> newlist=new HashSet<String>();
			//newlist.add(VSEVERITY);
			k3++;
			map5.put(VSEVERITY,k3);
			map7.put(HNAME,map5);
			
		}
		else{
			
			
			//Set<String> setlist=map2.keySet();
			//map2.get(HNAME).
			//Set<String> newlist=new HashSet<String>();
			//setlist.add(VSEVERITY);
			//Map<Set<String>,Integer> map3=new HashMap<Set<String>,Integer>();	
			//map3.put(setlist,count1);
			//map2.put(HNAME, map3);
			map5 = map7.get(HNAME);
			map5.put(VSEVERITY, count1);
			map7.put(HNAME, map5);
		}
		
	}
	else{
		Map<String,Integer> mapp=new HashMap<String,Integer>();
		//Set<String> list1=new HashSet<String>();
		//Set<Integer> list2=new HashSet<Integer>();
		//list1.add(VSEVERITY);
		//list2.add(count1);
		mapp.put(VSEVERITY,count1);
		map7.put(HNAME, mapp);
		
		
	}
	%>  
	
	<%if(map1.containsKey(HNAME)){
		int k=(Integer)map1.get(HNAME);
		map1.put(HNAME, map1.get(HNAME) + 1);
		
	}
	else{
		map1.put(HNAME,count1);
	}
		
	%>
	
	<%if(Severity.LOW.toString().equalsIgnoreCase(VSEVERITY)){ lcount++;%> 
	<td><%=VSEVERITY%></td><%} %>
	<% if(Severity.MEDIUM.toString().equalsIgnoreCase(VSEVERITY)){mcount++;%>
	<td><%=VSEVERITY%></td><%} %>
		<% if(Severity.HIGH.toString().equalsIgnoreCase(VSEVERITY)){hcount++;%>
	<td><%=VSEVERITY%></td><%} %>
	<%if(Severity.CRITICAL.toString().equalsIgnoreCase(VSEVERITY)){ ccount++;%> 
	<td><%=VSEVERITY%></td><%} %>
	
	</tr>
	<%
		count++;
	  }
	session.setAttribute("low",lcount);
	session.setAttribute("medium",mcount);
	session.setAttribute("high",hcount);
	session.setAttribute("critical",ccount);
	
	//out.println("count in merge ="+count);
	 // out.println("low="+lcount+"\tmedium="+mcount+"\thigh="+hcount+"\tcritical="+ccount+"total="+count);
	
	session.setAttribute("hostcount",map7);
	 %>
	</table> 
	  	  				
	  	  			<% 	 
	  	  			String []s1;
	  	  			//int i=0;
	  	  			Map<String,Integer> map3=new HashMap<String,Integer>();	
	  	  			///s1=new String[map7.keySet().size()];
	for (Map.Entry<String,Map<String,Integer>> entry:map7.entrySet()) {
		map3=entry.getValue();
	//	Set<List<String>> list1=map3.keySet();
		out.println("Host Name:"+entry.getKey());
		
	///	out.println("Initial Key = " + s1[i]);
		
		for(Map.Entry<String,Integer> entry2:map3.entrySet())
		{
		
	    out.println("\t"+entry2.getKey() + "= " + entry2.getValue());
		}
		//i++;
	}

///	session.setAttribute("hostname",s1);
	///String []ac=(String[])session.getAttribute("hostname");
	
	%>	
	  	  				 --%>
	  	  				
	  	  				
	  	  				
	  	  				
	  
		<!-- 				</form>
						
						<form action="MergeFileServlet" method="post"> 
	
	<input id="buttonID" type="submit" value="Merge" onclick="load()">
	</form> -->
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
    </body>
      <div id="footer">
<%@ include file="footer.jsp" %>
</div>
    
</html>