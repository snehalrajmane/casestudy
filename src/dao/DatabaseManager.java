package dao;
//package com.voltage.report.manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import dao.Database;

public class DatabaseManager {

	public static DatabaseManager _instance = null;
	private Connection conn;
	private String maxVulnerabilityMapID;
	public  static String months[]=new String[6];
     public static int LowTotal[]=new int[6];
	  public static int MediumTotal[]=new int[6];
	  public static int HighTotal[]=new int[6];
	  public static int CriticalTotal[]=new int[6];
	  public static int HPELowTotal[]=new int[6];
	  public static int HPEMediumTotal[]=new int[6];
	  public static int HPEHighTotal[]=new int[6];
	  public static int HPECriticalTotal[]=new int[6];
	  
	  
	  
	  public  static String Vulmonths[]=new String[6];
	     public static int VulLowTotal[]=new int[6];
		  public static int VulMediumTotal[]=new int[6];
		  public static int VulHighTotal[]=new int[6];
		  public static int VulCriticalTotal[]=new int[6];
		    public static  String []s1;
		  public static int []llcount1;
		  public static int []mmcount1;
		  public static int []hhcount1;
		  public static int []cccount1;
	private DatabaseManager() throws InstantiationException,
			IllegalAccessException, ClassNotFoundException, SQLException {
		this.conn = Database.getInstance().getConn();
	}

	public static DatabaseManager getInstance() throws InstantiationException,
			IllegalAccessException, ClassNotFoundException, SQLException {
		if (_instance == null)
			_instance = new DatabaseManager();
		return _instance;
	}

/*	public void insertVulnerabilityDetails(String hostName,
			ArrayList<Vulnerability> hostVulnerabilities) throws SQLException // throws
															// SQLException,
															// ParseException
	{
		for (Vulnerability vulnerability : hostVulnerabilities) {
			// System.out.println(vulnerability.getPort()+" - "+vulnerability.getNid()+" - "+vulnerability.getQid());
			// System.out.println("Vul Name ="+vulnerability.getName()+" and Date ="+vulnerability.getDate());
			// System.out.println(vulnerability.getCveid());
			try {
				CallableStatement cs = this.conn
						.prepareCall("call insert_vulnerability_details(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, vulnerability.getName());
				cs.setString(2, vulnerability.getDesc());
				cs.setString(3, vulnerability.getSolution());
				cs.setString(4, vulnerability.getResult());
				cs.setString(5, vulnerability.getPort());
				cs.setString(6, vulnerability.getSeverity().toString());
				cs.setString(7, vulnerability.getType());
				cs.setString(8, vulnerability.getFoundby());
				cs.setString(9, vulnerability.getConfluence());
				cs.setString(10, vulnerability.getConflink());
				cs.setString(11, vulnerability.getNcvss());
				cs.setString(12, vulnerability.getQid());
				cs.setString(13, vulnerability.getNid());
				cs.setString(14, vulnerability.getCveid());
				cs.setDate(15, getSQLDate(vulnerability.getDate()));
				cs.setInt(16, getHostID(hostName));
				cs.executeQuery();
			} catch (Exception e) {
				System.out.println("call insert_vulnerability_details('"+vulnerability.getName() + "','"
						+ vulnerability.getDesc() + "','"
						+ vulnerability.getSolution() + "','"
						+ vulnerability.getResult()+ "','"
						+ vulnerability.getPort()+ "','"
						+ vulnerability.getSeverity().toString()+ "','"
						+ vulnerability.getType()+ "','"
						+ vulnerability.getFoundby()+ "','"
						+ vulnerability.getConfluence()+"','"
						+ vulnerability.getConflink()+"','"
						+ vulnerability.getNcvss()+"','"
						+ vulnerability.getQid()+ "','"
						+ vulnerability.getNid()+ "','"
						+ vulnerability.getCveid()+ "','"
						+ vulnerability.getDate()+ "','"
						+ getHostID(hostName)+")");
				e.printStackTrace();
			}
		}
	}
*/
	public int getHostID(String hostname) throws SQLException {
		CallableStatement cs = this.conn.prepareCall("call getHostID(?,?)");
		cs.setString(1, hostname);
		cs.registerOutParameter(2, Types.INTEGER);
		cs.executeQuery();
		return cs.getInt(2);
	}

