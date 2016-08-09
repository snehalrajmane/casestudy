<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%--    <%@ page import="dao.Merger" %>  --%>
         
            <%@ page import="java.util.HashMap" %>
    <%@ page import="dao.DatabaseManager" %> 
    <%@ page import="java.sql.ResultSet" %>
    <%@ page import="java.sql.PreparedStatement" %>

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



   <link rel="stylesheet" href="style.css" type="text/css">
   
    <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="css/login.css" rel="stylesheet" type="text/css" />
        <link href="css/style2.css" rel="stylesheet" type="text/css" />
        <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
        <script src="amcharts/amcharts.js" type="text/javascript"></script>
        <script src="amcharts/serial.js" type="text/javascript"></script>
        <script src="amcharts/pie.js" type="text/javascript"></script>
        
        
        
        
        <script>
        
        var chartData = new Array();
        
        
        
        
        <%DatabaseManager.getInstance().showFinalHostSeverityCount();%>; 
		 <%DatabaseManager d1=DatabaseManager.getInstance();%>
		 <%String[] months=DatabaseManager.months;%>;
        
        <%String[] hosts=DatabaseManager.s1; %>; 
        <%int[] low= DatabaseManager.llcount1;%>; 
        <%int[] medium= DatabaseManager.mmcount1;%>; 
        <%int[] high= DatabaseManager.hhcount1;%>; 
        <%int[] critical=DatabaseManager.cccount1;%>; 
         var jsArr = new Array();  
         var low1 = new Array();  
         var medium1 = new Array();  
         var high1 = new Array();  
         var critical1 = new Array();  
        <%  
        for (int i=0; i < hosts.length; i++) {  
        %>  
          jsArr[<%= i %>] = '<%=hosts[i] %>'; //Here is the latest update check it sravan .Put single quotes.
          low1[<%= i %>] = '<%=low[i] %>'; 
          medium1[<%= i %>] = '<%=medium[i] %>'; 
       	 high1[<%= i %>] = '<%=high[i] %>'; 
         critical1[<%= i %>] = '<%=critical[i] %>'; 
         chartData[<%= i %>] =new Array();
       	 chartData[<%= i %>]["category"]= jsArr[<%= i %>];
         chartData[<%= i %>]["column-1"]=low1[<%= i %>];
         chartData[<%= i %>]["column-2"]=medium1[<%= i %>];
         chartData[<%= i %>]["column-3"]=high1[<%= i %>];
         chartData[<%= i %>]["column-4"]=critical1[<%= i %>];
         
     <%--    chartData[<%= i %>][0]=  {
       		 
       		 	"name":"year",
        			"value":"HR"
                          };
        chartData[<%= i %>][1]=  {
    		 	"name":"europe",
     			"value":'50'
                       };
        chartData[<%= i %>][2]=  {
    		 	"name":"namerica",
     			"value":'20'
                       };  --%>
         /* alert(chartData[0][1].value);  */
        <%}%>  
       
        
        
        
        
        
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
							"fillAlphas": 1,
							"id": "AmGraph-1",
							"title": "LowCount",
							"type": "column",
							"valueField": "column-1"
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 1,
							"id": "AmGraph-2",
							"title": "MediumCount",
							"type": "column",
							"valueAxis": "ValueAxis-2",
							"valueField": "column-2"
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 1,
							"id": "AmGraph-3",
							"title": "HighCount",
							"type": "column",
							"valueField": "column-3"
						},
						{
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 1,
							"id": "AmGraph-4",
							"title": "CriticalCount",
							"type": "column",
							"valueField": "column-4"
						}
					],
					"guides": [],
					"valueAxes": [
						{
							"id": "ValueAxis-1",
							"title": "Axis title"
						},
						{
							"id": "ValueAxis-2",
							"position": "right",
							"gridAlpha": 0,
							"title": "Axis title"
						}
					],
					"allLabels": [],
					"balloon": {},
					"legend": {
						"enabled": true,
						"useGraphSettings": true
					},
					"titles": [
						{
							"id": "Title-1",
							"size": 15,
							"text": "Chart Title"
						}
					],
					"dataProvider":chartData
						/*  [
						{
							"category": "category 1",
							"column-1": "21",
							"column-2": "80",
							"column-3": 100,
							"column-4": 97
						},
						{
							"category": "category 2",
							"column-1": "11",
							"column-2": "756",
							"column-3": 72,
							"column-4": 27
						},
						{
							"category": "category 3",
							"column-1": "15",
							"column-2": "1008",
							"column-3": 66,
							"column-4": 44
						}
					] */
				}
			);
		
		
		
		
		
        
        
        
        
        
        
        
        
        
        
        
        
        
     <%--    var chartData = new Array();
        
         <%String[] hosts= (String[])session.getAttribute("hostname");%>; 
         <%int[] low= (int[])session.getAttribute("lowcount");%>; 
         <%int[] medium= (int[])session.getAttribute("mediumcount");%>; 
         <%int[] high= (int[])session.getAttribute("highcount");%>; 
         <%int[] critical= (int[])session.getAttribute("criticalcount");%>; 
          var jsArr = new Array();  
          var low1 = new Array();  
          var medium1 = new Array();  
          var high1 = new Array();  
          var critical1 = new Array();  
         <%  
         for (int i=0; i < hosts.length; i++) {  
         %>  
         jsArr[<%= i %>] = '<%=hosts[i] %>'; //Here is the latest update check it sravan .Put single quotes.
         low1[<%= i %>] = '<%=low[i] %>'; 
         alert(low1[<%= i %>]);
         medium1[<%= i %>] = '<%=medium[i] %>'; 
         alert(medium1[<%= i %>]);
         high1[<%= i %>] = '<%=high[i] %>'; 
         alert(high1[<%= i %>]);
         critical1[<%= i %>] = '<%=critical[i] %>'; 
         alert(critical1[<%= i %>]);
         alert(jsArr[<%= i %>]);
         var str=jsArr[<%= i %>];
         var res = str.substr(16,19);
         alert(res);
        /*  var aResult = new Object();
         aResult.year = "Hello"; // or results[i]['title']
         aResult.europe = '50'; // or results[i]['value']
         aResult.namerica = '20'; */
         /* chartDataResults.push({"year": "ga",
             "europe": '50',
             "namerica": '20'}); 
          */
        chartData[<%= i %>] =new Array();
          chartData[<%= i %>]["year"]="abc";
          chartData[<%= i %>]["europe"]=low1[<%= i %>];
          chartData[<%= i %>]["namerica"]=medium1[<%= i %>];
          chartData[<%= i %>]["asia"]=high1[<%= i %>];
          chartData[<%= i %>]["lamerica"]=critical1[<%= i %>];
         chartData[<%= i %>][0]=  {
        		 
        		 	"name":"year",
         			"value":"HR"
                           };
         chartData[<%= i %>][1]=  {
     		 	"name":"europe",
      			"value":'50'
                        };
         chartData[<%= i %>][2]=  {
     		 	"name":"namerica",
      			"value":'20'
                        }; 
          /* alert(chartData[0][1].value);  */
         <%}%>  
        
         /* var chartData = chartDataResults;  */
 
