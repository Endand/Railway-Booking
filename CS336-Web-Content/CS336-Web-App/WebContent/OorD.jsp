<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schedule Searching</title>
</head>

<body>
	<% 
    
	ApplicationDB db =  new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String query = "Select * FROM TrainSchedule";
	ResultSet rs= st.executeQuery(query);
	
	String OorD = request.getParameter("OorD");
	session.setAttribute("OorD",OorD);
	    
	%>
    	<form method="get" action="OorD-action.jsp">
        <br/>
        
        Select station as origin or destination 
        <select name="OorD">
        <option value="A">Penn(Penn, NJ)</option>
        <option value="B">U Pitt(Pittsburgh, PA)</option>
        <option value="C">Trenton(Trenton, NJ)</option>
        <option value="D">William Paterson University (Wayne, NJ)</option>
        <option value="E">Fordham(New York City, NY)</option>
        <option value="F">Montclair(Montclair, NJ)</option>
        <option value="G">Rider(Lawrence, NJ)</option>
        </select>
        
       	</table>	
        <!--Button-->  
         <input type="submit" value="Check">

</body>

</html>
		