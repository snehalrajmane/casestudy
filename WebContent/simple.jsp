<%@page import="java.sql.Statement"%>
<%@page import="dao.HostDetails"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@ page import="java.util.Map" %>
    <%@ page import="java.util.HashMap" %>
    <%@ page import="dao.DatabaseManager" %> 
    <%@ page import="java.sql.ResultSet" %>
    <%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		 <title>Director | Simple Tables</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- google font -->
        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <!-- Theme style -->
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        
        <!-- my Addition -->
        <link href="../bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="../bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="../bower_components/datatables-responsive/css/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    
    
    
    
    
    <link rel="stylesheet" href="sortable-theme-dark.css" />
<script src="sortable.min.js"></script>
    
     
        
   <script src="amcharts/amcharts.js" type="text/javascript"></script>
         <script src="amcharts/serial.js" type="text/javascript"></script>
<script type="text/javascript">
		var chartData = new Array();
		var chartData1 = new Array();
		<%DatabaseManager.getInstance().showRecentVulnerability();%>; 
		 <%DatabaseManager d1=DatabaseManager.getInstance();%>
		 <%String[] months=DatabaseManager.months;%>;
		 <%int[] low=DatabaseManager.LowTotal;%>;
		 <%int[] medium=DatabaseManager.MediumTotal;%>;
		 <%int[] high=DatabaseManager.HighTotal;%>;
		 <%int[] critical=DatabaseManager.CriticalTotal;%>;
		 
		 
		 <%int[] hpelow=DatabaseManager.HPELowTotal;%>;
		 <%int[] hpemedium=DatabaseManager.HPEMediumTotal;%>;
		 <%int[] hpehigh=DatabaseManager.HPEHighTotal;%>;
		 <%int[] hpecritical=DatabaseManager.HPECriticalTotal;%>;
		 /* String Month4[]=databaseManager.months; */
		 var jsArr1 = new Array();  
		 var lowCount = new Array();  
         var mediumCount = new Array();  
         var highCount = new Array();  
         var criticalCount = new Array();
         
         
         
    	 var jsArr2 = new Array();  
		 var hpelowCount = new Array();  
         var hpemediumCount = new Array();  
         var hpehighCount = new Array();  
         var hpecriticalCount = new Array();
		<%--  <%String[] months= d1.months;%>;
		 <%String[] months= d1.months;%>; 
		 <%String[] months= d1.months;%>; 
		 <%String[] months= d1.months;%>;  --%>
		 <%  int j=0;
	        for (int i=months.length-1; i >=0 ; i--) {  
	        %>
	        jsArr1[<%= j %>] = '<%=months[i] %>';
	        lowCount[<%= j %>] = '<%=low[i] %>'; 
	         mediumCount[<%= j %>] = '<%=medium[i] %>'; 
	       	 highCount[<%= j %>] = '<%=high[i] %>'; 
	         criticalCount[<%= j %>] = '<%=critical[i] %>'; 
	       <%--  alert(jsArr1[<%= j %>]);
	        alert(lowCount[<%= j %>]); --%>
	        chartData[<%= j %>] =new Array();
	       	 chartData[<%= j %>]["category"]= jsArr1[<%= j %>];
	         chartData[<%= j %>]["column-1"]=lowCount[<%= j %>];
	         chartData[<%= j %>]["column-2"]=mediumCount[<%= j%>];
	         chartData[<%= j %>]["column-3"]=highCount[<%= j %>];
	         chartData[<%= j %>]["column-4"]=criticalCount[<%= j%>];
	   <%j++;}%> 
	   
	   
	    
	    <%  int l=0;
       for (int i=months.length-1; i >=0 ; i--) {  
       %>
       jsArr2[<%= l %>] = '<%=months[i] %>';
       hpelowCount[<%= l %>] = '<%=hpelow[i] %>'; 
        hpemediumCount[<%= l %>] = '<%=hpemedium[i] %>'; 
      	 hpehighCount[<%= l %>] = '<%=hpehigh[i] %>'; 
        hpecriticalCount[<%= l %>] = '<%=hpecritical[i] %>'; 
       <%-- alert(jsArr2[<%= l %>]);
       alert(hpelowCount[<%= l %>]); --%>
       chartData1[<%= l %>] =new Array();
      	 chartData1[<%= l %>]["category"]= jsArr2[<%= l %>];
        chartData1[<%= l %>]["column-1"]=hpelowCount[<%= l %>];
        chartData1[<%= l %>]["column-2"]=hpemediumCount[<%=l%>];
        chartData1[<%= l %>]["column-3"]=hpehighCount[<%= l %>];
        chartData1[<%= l %>]["column-4"]=hpecriticalCount[<%=l%>];
  <%l++;}%>  
  
  
  
		 
			AmCharts.makeChart("chartdiv",
				{
					"type": "serial",
					"categoryField": "category",
					"startDuration": 1,
					"categoryAxis": {
						"gridPosition": "start"
					},
					"trendLines": [],
					"graphs": [
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 0.7,
							"id": "AmGraph-1",
							"lineAlpha": 0,
							"title": "LOW",
							"valueField": "column-1"
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 0.7,
							"id": "AmGraph-2",
							"lineAlpha": 0,
							"title": "MEDIUM",
							"valueField": "column-2"
						
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 0.7,
							"id": "AmGraph-3",
							"title": "HIGH",
							"lineAlpha": 0,
							"valueField": "column-3"
						
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 0.7,
							"id": "AmGraph-4",
							"title": "CRITICAL",
							"lineAlpha": 0,
							"valueField": "column-4"
							
						}
					],
					"guides": [],
					"valueAxes": [
						{
							"id": "ValueAxis-1",
							"stackType": "regular",
							"title": "No. of Vulnerabilities"
						}
					],
					"allLabels": [],
					"balloon": {},
					"legend": {
						"enabled": true
					},
					"titles": [
						{
							"id": "Title-1",
							"size": 15,
							"text": "Risk Before Analysis"
						}
					],
					"dataProvider":chartData
						/*  [
						{
							"category": "category 1",
							"column-1": 8,
							"column-2": 5,
							"column-3": 81,
							"column-4": 53
						},
						{
							"category": "category 2",
							"column-1": 6,
							"column-2": 7,
							"column-3": 53,
							"column-4": 10
						},
						{
							"category": "category 3",
							"column-1": 2,
							"column-2": 3,
							"column-3": 85,
							"column-4": 87
						},
						{
							"category": "category 4",
							"column-1": 1,
							"column-2": 3,
							"column-3": 96,
							"column-4": 20
						},
						{
							"category": "category 5",
							"column-1": 2,
							"column-2": 1,
							"column-3": 86,
							"column-4": 24
						},
						{
							"category": "category 6",
							"column-1": 3,
							"column-2": 2,
							"column-3": 33,
							"column-4": 69
						}
						
					] */
				}
			);
		
		
		
		
		
		
			 
			AmCharts.makeChart("chartdiv2",
				{
					"type": "serial",
					"categoryField": "category",
					"startDuration": 1,
					"categoryAxis": {
						"gridPosition": "start"
					},
					"trendLines": [],
					"graphs": [
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 0.7,
							"id": "AmGraph-1",
							"lineAlpha": 0.5,
							"title": "LOW",
							"valueField": "column-1",
							"colorField" : "color"
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 0.7,
							"id": "AmGraph-2",
							"lineAlpha": 0.5,
							"title": "MEDIUM",
							"valueField": "column-2",
							"colorField" : "color"
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 0.7,
							"id": "AmGraph-3",
							"title": "HIGH",
							"lineAlpha": 0.5,
							"valueField": "column-3",
							"colorField" : "color"
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 0.7,
							"id": "AmGraph-4",
							"title": "CRITICAL",
							"lineAlpha": 0.5,
							"valueField": "column-4",
							"colorField" : "color"
						}
					],
					"guides": [],
					"valueAxes": [
						{
							"id": "ValueAxis-1",
							"stackType": "regular",
							"title": "No. of Vulnerabilities"
						}
					],
					"allLabels": [],
					"balloon": {},
					"legend": {
						"enabled": true
					},
					"titles": [
						{
							"id": "Title-1",
							"size": 15,
							"text": "Risk After Analysis"
						}
					],
					"dataProvider":chartData1
						  /* [
						{
							"category": "Nov 2015",
							"column-1": 8,
							"column-2": 5,
							"column-3": 81,
							"column-4": 53,
							"color":"#67hj"
						},
						{
							"category": "Dec 2015",
							"column-1": 6,
							"column-2": 7,
							"column-3": 53,
							"column-4": 10,
							"color":"RED"
						},
						{
							"category": "Jan 2016",
							"column-1": 2,
							"column-2": 3,
							"column-3": 85,
							"column-4": 87,
							"color":"GREEN"
						},
						{
							"category": "Feb 2016",
							"column-1": 1,
							"column-2": 3,
							"column-3": 96,
							"column-4": 20,
							"color":"DARKRED"
						},
						{
							"category": "Mar 2016",
							"column-1": 2,
							"column-2": 1,
							"column-3": 86,
							"column-4": 24,
							"color":"DARKRED"
						},
						{
							"category": "Apr 2016",
							"column-1": 3,
							"column-2": 2,
							"column-3": 33,
							"column-4": 69,
							"color":"DARKRED"
						}
						
					]  */
				}
			);
		</script>


		
		
		<!-- </script> -->
		
		
		
		
		
		
		
        