	private Date getSQLDate(String date) throws ParseException {
		SimpleDateFormat sdf1 = new SimpleDateFormat("dd-M-yyyy");
		return new Date(sdf1.parse(date).getTime());
	}

	public int getMaxVulMapID() throws SQLException {
		CallableStatement cs = this.conn
				.prepareCall("call getMaxVulnerabilityMapID(?)");
		cs.registerOutParameter(1, Types.INTEGER);
		cs.executeQuery();
		setMaxVulnerabilityMapID("" + cs.getInt(1));
		System.out.println("Max Vul-Map ID - " + cs.getInt(1));
		return cs.getInt(1);
	}
	
	
	public ResultSet showVulnerability(int a,int b) throws SQLException{
		int count=0;
		System.out.println("a="+a+"b="+b);
		CallableStatement cs = this.conn.prepareCall("call new_vulnerability(?,?)");
		cs.setInt(1, a);
		cs.setInt(2, b);
		cs.executeQuery();
		
		ResultSet rs=cs.getResultSet();
		/*while(rs.next())
		{
			count++;
			
			//System.out.println("Result From DB="+rs.getString(2));
		}
		System.out.println("Count in Database Manager="+count);*/
		return rs;
	}

	public String getMaxVulnerabilityMapID() {
		return maxVulnerabilityMapID;
	}

	public void setMaxVulnerabilityMapID(String maxVulnerabilityMapID) {
		this.maxVulnerabilityMapID = maxVulnerabilityMapID;
	}

	public void insertCVSS_Score(Map<String, String> cvssMAP)
			throws SQLException {
		System.out
				.println("-----------------------------------IN DATABASE MANAGER-----------------------------------");
		for (Map.Entry<String, String> entry : cvssMAP.entrySet()) {
			// System.out.println("Key : " + entry.getKey() + " Value : " +
			// entry.getValue());
			CallableStatement cs = this.conn
					.prepareCall("call insert_cvss_score(?,?)");
			cs.setString(1, entry.getKey());
			cs.setString(2, entry.getValue());
			cs.executeQuery();
		}
		System.out.println("Finished updating database entries.");
		System.out
				.println("--------------------------------------------------------------------------------------------");
	}

	public void insertCVSSByStep(String cveid, String cvss) throws SQLException {
		CallableStatement cs = this.conn
				.prepareCall("call insert_cvss_score(?,?)");
		cs.setString(1, cveid);
		cs.setString(2, cvss);
		cs.executeQuery();
	}
	
	
	


public String getCVSS_Score(String cveid) throws SQLException {
		CallableStatement cs = this.conn
				.prepareCall("call get_cvss_score(?,?)");
		cs.setString(1, cveid);
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.executeQuery();
		return cs.getString(2);
	}

	public String getWebAppSeverity(String QID) throws SQLException {
		CallableStatement cs = this.conn
				.prepareCall("call getWebAppSeverity(?,?)");
		cs.setString(1, QID);
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.executeQuery();
		return cs.getString(2);
	}

public void showRecentVulnerability() throws SQLException, ParseException {
		// TODO Auto-generated method stub
		
		String[] monthName = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "July",
		        "Aug", "Sept", "Oct", "Nov", "Dec" };
		Calendar now = Calendar.getInstance();
		Calendar now1 = Calendar.getInstance();
		Calendar now2 = Calendar.getInstance();
		java.sql.Date d1 = new java.sql.Date(now.getTimeInMillis());
		now.add(Calendar.MONTH,-6);
		java.sql.Date d2 = new java.sql.Date(now.getTimeInMillis());
		months[0]=monthName[now1.get(Calendar.MONTH)]+" "+now1.get(Calendar.YEAR);
		System.out.println(months[0]);
		//now1.add(Calendar.MONTH,-1);
		for(int i=1;i<=5;i++)
		{
			now1.add(Calendar.MONTH,-1);
			String month5= monthName[now1.get(Calendar.MONTH)]+" "+now1.get(Calendar.YEAR);
			months[i]=month5;
			System.out.println("Name="+months[i]);
			}
		
