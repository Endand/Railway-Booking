<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schedule Detail</title>
</head>

<body>
	<% 
	String transit_line = request.getParameter("transit_line");
    session.setAttribute("choice", transit_line);
    Object choice= session.getAttribute("choice");
    
    
	ApplicationDB db =  new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String query = "select t2.name, t2.stationid from (SELECT stationid FROM RailwayBooking.Stops where RailwayBooking.Stops.trans_line_name='" + choice + "') as t1, RailwayBooking.Station as t2 where t1.stationid=t2.stationid; ";
	String query1= "Select * FROM TransitLine";
	ResultSet rs= st.executeQuery(query);
	ResultSet rs1= st.executeQuery(query1);
	    
	 String transitLine = request.getParameter("transit_line");
	 session.setAttribute("transitLine",transitLine);
	%>
		<!-- <form method="get" action="station_selection.jsp"> -->
    	<form method="get" action="add-Trainschedule1.jsp">
        <br/>
        
        Select Transit Line
        <select name="transit_line">
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
        <option value="E">E</option>
        <option value="F">F</option>
        </select>
		
		
		<table>
		Select Train ID
	    <select name="trainid">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        </select>
        <tr> 
            <td> start_time: </td><td> <input type="text" name="start_time"></td>
        </tr>
        <tr> 
            <td> start_date: </td><td> <input type="text" name="start_date"></td>
        </tr>
        
	    </table>	
             <!--Button-->  
	
         <input type="submit" value="submit">
  
<!--    		rs.close();
        st.close();
        con.close(); -->
	

</body>

</html>