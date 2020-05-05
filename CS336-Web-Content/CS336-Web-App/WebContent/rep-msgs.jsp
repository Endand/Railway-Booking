<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Representative Inbox</title>
</head>

<body>
        Search:
        <form method="POST" action="search-msgs-rep.jsp">
        	<input type = "text" name = "search">
        	<input type = "submit" value = "search"></input>
        </form>
        
        
        <%
        /*
        session.setAttribute("user", "jake");
        session.setAttribute("customer?", null);
        */
        %>
        
        <br>
        Answerable questions: <br>
        ---------------------------------------------------------------------------------------------------------------- <br>
        <% 
      	//set up SQL statement
        ApplicationDB db =  new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
      	//Create a SQL statement
        PreparedStatement pstmt;
	    pstmt = con.prepareStatement("SELECT * FROM RailwayBooking.Messages WHERE empl_ans = -1 AND (has_reply = -1) AND NOT(msgid = -1) ORDER BY date, time;");
        ResultSet rs = pstmt.executeQuery();
        
        
        //gets every message
        while(rs.next()) {
		%>
			Title: <%=rs.getString("title")%> <br>
			Date: <%=rs.getString("date")%> <br>
			Time: <%=rs.getString("time")%> <br>
			From: <%=rs.getString("cust_asks") %>
			<br>
			Message: <br>
			<%=rs.getString("msg")%> <br>
			
			<%
			//look for "top" statement
			int msgid = rs.getInt("msgid");
    		int next = msgid;
    		while(next != -1){
    			msgid = next;
        		pstmt = con.prepareStatement("SELECT is_reply FROM RailwayBooking.Messages WHERE msgid = ?");
        		pstmt.setString(1, msgid + "");
        		ResultSet tempset = pstmt.executeQuery();
        		tempset.next();
        		next = tempset.getInt("is_reply");
        		
    		}
			%>
			
			<br>
			<form method="POST" action="replies.jsp"> <!-- A button to see replies -->
				<input type="hidden" name="msgid" value="<%= msgid %>" />
				<input type="submit" value="See entire QA chain and/or make a reply"></input>
			</form>
			
			---------------------------------------------------------------------------------------------------------------- <br>
		<%
		}
        
        %>
        ====================================================================================================<br>
        All comment chains:<br>
        ---------------------------------------------------------------------------------------------------------------- <br>
        <%
        pstmt = con.prepareStatement("SELECT title, date, time, msg, msgid FROM RailwayBooking.Messages WHERE is_reply = -1 AND NOT msgid = -1 AND NOT empl_ans = -2 ORDER BY date, time;");
        rs = pstmt.executeQuery();
		
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