<!-- AUTHOR: Paul John -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Revenue Listing</title>
</head>

<body>
		<%
	    if(session.getAttribute("user") == null) {
	        out.print("You are not logged in.<br> Please <a href='admin-login.jsp'>log in</a>.");
	        return;
	    } else {
	        out.print("Welcome, " + session.getAttribute("user") + "!<br>");
	        out.print("<a href='admin-logout.jsp'>Log out</a>");
	    }
    	%>
    	
    	<%
    	String filterOption = request.getParameter("filter-option");
    	out.print(filterOption);
    	if(filterOption.equals("transit-line")) {
    	%>	
    		<table>
    		  
    		   <tr>
    		    <th>Transit Line</th>	   
    		    <th>Revenue</th>	   	    
    		   </tr>
    		   
    		<% 
	        try {
	            //Get the database connection
	            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****
	
	            PreparedStatement pstmt;
			    pstmt = conn.prepareStatement("SELECT trans_line_name, SUM(booking_fee+total_fare) revenue FROM Reservation r GROUP BY trans_line_name ORDER BY revenue DESC;");
			    ResultSet rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	            %>
	            <tr>
			     <td> <%=rs.getString("trans_line_name")%> </td>
			     <td> <%=rs.getString("revenue")%> </td>
			    </tr>
	            <%   
	            }
	            
	            rs.close();
	            pstmt.close();
	            conn.close();
	
	        } catch(Exception e) {
	            out.print(e + "<br>");
	            out.println("Error: Something went wrong");
	        }
	    	%>
    		</table>
    	<%		   
    	} else if (filterOption.equals("destination-city")) {
    	%>
    		<table>
    		  
    		   <tr>
    		    <th>Destination City</th>	   
    		    <th>Revenue</th>	   	    
    		   </tr>
    		   
    		<% 
	        try {
	            //Get the database connection
	            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****
	
	            PreparedStatement pstmt;
			    pstmt = conn.prepareStatement("SELECT s.name, SUM(r.booking_fee+r.total_fare) revenue FROM Reservation r JOIN Station s ON r.destinationid = s.stationid GROUP BY s.name ORDER BY revenue DESC;");
			    ResultSet rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	            %>
	            <tr>
			     <td> <%=rs.getString("name")%> </td>
			     <td> <%=rs.getString("revenue")%> </td>
			    </tr>
	            <%   
	            }
	            
	            rs.close();
	            pstmt.close();
	            conn.close();
	
	        } catch(Exception e) {
	            out.print(e + "<br>");
	            out.println("Error: Something went wrong");
	        }
	    	%>  
	    	  		   
    		</table>
    	<%
    	} else if (filterOption.equals("customer-name")) {
    	%>
    		<table>
    		  
    		   <tr>
    		    <th>Customer Name</th>	   
    		    <th>Revenue</th>	   	    
    		   </tr>
    		   
    		<% 
	        try {
	            //Get the database connection
	            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****
	
	            PreparedStatement pstmt;
			    pstmt = conn.prepareStatement("SELECT passenger_username, SUM(booking_fee+total_fare) as revenue FROM Reservation GROUP BY passenger_username ORDER BY revenue DESC;");
			    ResultSet rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	            %>
	            <tr>
			     <td> <%=rs.getString("passenger_username")%> </td>
			     <td> <%=rs.getString("revenue")%> </td>
			    </tr>
	            <%   
	            }
	            
	            rs.close();
	            pstmt.close();
	            conn.close();
	
	        } catch(Exception e) {
	            out.print(e + "<br>");
	            out.println("Error: Something went wrong");
	        }
	    	%>    	
	    		   
    		</table>
    	<%	
    	}
    	%>
        
</body>

</html>