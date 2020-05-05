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
	
	String OandD = request.getParameter("OandD");
	session.setAttribute("OandD",OandD);
	    
	%>
		<!-- <form method="get" action="station_selection.jsp"> -->
    	<form method="get" action="OandD-action.jsp">
        <br/>
        
        Select specific origin and destination 
        <select name="OandD">
        <option value="A">Origin[Penn(Penn,NJ)] & Destination[Montclair(Montclair,NJ)]</option>
        <option value="B">Origin[U Pitt(Pittsburgh,PA)] & Destination[Montclair(Montclair,NJ)]</option>
        <option value="C">Origin[Trenton(Trenton,NJ)] & Destination[Montclair(Montclair,NJ)]</option>
        <option value="D">Origin[William Paterson University(Wayne,NJ)] & Destination[Montclair(Montclair,NJ)]</option>
        <option value="E">Origin[Fordham(New York City, NY)] & Destination[Rider(Lawrence, NJ)]</option>
        <option value="F">Origin[Penn(Penn,NJ)] & Destination[Rider(Lawrence, NJ)]</option>
        </select>
        
       	</table>	
        <!--Button-->  
         <input type="submit" value="Check">

</body>

</html>
		