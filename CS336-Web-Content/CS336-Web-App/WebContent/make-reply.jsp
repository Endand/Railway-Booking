<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reply to a message</title>
</head>


<body>
        Reply to the message:
        
        <!-- assumes that this is a reply -->
        <%
        String cust, rep;
        String user = (String)session.getAttribute("user");
		
		
		String is_reply = request.getParameter("is_reply");
        %>
        
        <br>
        <form method="POST" action="make-reply-action.jsp">
        	
            <br/>
            <input type = "hidden" name = "title" value = <%=request.getParameter("title")%> ></input>
            <input type = "hidden" name = "is_reply" value = <%=is_reply%> ></input>
        	<input type = "hidden" name = "has_reply" value = <%=-1%> ></input>
        	<%
        		String temp = (String)session.getAttribute("customer?");
            	if(temp == null) {
            		//need to search for correct ssn
            		//set up SQL statement
			        ApplicationDB db =  new ApplicationDB();
			        Connection con = db.getConnection();
			        Statement st = con.createStatement();
			        
			      	//Create a SQL statement
			        PreparedStatement pstmt;
				    pstmt = con.prepareStatement("SELECT ssn FROM RailwayBooking.Employee WHERE username = ?;");
				    pstmt.setString(1, user);
			        ResultSet rs = pstmt.executeQuery();
			        
			        rs.next();
			        int ssn = rs.getInt("ssn");
	    	%> 
	    				<input type = "hidden" name = "cust_asks" value = <%="null"%>></input>
    					<input type = "hidden" name = "empl_ans" value = <%=ssn%> ></input>
	    	<%
	    		} else {
	    	%> 
    					<input type = "hidden" name = "cust_asks" value = <%=user%>></input>
        				<input type = "hidden" name = "empl_ans" value = <%=-1%> ></input>
    		<%
	    		}
        	%>
        	
        	
            <textarea rows = "5" cols = "50" name = "msg">Enter your message:</textarea> 
            
            <!--Button-->
            <input type="submit" value="Submit">
        </form>
        <br>
</body>
</html>