<!-- AUTHOR: Jihun Joo -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel Successful</title>
</head>
<body>
<%
ApplicationDB db =  new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();

int reservationid=(Integer) session.getAttribute("reservationid");
String query="DELETE FROM `RailwayBooking`.`Reservation` WHERE (`reservationid` = '"+reservationid+"');";
st.executeUpdate(query);
%>
Reservation ID <%=reservationid %> is canceled successfully!
<br><br>
    	<a href="reservation.jsp">Click here</a> to make another reservation.
    	
	<% 
        st.close();
        con.close(); %>
</body>
</html>