var chart;
var dataChart = chartData; 
/* alert(dataChart[0][1].value);  */
/* var chartData = [
    {
        "year": jsArr[0],
        "europe": '50',
        "namerica": '20'
    } ,
    {
        "year": "HR",
        "europe": '60',
        "namerica": '30'
    },
    {
        "year": "Administration",
        "europe": '80',
        "namerica": '20'
    } 
]; */

AmCharts.ready(function () {
    // SERIAL CHART
    chart = new AmCharts.AmSerialChart();
    chart.dataProvider = dataChart;
    chart.categoryField = "year";
    chart.plotAreaBorderAlpha = 0.2;

    // AXES
    // category
    var categoryAxis = chart.categoryAxis;
    categoryAxis.gridAlpha = 0.1;
    categoryAxis.axisAlpha = 0;
    categoryAxis.gridPosition = "start";

    // value
    var valueAxis = new AmCharts.ValueAxis();
    valueAxis.stackType = "regular";
    valueAxis.gridAlpha = 0.1;
    valueAxis.axisAlpha = 0;
    chart.addValueAxis(valueAxis);

    // GRAPHS
    // first graph    
    var graph = new AmCharts.AmGraph();
    graph.title = "LowCount";
    /* graph.labelText = "35"; */
    graph.valueField = "europe";
    graph.type = "column";
    graph.lineAlpha = 0;
    graph.fillAlphas = 1;
    graph.lineColor = "#9bc322";
    graph.balloonText = "<span style='color:#555555;'>[[category]]</span><br><span style='font-size:14px'>[[title]]:<b>[[value]]</b></span>";
    chart.addGraph(graph);

    // second graph              
    graph = new AmCharts.AmGraph();
    graph.title = "MediumCount";
    /* graph.labelText = "75"; */
    graph.valueField = "namerica";
    graph.type = "column";
    graph.lineAlpha = 0;
    graph.fillAlphas = 1;
    graph.lineColor = "#ff8000";
    graph.balloonText = "<span style='color:#555555;'>[[category]]</span><br><span style='font-size:14px'>[[title]]:<b>[[value]]</b></span>";
    chart.addGraph(graph);                

     // third graph                              
    graph = new AmCharts.AmGraph();
    graph.title = "HighCount";
    /* graph.labelText = "[[value]]"; */
    graph.valueField = "asia";
    graph.type = "column";
    graph.lineAlpha = 0;
    graph.fillAlphas = 1;
    graph.lineColor = "#B3DBD4";
    graph.balloonText = "<span style='color:#555555;'>[[category]]</span><br><span style='font-size:14px'>[[title]]:<b>[[value]]</b></span>";
    chart.addGraph(graph);

    // fourth graph  
    graph = new AmCharts.AmGraph();
    graph.title = "Critical Count";
    /* graph.labelText = "[[value]]"; */
    graph.valueField = "lamerica";
    graph.type = "column";
    graph.lineAlpha = 0;
    graph.fillAlphas = 1;
    graph.lineColor = "#69A55C";
    graph.balloonText = "<span style='color:#555555;'>[[category]]</span><br><span style='font-size:14px'>[[title]]:<b>[[value]]</b></span>";
    chart.addGraph(graph);

    /* // fifth graph
    graph = new AmCharts.AmGraph();
    graph.title = "Middle-East";
    graph.labelText = "[[value]]";
    graph.valueField = "meast";
    graph.type = "column";
    graph.lineAlpha = 0;
    graph.fillAlphas = 1;
    graph.lineColor = "#B5B8D3";
    graph.balloonText = "<span style='color:#555555;'>[[category]]</span><br><span style='font-size:14px'>[[title]]:<b>[[value]]</b></span>";
    chart.addGraph(graph);

    // sixth graph   
    graph = new AmCharts.AmGraph();
    graph.title = "Africa";
    graph.labelText = "[[value]]";
    graph.valueField = "africa";
    graph.type = "column";
    graph.lineAlpha = 0;
    graph.fillAlphas = 1;
    graph.lineColor = "#F4E23B";
    graph.balloonText = "<span style='color:#555555;'>[[category]]</span><br><span class='font-size:14px'>[[title]]:<b>[[value]]</b></span>";
    chart.addGraph(graph); */

    // LEGEND                  
    var legend = new AmCharts.AmLegend();
    legend.borderAlpha = 0.2;
    legend.horizontalGap = 10;
    chart.addLegend(legend);

    // WRITE
    chart.write("chartdiv");
});