		for(int i=0;i<=5;i++)
		{
			java.sql.Date date4 = new java.sql.Date(now2.getTimeInMillis());
			System.out.println("date4="+date4);
			now2.add(Calendar.MONTH,-1);
			java.sql.Date date5 = new java.sql.Date(now2.getTimeInMillis());
			System.out.println("date5="+date5);
			PreparedStatement pstmt1 =this.conn.prepareStatement("select vs_vulmap.VID ,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,DATE,SEVERITY2 from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID where DATE between ? AND ?");
			pstmt1.setDate(1,date5); 
			pstmt1.setDate(2,date4); 
			ResultSet rs = pstmt1.executeQuery();
			int count=0,TotalLow=0,TotalMedium=0,TotalHigh=0,TotalCritical=0,TotalLow1=0,TotalMedium1=0,TotalHigh1=0,TotalCritical1=0;
			while(rs.next())
			{
				count++;
				if(rs.getString(6).equalsIgnoreCase("LOW"))
				{
					TotalLow++;
				}
				if(rs.getString(8).equalsIgnoreCase("LOW"))
				{
					TotalLow1++;
				}
				if(rs.getString(6).equalsIgnoreCase("MEDIUM"))
				{
					TotalMedium++;
				}
				if(rs.getString(8).equalsIgnoreCase("MEDIUM"))
				{
					TotalMedium1++;
				}
				if(rs.getString(6).equalsIgnoreCase("HIGH"))
				{
					TotalHigh++;
				}
				if(rs.getString(8).equalsIgnoreCase("HIGH"))
				{
					TotalHigh1++;
				}
				if(rs.getString(6).equalsIgnoreCase("CRITICAL"))
				{
					TotalCritical++;
				}
				if(rs.getString(8).equalsIgnoreCase("CRITICAL"))
				{
					TotalCritical1++;
				}
				//System.out.println("host="+rs.getInt(4));
			//	System.out.println("Vulnerability Id="+rs.getInt(1)+"\thname"+rs.getString(3)+"\tseverity  "+rs.getString(6)+"\tDate"+rs.getDate(7));
				
			}
			LowTotal[i]=TotalLow;
			MediumTotal[i]=TotalMedium;
			HighTotal[i]=TotalHigh;
			CriticalTotal[i]=TotalCritical;
			HPELowTotal[i]=TotalLow1;
			HPEMediumTotal[i]=TotalMedium1;
			HPEHighTotal[i]=TotalHigh1;
			HPECriticalTotal[i]=TotalCritical1;
			
			//System.out.println("count="+count+"Low="+TotalLow+"Medium="+TotalMedium+"High="+TotalHigh+"Critical="+TotalCritical);
			java.util.Date date=now1.getTime();
		
		}
		for(int i=0;i<=5;i++)
		{
			System.out.println("HPElow="+HPELowTotal[i]);
			System.out.println("HPEMedium="+HPEMediumTotal[i]);
			System.out.println("HPEHigh="+HPEHighTotal[i]);
			System.out.println("HPECritical="+HPECriticalTotal[i]);
		}
	
		}