</head>

    <body class="skin-black">
        <!-- header logo: style can be found in header.less -->
        <%String uname=(String)session.getAttribute("name"); %>
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
                            <p>Hello, <%=uname%></p>

                            <!-- <a href="#"><i class="fa fa-circle text-success"></i> Online</a> -->
                        </div>
                    </div>
                    <!-- search form -->
                    <form action="#" method="get" class="sidebar-form">
                         <div class="input-group"> 
                            <!-- <input type="text" name="q" class="form-control" placeholder="Search..."/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button> -->
                            </span> 
                        </div>
                    </form>
                    <ul class="sidebar-menu">
                        <li>
                            <a href="simple.jsp">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                    
                      <!--   <li>
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

                <!-- Main content -->
                <section class="content">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="panel">
                                <header class="panel-heading">
                                  Executive Vulnerability Metrics For Last SIX Months

                                </header>
                                <div class="panel-body">
                                
                                
                                
                                
       
                        
                        <div id="chartdiv" style="width: 100%; height: 400px; background-color: #FFFFFF;" ></div>
                        
                        </div><!-- /.panel-body -->

                            </div><!-- /.panel -->
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                                       <div class="panel" style="width:1100px">
                                <header class="panel-heading">
                                  Product Wise Vulnerability Metrics

                                </header>
                                <div class="panel-body">
                                
                                
   
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                	<%
                                	ResultSet rs4=DatabaseManager.getInstance().showAllVulnerability();
                                	
                                	
                                	int count1=1;
                                	
                                	Map<String,Map<String,Integer>> map72=new HashMap<String,Map<String,Integer>>();
                                	Map<String,Integer> map32=new HashMap<String,Integer>();
									int count2=1;
                                  while(rs4.next())
									{
										 int VID=rs4.getInt(1);
	      								String VNAME=rs4.getString(2);
	     								String HNAME=rs4.getString(3);
	     								String VPORT=rs4.getString(4);
	     								String VFOUNDBY=rs4.getString(5);
	      								String VSEVERITY=rs4.getString(6);
                                  
	      								if(map72.containsKey(HNAME)){
	      									Map<String,Integer> map52=map72.get(HNAME);
	      									if(map72.get(HNAME).containsKey(VSEVERITY)){
	      									int k3=(Integer)map72.get(HNAME).get(VSEVERITY);
	      									//Set<String> newlist=new HashSet<String>();
	      									//newlist.add(VSEVERITY);
	      									k3++;
	      									map52.put(VSEVERITY,k3);
	      									map72.put(HNAME,map52);
	      								}
	      							else{
	      								map52 = map72.get(HNAME);
	      								map52.put(VSEVERITY, count2);
	      								map72.put(HNAME, map52);
	      								}
	      			
	      				}
	      				else{
	      					Map<String,Integer> mapp=new HashMap<String,Integer>();
	      					mapp.put(VSEVERITY,count1);
	      					map72.put(HNAME, mapp);
	      					}
									}
                             %>
	
	
	<form action="piechart1.jsp" method="post"> 
	<div STYLE=" height: 350px; width: 1050px; font-size: 14px; overflow: auto;">
	   <table class="table table-striped table-advance table-hover" width="300px" height="100" data-sortable>
       <tbody>
       <thead>
          <tr>
             
             <th><i class="icon_calendar"></i>Product Name</th>
             <th><i class="icon_mail_alt"></i>Critical</th>
             <th><i class="icon_pin_alt"></i>High</th>
             <th><i class="icon_mobile"></i> Medium</th>
             <th><i class="icon_cogs"></i> Low</th>
             <!-- <th><i class="icon_cogs"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report&nbsp;Status</th> -->
             </tr>
             </thead>
             
          
          <input type="hidden" name="RowCount2" value="Hello">
	<% for (Map.Entry<String,Map<String,Integer>> entry:map72.entrySet()) {
		int low1=0,medium1=0,high1=0,critical1=0,rowno=1;
		String HostName="";
		
		%>
		
		<tr>
		<%-- <%=entry.getKey()%> --%>
		<%HostName=entry.getKey(); %>
		<td>
		
		<%=HostName.split("\\.")[1]%>
		</td>
  	  	<% map32=entry.getValue();
		//out.println("hostname"+entry.getKey().substring(16,22));
	
		for(Map.Entry<String,Integer> entry2:map32.entrySet())
		{

			if(entry2.getKey().equalsIgnoreCase("LOW"))
			{
				low1=entry2.getValue();
			}
			if(entry2.getKey().equalsIgnoreCase("MEDIUM"))
			{
				medium1=entry2.getValue();
			}
			if(entry2.getKey().equalsIgnoreCase("HIGH"))
			{
				high1=entry2.getValue();
			}
			if(entry2.getKey().equalsIgnoreCase("CRITICAL"))
			{
				critical1=entry2.getValue();
			}
			
			
			
			
		
			%>
				
			
		
			
			<%-- out.println("\t"+entry2.getKey() + "= " + entry2.getValue()); --%>
		<% }%>
		<td bgcolor="PURPLE"><%=critical1%></td>
			<td bgcolor="RED"><%=high1%></td>
				<td bgcolor="ORANGE"><%=medium1%></td>
		<td bgcolor="GREEN"><%=low1%></td>
		<%
		
		
		session.setAttribute("low1",low1);
		session.setAttribute("medium1",medium1);
		session.setAttribute("high1",high1);
		session.setAttribute("critical1",critical1);
		
		%>
		<%session.setAttribute("HostName",HostName); %>
<!-- 		<td> -->
		<input type="hidden" name="LowCount" value=<%=low1%>>
		<input type="hidden" name="MediumCount" value=<%=medium1%>>
		<input type="hidden" name="HighCount" value=<%=high1%>>
		<input type="hidden" name="CriticalCount" value=<%=critical1%>>
		<input type="hidden" name="RowCount" value=<%=rowno=rowno+1%>>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%-- <button name="hostname1" id="button1" value=<%=HostName%>>ViewReport</button> --%>
		
		
		<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="Downloadlink.jsp">Download</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	 -->
		<%-- <input type="submit"  name="hostname1" value=<%=HostName%>> --%>
		 <%-- <button name="hostname1" id="button1" value=<%=HostName%>>ViewReport</button> --%>
		 <%-- <button name="hostname2" id="button2" value=<%=HostName%>>Download</button> --%>
		<!-- </td> -->
			</tr>
		
		<% 
		/* out.println(); */
		
		
	}
	
	
	
	%>
	               
                           </tbody>
                        </table>
                        </div>
                        </form>
                        </div><!-- /.panel-body -->

                            </div><!-- /.panel -->
                        
                  
                        </div><!-- /.col -->
                        <div class="col-md-6">
                            <div class="panel">
                                <header class="panel-heading">
                                    Executive Vulnerability Metrics For Last SIX Months

                                </header>
                                <div class="panel-body">
                            		
                                 
                                 
                                 <div id="chartdiv2" style="width: 100%; height: 400px; background-color: #FFFFFF;" ></div>
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                               
                                </div><!-- /.panel-body -->
                            </div><!-- /.panel -->
                            
                            
                            
                            
                        
                    </div>
                </section><!-- /.content -->
               <!--  <div class="footer-main">
                    Copyright &copy Director, 2014
                </div> -->
            </aside><!-- /.right-side -->
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