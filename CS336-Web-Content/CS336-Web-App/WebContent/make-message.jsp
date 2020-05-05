<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make a message</title>
</head>


<body>
        Make a message:
        
        <!-- assumes that this is the initial question a customer is asking -->>
        <%
        String user = (String)session.getAttribute("user");
        %>
        
        <br>
        <form method="POST" action="make-message-action.jsp">
        	
        	<br>
        	
            <td> Title: </td><td> <input type="text" name="title"></td><br>
            
            <br/>
            <input type = "hidden" name = "is_reply" value = <%=-1%> ></input>
        	<input type = "hidden" name = "has_reply" value = <%=-1%> ></input>
        	<input type = "hidden" name = "cust_asks" value = <%=user%>></input>
        	<input type = "hidden" name = "empl_ans" value = <%=-1%> ></input>
            <textarea rows = "5" cols = "50" name = "message">Enter your message:</textarea> 
            
            <!--Button-->
            <input type="submit" value="Submit">
        </form>
        <br>
</body>
</html>