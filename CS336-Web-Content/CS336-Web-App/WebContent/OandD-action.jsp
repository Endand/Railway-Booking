<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display Searching Result</title>
</head>
<body>
<%
String OandD =request.getParameter("OandD");
session.setAttribute("OandD", OandD);
Object OandD1= session.getAttribute("OandD");

ApplicationDB db =  new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();
String query = "Select * FROM TrainSchedule";
%>


<%
//out.println("This is Line: "+ OandD1);
String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****
Statement stmt = conn.createStatement();
String searchCommand = null;

if(OandD1.equals("A")){
	out.println("This is the schedule from Penn(Penn,NJ) to Montclair(Montclair,NJ)!");
	%>
	<br>
	<%
	out.println("List of train schedule running as specific origin and destination:");
	searchCommand = "SELECT * FROM RailwayBooking.TrainSchedule where trans_line_name = 'A';";
	}
else if(OandD1.equals("B")){
	out.println("This is the schedule from U Pitt(Pittsburgh,PA) to Montclair(Montclair,NJ)!");
	%>
	<br>
	<%
	out.println("List of train schedule running as specific origin and destination:");
	searchCommand = "SELECT * FROM RailwayBooking.TrainSchedule where trans_line_name = 'B';";
}
else if(OandD1.equals("C")){
	out.println("This is the schedule from Trenton(Trenton,NJ) to Montclair(Montclair,NJ)!");
	%>
	<br>
	<%
	out.println("List of train schedule running as specific origin and destination:");
	searchCommand = "SELECT * FROM RailwayBooking.TrainSchedule where trans_line_name = 'C';";
}
else if(OandD1.equals("D")){
	out.println("This is the schedule from William Paterson University(Wayne,NJ) to Montclair(Montclair,NJ)!");
	%>
	<br>
	<%
	out.println("List of train schedule running as specific origin and destination:");
	searchCommand = "SELECT * FROM RailwayBooking.TrainSchedule where trans_line_name = 'D';";
}
else if(OandD1.equals("E")){
	out.println("This is the schedule from Fordham(New York City, NY) to Rider(Lawrence, NJ)!");
	%>
	<br>
	<%
	out.println("List of train schedule running as specific origin and destination:");
	searchCommand = "SELECT * FROM RailwayBooking.TrainSchedule where trans_line_name = 'E';";
}
else if(OandD1.equals("F")){
	out.println("This is the schedule from Penn(Penn,NJ) to Rider(Lawrence, NJ)!");
	%>
	<br>
	<%
	out.println("List of train schedule running as specific origin and destination:");
	searchCommand = "SELECT * FROM RailwayBooking.TrainSchedule where trans_line_name = 'F';";
}
//out.print("job done");
ResultSet rs = stmt.executeQuery(searchCommand);
%>
<table>
	   <tr>
	    <th>start_time</th>
	    <th>trainid</th>
	    <th>trans_line_name</th>
	    <th>start_date</th>
	   </tr>

<% 
while(rs.next()){
	%>
	<tr>
	<p>
		     <td> <%=rs.getString("start_time")%> </td>
		     <td> <%=rs.getString("trainid")%> </td>
		     <td> <%=rs.getString("trans_line_name")%> </td>
		     <td> <%=rs.getString("start_date")%> </td>
		     <td>
	</td>
	</p>
	
	<%} 
out.print("Searching Finished.<br> Back to Home <a href='CustomerRepresentative-main-page.jsp'> now </a>.");
	%>	     
<%
rs.close();
st.close();
con.close();
%>
</table>
</body>
</html>