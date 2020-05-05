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
<title>Monthly Sales Report</title>
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
    	
    	<table>
  
	   <tr>
	    <th>reservation id</th>
	    <th>class</th>
	    <th>Departure Time</th>
	    <th>Start Time</th>
	    <th>Date Made</th>
	    <th>Booking Fee</th>
	    <th>Discount Type</th>
	    <th>Origin Id</th>
	    <th>Destination Id</th>
	    <th>Representative SSN</th>
	    <th>Passenger Username</th>
	    <th>Transit Line Name</th>
	    <th>Train ID</th>	
	    <th>Total Fare</th>	  
	    <th>Round Trip</th>
	    <th>Start Date</th>	   
	    <th>Revenue</th>	   	    
	   </tr>
    	
	    <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

            // Select customers from DB
            String month = request.getParameter("month");
            out.print("<br>"+ month);
            
            PreparedStatement pstmt;
		    pstmt = conn.prepareStatement("SELECT reservationid, class, departure_time, start_time, date_made, booking_fee, discount_type, originid, destinationid, repssn, passenger_username, trans_line_name, trainid, total_fare, round_trip, start_date, booking_fee+total_fare as revenue FROM Reservation WHERE monthname(date_made) = ?;");
		    pstmt.setString(1,month);
		    ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
            %>
            <tr>
		     <td> <%=rs.getString("reservationid")%> </td>
		     <td> <%=rs.getString("class")%> </td>
		     <td> <%=rs.getString("departure_time")%> </td>
		     <td> <%=rs.getString("start_time")%> </td>
		     <td> <%=rs.getString("date_made")%> </td>
		     <td> <%=rs.getString("booking_fee")%> </td>
		     <td> <%=rs.getString("discount_type")%> </td>
		     <td> <%=rs.getString("originid")%> </td>
		     <td> <%=rs.getString("destinationid")%> </td>
		     <td> <%=rs.getString("repssn")%> </td>
		     <td> <%=rs.getString("passenger_username")%> </td>
		     <td> <%=rs.getString("trans_line_name")%> </td>
		     <td> <%=rs.getString("trainid")%> </td>
		     <td> <%=rs.getString("total_fare")%> </td>
		     <td> <%=rs.getString("round_trip")%> </td>
		     <td> <%=rs.getString("start_date")%> </td>
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
        
</body>

</html>