public void showVulnerabilityStack() throws SQLException, ParseException {
	// TODO Auto-generated method stub
	
	String[] monthName = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "July",
	        "Aug", "Sept", "Oct", "Nov", "Dec" };
	Calendar now = Calendar.getInstance();
	Calendar now1 = Calendar.getInstance();
	Calendar now2 = Calendar.getInstance();
	java.sql.Date d1 = new java.sql.Date(now.getTimeInMillis());
	now.add(Calendar.MONTH,-6);
	java.sql.Date d2 = new java.sql.Date(now.getTimeInMillis());
	Vulmonths[0]=monthName[now1.get(Calendar.MONTH)]+" "+now1.get(Calendar.YEAR);
	System.out.println("vil"+Vulmonths[0]);
	//now1.add(Calendar.MONTH,-1);
	for(int i=1;i<=5;i++)
	{
		now1.add(Calendar.MONTH,-1);
		String month5= monthName[now1.get(Calendar.MONTH)]+" "+now1.get(Calendar.YEAR);
		Vulmonths[i]=month5;
		System.out.println("Name="+Vulmonths[i]);
		}
	
	for(int i=0;i<=5;i++)
	{
		java.sql.Date date4 = new java.sql.Date(now2.getTimeInMillis());
		System.out.println("date4="+date4);
		now2.add(Calendar.MONTH,-1);
		java.sql.Date date5 = new java.sql.Date(now2.getTimeInMillis());
		System.out.println("date5="+date5);
		PreparedStatement pstmt1 =this.conn.prepareStatement("select vs_vulmap.VID ,SEVERITY2,HNAME,VPORT,VFOUNDBY,VSEVERITY,DATE,SEVERITY2 from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID where DATE between ? AND ?");
		pstmt1.setDate(1,date5); 
		pstmt1.setDate(2,date4); 
		ResultSet rs = pstmt1.executeQuery();
		int count=0,TotalLow=0,TotalMedium=0,TotalHigh=0,TotalCritical=0;
		/*System.out.println();*/
		while(rs.next())
		{
			count++;
			if(rs.getString(2).equalsIgnoreCase("LOW"))
			{
				TotalLow++;
			}
			if(rs.getString(2).equalsIgnoreCase("MEDIUM"))
			{
				TotalMedium++;
			}
			if(rs.getString(2).equalsIgnoreCase("HIGH"))
			{
				TotalHigh++;
			}
			if(rs.getString(2).equalsIgnoreCase("CRITICAL"))
			{
				TotalCritical++;
			}
			//System.out.println("host="+rs.getInt(4));
		//	System.out.println("Vulnerability Id="+rs.getInt(1)+"\thname"+rs.getString(3)+"\tseverity  "+rs.getString(6)+"\tDate"+rs.getDate(7));
			
		}
		VulLowTotal[i]=TotalLow;
		VulMediumTotal[i]=TotalMedium;
		VulHighTotal[i]=TotalHigh;
		VulCriticalTotal[i]=TotalCritical;
		//System.out.println("count="+count+"Low="+TotalLow+"Medium="+TotalMedium+"High="+TotalHigh+"Critical="+TotalCritical);
		java.util.Date date=now1.getTime();
	
	}
	for(int i=0;i<=5;i++)
	{
		System.out.println("low="+VulLowTotal[i]);
		System.out.println("Medium="+VulMediumTotal[i]);
		System.out.println("High="+VulHighTotal[i]);
		System.out.println("Critical="+VulCriticalTotal[i]);
	}

	}
public ResultSet showLastMonthVulnerability() throws SQLException, ParseException {
	// TODO Auto-generated method stub
	
	String[] monthName = { "January", "February", "March", "April", "May", "June", "July",
	        "August", "September", "October", "November", "December" };
	//Calendar now = Calendar.getInstance();
	//Calendar now1 = Calendar.getInstance();
	Calendar now2 = Calendar.getInstance();
	//java.sql.Date d1 = new java.sql.Date(now.getTimeInMillis());
	//now1.add(Calendar.MONTH,-1);
	//java.sql.Date d2 = new java.sql.Date(now1.getTimeInMillis());
	/*months[0]=monthName[now1.get(Calendar.MONTH)]+" "+now1.get(Calendar.YEAR);
	System.out.println(months[0]);
	now1.add(Calendar.MONTH,-1);*/
	
	
	
		java.sql.Date date4 = new java.sql.Date(now2.getTimeInMillis());
		System.out.println("date4="+date4);
		now2.add(Calendar.MONTH,-1);
		java.sql.Date date5 = new java.sql.Date(now2.getTimeInMillis());
		System.out.println("date5="+date5);
		PreparedStatement pstmt1 =this.conn.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,CVEID,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID  inner join vs_cve on  vs_vulmap.CID=vs_cve.CID  where DATE between '2016-01-01' AND '2016-05-05'");
		//pstmt1.setDate(1,date5); 
		//pstmt1.setDate(2,date4); 
		ResultSet rs = pstmt1.executeQuery();
		
		return rs;
	}

