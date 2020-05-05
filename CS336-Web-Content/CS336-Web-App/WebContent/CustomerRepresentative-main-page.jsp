<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%//deleteReservation
if(session.getAttribute("user") != null && request.getParameter("deleteReservation")!=null) {
	try
	{ 
	 //Get the database connection
	 String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	 Class.forName("com.mysql.jdbc.Driver");
	 Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl");//make connection 

	 String reservationid =request.getParameter("deleteReservation");
	  
	 PreparedStatement pstmt=null; //create statement
	 pstmt=conn.prepareStatement("DELETE FROM Reservation WHERE reservationid = ?"); //sql delete query
	 pstmt.setString(1,reservationid);
	 pstmt.executeUpdate(); //execute query
	  
	 pstmt.close();
	 conn.close(); //close connection
	}
	catch(Exception e)
	{
	 out.println(e);
	}
} else if(session.getAttribute("user") != null && request.getParameter("deleteStartTime")!=null) {
	try
	{ 
	 //Get the database connection
	 String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	 Class.forName("com.mysql.jdbc.Driver");
	 Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // **** 

	 String start_time = request.getParameter("deleteStartTime");
	 String trainid = request.getParameter("deleteTrainID");
	 String trans_line_name =request.getParameter("deleteTransLineName");
	 String start_date =request.getParameter("deleteStartDate");
	 
	  PreparedStatement pstmt=null; //create statement
	  
	 pstmt=conn.prepareStatement("DELETE FROM TrainSchedule WHERE start_time = ? AND trainid = ? AND trans_line_name = ? AND start_date = ?;"); //sql delete query 
	 pstmt.setString(1, start_time);
	 pstmt.setString(2, trainid);
	 pstmt.setString(3, trans_line_name);
	 pstmt.setString(4, start_date);
	 pstmt.executeUpdate(); //execute query
	  
	 pstmt.close(); 
	 conn.close(); //close connection
	}
	catch(Exception e)
	{
	 out.println(e);
	}
} 

%>




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative Page</title>
</head>

<body>

		<%
	    if(session.getAttribute("user") == null) {
	        out.print("You are not logged in.<br> Please <a href='CustomerRepresentative-Login.jsp'>log in</a>.");
	        return;
	    } else {
	        out.print("Welcome, " + session.getAttribute("user") + "!<br>");
	        out.print("<a href='CustomerRepresentative-logout.jsp'>Log out</a>");
	        session.setAttribute("customer?", null);
	    }
    	%>
    	
    	 <br>
    	<br>
    	<form method="POST" action="rep-msgs.jsp"> 
            <!--Button-->
            <input type="submit" value="Respond to customers">
        </form>
    	<br>
    	
    	<br>
    	<br>
    	<form method="POST" action="delay-alert-msg.jsp"> 
            <!--Button-->
            <input type="submit" value="Send a delay message">
        </form>
    	<br>
    	
    	<br>
    	<br>
    	<form method="POST" action="add-reservation1.jsp"> 
            <!--Button-->
            <input type="submit" value="Add Reservation">
        </form>
    	<br>
    	
    	<table>
  
	   <tr>
	    <th>ReservationID</th>
	    <th>Class</th>
	    <th>Departure Time</th>
	    <th>Start Time</th>
	    <th>Date Made</th>
	    <th>Booking Fee</th>
	    <th>Discount Type</th>
	    <th>Originid</th>
	    <th>DestinationID</th>
	    <th>Repssn</th>
	    <th>Passenger Username</th>
	    <th>Trans Line Name</th>
	    <th>TrainID</th>
	    <th>Total Fare</th>
	    <th>Round Trip</th>
	    <th>Start Date</th>

	   </tr>
    	
	    <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

		    //Create a SQL statement
            Statement stmt = conn.createStatement();

            // Select customers from DB
            String searchCommand = "SELECT * FROM Reservation;";
            ResultSet rs = stmt.executeQuery(searchCommand);
            
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
		     <td>
		     	<form method="POST" action="update-reservation.jsp">
		            <!--Button-->
		            <input type="submit" value="Edit Reservation">
		            <input type="hidden" name="edit" value="<%=rs.getString("reservationid")%>">
		        </form> 
			 </td>
		     <td>
		     	<form method="POST" action="CustomerRepresentative-main-page.jsp">
		            <!--Button-->
		            <input type="submit" value="Delete Reservation">
		            <input type="hidden" name="deleteReservation" value="<%=rs.getString("reservationid")%>">
		        </form> 
		     </td>
		     
		    </tr>
            <%   
            }
            
            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e) {
            out.print(e + "<br>");
            out.println("Error: Something went wrong");
        }
    	%>
    	
		</table>

    	<br>
		<br>
		<form method="POST" action="OandD.jsp">
            <!--Button-->
            <input type="submit" value="Show Schedule When Station as Origin and Destination">
        </form>
    	<br>
    	
    	<br>
		<br>
		<form method="POST" action="OorD.jsp">
            <!--Button-->
            <input type="submit" value="Show Schedule When Station as Origin or Destination">
        </form>
    	<br>
    	
    	<br>
		<br>
		<form method="POST" action="customer-seat.jsp">
            <!--Button-->
            <input type="submit" value="Check customer who reserved seat on transitLine and train">
        </form>
    	<br>
		
		<br>
		<br>
		<form method="POST" action="add-Trainschedule.jsp">
            <!--Button-->
            <input type="submit" value="Add Trainschedule">
        </form>
    	<br>
		
	   <table>
  
	   <tr>
	    <th>Start Time</th>
	    <th>Trainid</th>
	    <th>Trans Line Name</th>
	    <th>Start Date</th>
	   </tr>
	   
	   <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

		    //Create a SQL statement
            Statement stmt = conn.createStatement();

            // Select customers from DB
            //String searchCommand = "SELECT * FROM Employee;";
            String searchCommand = "SELECT * FROM RailwayBooking.TrainSchedule;";
            ResultSet rs = stmt.executeQuery(searchCommand);
            
            while(rs.next()) {
            %>
             <tr>
		     <td> <%=rs.getString("start_time")%> </td>
		     <td> <%=rs.getString("trainid")%> </td>
		     <td> <%=rs.getString("trans_line_name")%> </td>
		     <td> <%=rs.getString("start_date")%> </td>
		     <td>
		     	<form method="POST" action="update-Trainschedule.jsp">
		            <!--Button-->  
		            <input type="hidden" name="editStartTime" value="<%=rs.getString("start_time")%>">
		            <input type="hidden" name="editTrianID" value="<%=rs.getString("trainid") %>">
		            <input type="hidden" name="editTriansLineName" value="<%=rs.getString("trans_line_name") %>">
		            <input type="hidden" name="editStartDate" value="<%=rs.getString("start_date") %>">
		            <input type="submit" value="Edit Trainschedule">
		        </form>
		     </td>
		     
		     <td>
		     	<form method="POST" action="CustomerRepresentative-main-page.jsp">
		            <!--Button-->  
		            <input type="hidden" name="deleteStartTime" value="<%=rs.getString("start_time")%>">
		            <input type="hidden" name="deleteTrainID" value="<%=rs.getString("trainid") %>">
		            <input type="hidden" name="deleteTransLineName" value="<%=rs.getString("trans_line_name") %>">
		            <input type="hidden" name="deleteStartDate" value="<%=rs.getString("start_date") %>">
		            <input type="submit" value="Delete Trainschedule">
		        </form> 
		     </td>
		     
		     </tr>
            <%   
            }
            
            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e) {
            out.print(e + "<br>");
            out.println("Error: Something went wrong");
        }
    	%>
    	
    	
    	

		
