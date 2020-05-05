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
<title>Thank you!</title>
</head>
<body>
<h1>Thank you!</h1>
<%
ApplicationDB db =  new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();

String user= (String) session.getAttribute("user");
String transitLine= (String) session.getAttribute("transitLine");
String expDate= (String) session.getAttribute("expDate");


String query="SELECT * FROM RailwayBooking.TimedFare;";
ResultSet rs= st.executeQuery(query);

if(rs.next()){ //gets rid of the old pass
	query="DELETE FROM `RailwayBooking`.`TimedFare` WHERE (`customer_name` = '"+user+"') and (`line_name` = '"+transitLine+"');";
	st.executeUpdate(query);
}

//update with the new pass
	query="insert into `RailwayBooking`.`TimedFare` VALUES('"+expDate+"','"+user+"','"+transitLine+"')  ;";
	st.executeUpdate(query);

%>
<br><br>
<%
out.print("Your reservations until "+expDate+" is going to cost $0! <br><br>");
%>
    	<a href="reservation.jsp">Click here</a> to make a reservation for free!
    	<% rs.close();
        st.close();
        con.close(); %>
</body>
</html>