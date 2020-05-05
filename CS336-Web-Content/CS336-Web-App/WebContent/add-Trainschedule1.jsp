<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding New Schedule</title>
</head>
<body>
<%
String transit_line =request.getParameter("transit_line");
session.setAttribute("transit_line", transit_line);
Object transit_line1= session.getAttribute("transit_line");

String trainid =request.getParameter("trainid");
session.setAttribute("trainid", trainid);
Object trainid1= session.getAttribute("trainid");

String start_time = request.getParameter("start_time");
session.setAttribute("start_time", start_time);
Object start_time1= session.getAttribute("start_time");

String start_date =request.getParameter("start_date");
session.setAttribute("start_date", start_date);
Object start_date1= session.getAttribute("start_date");

ApplicationDB db =  new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();
String query = "Select * FROM TrainSchedule";

String transit_line2 = request.getParameter("transit_line");
session.setAttribute("transit_line",transit_line);

String trainid2 = request.getParameter("trainid");
session.setAttribute("trainid",trainid);

String starttime = request.getParameter("start_time");
session.setAttribute("starttime",starttime);

String startdate = request.getParameter("start_date");
session.setAttribute("startdate",startdate);
%>

<%
if(trainid.equals("")){
	out.print("Not selected.<br> Please <a href='add-Trainschedule.jsp'>select one</a>.");
}

query="INSERT INTO `RailwayBooking`.`TrainSchedule` VALUES ('"+ starttime+"', '"+trainid2+"', '"+transit_line2+"', '"+startdate+"');";
st.executeUpdate(query);


	out.print("Job Done.<br> Back to Home <a href='CustomerRepresentative-main-page.jsp'> now </a>.");


st.close();
con.close();



%>



</body>
</html>