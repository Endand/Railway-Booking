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
	/* String transit_line = request.getParameter("transit_line");
    session.setAttribute("choice", transit_line);
    Object choice= session.getAttribute("choice");
     */
    
	ApplicationDB db =  new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String query = "Select * FROM Train";
	String query1 = "Select * FROM TransitLine";
	ResultSet rs= st.executeQuery(query);
	ResultSet rs1= st.executeQuery(query1);
	
	String Train = request.getParameter("Train");
	session.setAttribute("Train",Train);
	
	String TransitLine = request.getParameter("TransitLine");
	session.setAttribute("TransitLine",TransitLine);
	    
	%>
    	<form method="get" action="customer-seat-action.jsp">
        <br/>
        
        Select Train 
        <select name="Train">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        </select>
        
        Select TransitLine
        <select name="TransitLine">
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
        <option value="E">E</option>
        <option value="F">F</option>
        </select>
        
       	</table>	
        <!--Button-->  
         <input type="submit" value="Check">

</body>

</html>
		