// this method sets chart 2D/3D
function setDepth() {
    if (document.getElementById("rb1").checked) {
        chart.depth3D = 0;
        chart.angle = 0;
    } else {
        chart.depth3D = 25;
        chart.angle = 30;
    }
    chart.validateNow();
} --%>
</script>
        
        
        
        
        
        
        
        
        
        
        
           
        
        
        
        
        
        
        
        
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
                            <p>Hello, <%=uname %></p>

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
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                        <li>
                            <a href="simple.jsp">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                        <!-- <li> -->
                        <!-- <a href="#join_form" id="join_pop"> -->
                         <!--     <a href="general.jsp"> 
                                <i class="fa fa-gavel"></i> <span>General</span> -->
                                
                                
                                
                                
                           <!--      <a href="#x" class="overlay" id="join_form"></a>
        	<div class="popup">
			<br><br>
     		<img src="images/Dashboard.jpg" name="webLogo" width="175" height="100" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;
       	 	<img src="images/ProcessReport.jpg" name="webLogo1" width="175" height="100" border="0">&nbsp;&nbsp;&nbsp;&nbsp;
        	<img src="images/CustomerReportAnalysis.jpg" name="webLogo2" width="175" height="100" border="0">&nbsp;&nbsp;&nbsp;&nbsp;
        	<img src="images/Settings.jpg" name="webLogo3" width="175" height="100" border="0"><br><br><br>
			<a class="close" href="#close"></a>
            

        </div> -->
                            
                        <!--     </a>
                        </li> -->

                      <!--   <li class="active">
                            <a href="basic_form.jsp">
                                <i class="fa fa-gavel"></i> <span>Process Reports</span>
                            </a>
                        </li> -->

                       <!--  <li>
                            <a href="simple.jsp">
                                <i class="fa fa-glass"></i> <span>Simple tables</span>
                            </a>
                        </li> -->
                      <!--   <li>
                                    <a href="tables.jsp">
                                        <i class="fa fa-globe"></i> <span>New Vulnerability</span>
                                    </a>
                                </li> -->
                                
                       <!--  <li>
                            <a href="chart.jsp">
                                <i class="fa fa-glass"></i> <span>Charts</span>
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
                                 Charts
                              </header>
                              <div class="panel-body">
                             
          
  						<!-- <form id="my-awesome-dropzone"  action="Upload3" class="dropzone" method="POST"> -->  
	  	  				
	  	  				   <div class="row">
         <!-- <div class="alert alert-info" align="center"role="alert"><h4>Vulnerability</h4></div> -->
  
			 <!-- <div id="chartdiv" style="width: 600px; height: 400px;"></div> -->
			 <div id="chartdiv" style="width: 100%; height: 400px; background-color: #FFFFFF;" ></div><br><br><br>
       		<!--  <div style="margin-left:30px;">
	        <input type="radio" checked="true" name="group" id="rb1" onclick="setDepth()">2D
	        <input type="radio" name="group" id="rb2" onclick="setDepth()">3D
		</div> -->
		</div>

	  	  				
	  	  				
	  	  				
	  	  				
	  	  				
	  	  				<!-- <div id="chartdiv1" style="width: 600px; height: 400px;"></div><br><br> -->
        <!-- <div id="chartdiv2" style="width: 600px; height: 400px;"></div> -->
	  	  				
	  	  				
	  
		<!-- 				</form>
						
						<form action="MergeFileServlet" method="post"> 
	
	<input id="buttonID" type="submit" value="Merge" onclick="load()">
	</form> -->
	
                   </div>
                            </section>
   
                                 <div class="footer-main">
                © 2016 Persistent Systems Ltd..
            </div> 
        </div><!-- ./wrapper -->
        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script src="js/jquery.min.js" type="text/javascript"></script>

        <!-- Bootstrap -->
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Director App -->
        <script src="js/Director/app.js" type="text/javascript"></script>
    </body>
    <%-- <div id="footer">
<%@ include file="footer.jsp" %>
</div> --%>
</html>
