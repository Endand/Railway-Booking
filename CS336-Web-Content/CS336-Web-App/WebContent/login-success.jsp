<!-- AUTHOR: Sanjun Ko, Jihun Joo, Jake TruongCao -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome!</title>
</head>

<body>

    <%
    if(session.getAttribute("user") == null) {
        out.print("You are not logged in.<br> Please <a href='login.jsp'>log in</a>.");
    } else {
        out.print("Welcome, " + session.getAttribute("user") + "!<br><br>");
        session.setAttribute("customer?", "true");
        out.print("Click" + "<a href='reservation.jsp'> here </a>" + "to make a reservation" +"<br><br>" );
        %>
        
      	Click<a href="all_reservations.jsp"> here</a> to view all your past reservations.
      	<br><br>
      	<%
        out.print("Click" + "<a href='customer-inbox.jsp'> here </a>" + "to see your messages." +"<br><br>" );
        out.print("<a href='logout.jsp'>Log out</a>");
    }
    %>

</body>

</html>