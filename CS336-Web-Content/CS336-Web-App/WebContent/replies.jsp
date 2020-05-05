<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Replies</title>
</head>

<body>
    	<%
	    	//set up SQL statement
	        ApplicationDB db =  new ApplicationDB();
	        Connection con = db.getConnection();
	        Statement st = con.createStatement();
    	%>
    	
        First Question: <br>
        <br>
        <%
        	
        	//variables for each message
        	int msgid = Integer.parseInt((String)request.getParameter("msgid"));
        	int next_msgid;
        	
      		//Create a SQL statement
	        PreparedStatement pstmt;
		    pstmt = con.prepareStatement("SELECT * FROM RailwayBooking.Messages m WHERE m.msgid = ?;");
		    pstmt.setInt(1, msgid);
	        ResultSet rs = pstmt.executeQuery();
	        rs.next();
        %>
        
        Title: <%=rs.getString("title")%> <br>
		Date: <%=rs.getString("date")%> <br>
		Time: <%=rs.getString("time")%> <br>
		From: <%=rs.getString("cust_asks")%>
		<br>
		---------------------------<br>
		Message: <br>
		<%=rs.getString("msg")%> <br>
		
		<%next_msgid = rs.getInt("has_reply"); %>
        ================================================================================================================ <br>
        Replies:<br>
        ---------------------------------------------------------------------------------------------------------------- <br>
        <% 
        
        //gets every message after the head
        while(next_msgid != -1) {
			
        	//Prepare to make another SQL statement
        	pstmt = con.prepareStatement("SELECT * FROM RailwayBooking.Messages m WHERE m.msgid = ?;");
    	    pstmt.setInt(1, next_msgid);
            rs = pstmt.executeQuery();
            rs.next();
		%>
			Title: <%=rs.getString("title")%> <br>
			Date: <%=rs.getString("date")%> <br>
			Time: <%=rs.getString("time")%> <br>
			From: 
			<% 
				String temp = (String)session.getAttribute("customer?");
				String user1 = rs.getString("cust_asks");
				
				if(rs.getInt("empl_ans") == -1) {
					%><%=user1%><%
				//need to do query for employee username
				} else {
					pstmt = con.prepareStatement("SELECT username FROM RailwayBooking.Employee e WHERE e.ssn = ?;");
					pstmt.setInt(1, rs.getInt("empl_ans"));
		            ResultSet eset = pstmt.executeQuery();
		            eset.next();
					%><%=eset.getString("username")%><%
				}
			%><br>
			---------------------------<br>
			Message: <br>
			<%=rs.getString("msg")%> <br>
			
			<%
			msgid = next_msgid;
			next_msgid = rs.getInt("has_reply"); 
			%>
			---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- <br>
		<%
		}
        %>
        
        <form method="POST" action="make-reply.jsp">
        	<input type = "hidden" name = "title" value = <%= rs.getString("title")%>></input>
        	<input type = "hidden" name = "is_reply" value = <%=msgid%>></input>
        	<input type = "submit" value = "reply to this QA chain"></input>
        </form>

</body>
</html>
