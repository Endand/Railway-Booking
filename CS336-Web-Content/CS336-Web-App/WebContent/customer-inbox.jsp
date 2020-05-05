<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Inbox</title>
</head>

<body>
    
        Customer Inbox: <br>
        <br>
        Click <a href="make-message.jsp"> here</a> to make a new question or request to a Customer Representative. <br>
        <br>
        Search:
        <form method="POST" action="search-msgs.jsp">
        	<input type = "text" name = "search">
        	<input type = "submit" value = "search"></input>
        </form>
        
        <br>
        Your messages:<br>
        ---------------------------------------------------------------------------------------------------------------- <br>
        <% 
      	//set up SQL statement
        ApplicationDB db =  new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
      	//Create a SQL statement
        PreparedStatement pstmt;
	    pstmt = con.prepareStatement("SELECT title, date, time, msg, msgid FROM RailwayBooking.Messages m WHERE m.cust_asks = ? AND (is_reply = -1) ORDER BY date, time;");
	    pstmt.setString(1,(String)session.getAttribute("user"));
        ResultSet rs = pstmt.executeQuery();
        
        
        
        //gets every message
        while(rs.next()) {
		%>
			Title: <%=rs.getString("title")%> <br>
			Date: <%=rs.getString("date")%> <br>
			Time: <%=rs.getString("time")%> <br>
			<br>
			Message: <br>
			<%=rs.getString("msg")%> <br>
			
			<br>
			<form method="POST" action="replies.jsp"> <!-- A button to see replies -->
				<input type="hidden" name="msgid" value="<%= rs.getInt("msgid") %>" />
				<input type="submit" value="See replies and make a reply"></input>
			</form>
			
			---------------------------------------------------------------------------------------------------------------- <br>
		<%
		}
        
        pstmt.close();
        con.close();
        
        %>

</body>
</html>