public ResultSet showVulnerabilityFilter(String optionSelected,
		String searchValue) {
	// TODO Auto-generated method stub
	String optionSelected1=optionSelected;
	String searchValue1=searchValue;
	PreparedStatement pstmt1;
	ResultSet rs=null;
	if(optionSelected.equalsIgnoreCase("severity"))
		searchValue1=searchValue.toUpperCase();
	
	try {
		pstmt1 = this.conn.prepareStatement("select vs_vulmap.VID ,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,CID from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID where '"+optionSelected1+"'='"+searchValue1+"'");
	
	//pstmt1.setDate(1,date5); 
	//pstmt1.setDate(2,date4); 
	rs = pstmt1.executeQuery();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	return rs;
	
}
public ResultSet showAllVulnerability(){
	PreparedStatement pstmt1;
	ResultSet rs=null;
	
	try {
		pstmt1 = this.conn.prepareStatement("select vs_vulmap.VID ,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,CID from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID");
	
	//pstmt1.setDate(1,date5); 
	//pstmt1.setDate(2,date4); 
	rs = pstmt1.executeQuery();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	return rs;
	
}

/*public void updateComments(String[] comment, String[] severity2, String[] VID, String[] MID) {
	// TODO Auto-generated method stub
	PreparedStatement pstmt1;
	
	Statement stmt=null;
	ResultSet rs=null;
	int a=0;
	int VID1[]=new int[VID.length];
	int MID1[]=new int[MID.length];
	System.out.println("lenth="+VID.length);
	for(int l=0;l<VID.length;l++)
	{
		VID1[l]=Integer.parseInt(VID[l]);
		MID1[l]=Integer.parseInt(MID[l]);
		System.out.println("vid"+l+"ans="+VID1[l]+"MID="+MID1[l]);
		
	}
	
	try {
		for(int k=0;k<comment.length;k++){
			stmt=this.conn.createStatement();
			stmt.executeUpdate("update vs_vulmap  set COMMENTS='"+comment[k]+"',SEVERITY2='"+severity2[k]+"' where VID='"+VID1[k]+"' and MID='"+MID1[k]+"'");
			System.out.println("Final VID"+VID1[k]+"MID="+MID1[k]+"k"+k);
		pstmt1 = this.conn.prepareStatement("select vs_vulmap.VID ,VNAME,TAGNAME,VPORT,VFOUNDBY,VSEVERITY,CID from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID");
		pstmt1 = this.conn.prepareStatement("update vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID='"+VID1[i]+"'  set vs_vulmap.COMMENTS='"+comment[i]+"' where vs_vulnerability.VNAME='"+vulname[i]+"'");
		pstmt1 = this.conn.prepareStatement("update vs_vulmap set COMMENTS='"+comment[i]+"' where VID='"+VID1[i]+"' and MID='"+MID1[i]+"'");
	
	//pstmt1.setDate(1,date5); 
	//pstmt1.setDate(2,date4); 
	  stmt.executeUpdate();
	  //System.out.println("No Of rows affected"+a);
		}
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	return null;
	
	
}*/

/*public ResultSet ShowHostDetails(String hostName1) {
	// TODO Auto-generated method stub
	Connection currentCon;
	ResultSet rs=null;
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,CVEID,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,VDESC  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where HNAME='"+hostName1+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
}
*/




/*public ResultSet ShowExcelHostDetails(String hostName1) {
	// TODO Auto-generated method stub
	Connection currentCon;
	ResultSet rs=null;
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select VNAME,VDESC,VSOLUTION,VRESULT,VPORT,VSEVERITY,CVEID,VTYPE,VFOUNDBY,VCONFLUENCE,VCONFLINK,VQID,VNID,DATE from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where HNAME='"+hostName1+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
}
*/





public ResultSet showAllSearch(String productname, String severity) {
	// TODO Auto-generated method stub
	Connection currentCon;
	ResultSet rs=null;
	String severity2=severity.toUpperCase();
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where TAGNAME='"+productname+"' and VSEVERITY='"+severity2+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
	
}

public ResultSet showAllSearch(String productname) {
	// TODO Auto-generated method stub
	Connection currentCon;
	ResultSet rs=null;
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID  where TAGNAME='"+productname+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
}


public ResultSet showAllSearchSeverity(String severityname) {
	// TODO Auto-generated method stub
	Connection currentCon;
	ResultSet rs=null;
	String severity2=severityname.toUpperCase();
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where VSEVERITY='"+severity2+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
}

public ResultSet showAllSearch(String productname, String severity, String date) {
	// TODO Auto-generated method stub
	
	
	Connection currentCon;
	ResultSet rs=null;
	String severity2=severity.toUpperCase();
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where TAGNAME='"+productname+"' and VSEVERITY='"+severity2+"' and DATE='"+date+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
	
}
	


public ResultSet showAllSearch(String productname, String severity, String date,String date1) {
	// TODO Auto-generated method stub
	
	
	Connection currentCon;
	ResultSet rs=null;
	String severity2=severity.toUpperCase();
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where TAGNAME='"+productname+"' and VSEVERITY='"+severity2+"' and DATE between '"+date+"' and '"+date1+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
	
}


public ResultSet showAllSearchDate(String date, String date1) {
	// TODO Auto-generated method stub
	
	
	Connection currentCon;
	ResultSet rs=null;
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where DATE between '"+date+"' and '"+date1+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
	
}



public ResultSet showAllSearchSingleDate(String date) {
	// TODO Auto-generated method stub
	
	
	Connection currentCon;
	ResultSet rs=null;
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where DATE='"+date+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
	
}


public ResultSet showAllSearchProductDate(String productname,String date,String date1) {
	// TODO Auto-generated method stub
	
	
	Connection currentCon;
	ResultSet rs=null;
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where TAGNAME='"+productname+"' and DATE between '"+date+"' and '"+date1+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
	
}

public ResultSet showAllSearchSeverityDate(String severity,String date,String date1) {
	// TODO Auto-generated method stub
	
	
	Connection currentCon;
	ResultSet rs=null;
	String severity2=severity.toUpperCase();
	try {
		currentCon = Database.getInstance().getConn();
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,vs_vulmap.MID,vs_vulmap.COMMENTS,vs_vulmap.SEVERITY2,CVEID  from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID where VSEVERITY='"+severity2+"'and DATE between '"+date+"' and '"+date1+"'");
	rs = pstmt1.executeQuery();
	while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
	
}






public ResultSet showCVEIDSearch(String cveid) {
	// TODO Auto-generated method stub
	
	
	Connection currentCon;
	ResultSet rs=null;
	try {
		currentCon = Database.getInstance().getConn();
		String cve="%"+cveid+"%";
	
	PreparedStatement	pstmt1 = currentCon.prepareStatement("select vs_vulmap.VID ,VNAME,HNAME,CVEID,VFOUNDBY,VSEVERITY,SEVERITY2,COMMENTS from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID inner join vs_cve on  vs_vulmap.CID=vs_cve.CID  where CVEID like '"+cve+"'");
	rs = pstmt1.executeQuery();
	/*while(rs.next())
	{
		System.out.println("VNAME="+rs.getString(2)+"HName="+rs.getString(3));
	}*/
	} catch (InstantiationException | IllegalAccessException
			| ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return rs;
}








public ResultSet showFinalHostSeverityCount(){
	PreparedStatement pstmt1;
	ResultSet rs=null;
	Map<String,Integer> map1=new HashMap<String,Integer>();
	Map<String,Map<String,Integer>> map7=new HashMap<String,Map<String,Integer>>();
	Map<String,Integer> map3=new HashMap<String,Integer>();	
	int count1=1;
	
	
	
	
	
	
	try {
		pstmt1 = this.conn.prepareStatement("select vs_vulmap.VID ,VNAME,HNAME,VPORT,VFOUNDBY,VSEVERITY,CID from vs_vulmap inner join vs_vulnerability on vs_vulnerability.VID=vs_vulmap.VID inner join vs_host on vs_vulmap.HID=vs_host.HID");
		//pstmt1.setDate(1,date5); 
	//pstmt1.setDate(2,date4);

		rs = pstmt1.executeQuery();
		while(rs.next()){
			
			 int VID=rs.getInt(1);
				String VNAME=rs.getString(2);
				String HNAME=rs.getString(3);
				String VPORT=rs.getString(4);
				String VFOUNDBY=rs.getString(5);
				String VSEVERITY=rs.getString(6);
				/*String MID=rs.getString(8);*/
				/*String comment=rs.getString(9);
				String severity=rs.getString(10);*/
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
	
		}
		System.out.println("sizz="+map7.keySet().size());
		
		
		 s1=new String[map7.keySet().size()];
	 	  llcount1=new int[map7.keySet().size()];
	 	  mmcount1=new int[map7.keySet().size()];
	 	  hhcount1=new int[map7.keySet().size()];
	 	  cccount1=new int[map7.keySet().size()];
		
	 	 int i=0;
		for (Map.Entry<String,Map<String,Integer>> entry:map7.entrySet()) {
	  	  	map3=entry.getValue();
			
			s1[i]=entry.getKey().split("\\.")[1];
			System.out.println("Host Name:"+entry.getKey()+"short"+s1[i]);
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
				System.out.println("\t"+entry2.getKey() + "= " + entry2.getValue());
				
			}
			i=i+1;
	}
		System.out.println("low length="+llcount1.length);
		
		for(int j=0;j<llcount1.length;j++)
		{
			System.out.println("Low Values are"+llcount1[j]);
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	return rs;
	
}















}
