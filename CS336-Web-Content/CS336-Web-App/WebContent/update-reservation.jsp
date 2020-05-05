<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Reservation</title>
</head>
<body>
	<div class="main"> 
	<form method="post" action="update-reservation-action.jsp">
	 
	  <center>
	   <h1>Update Record</h1>
	  </center>
	  
	  <table> 
	      <% 
	        try {
	            //Get the database connection
	            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****
	
			    //Create a SQL statement
	            Statement stmt = conn.createStatement();
	            
	            if(request.getParameter("edit")!=null) 
	            {
	             String reservationid=request.getParameter("edit");
	             String whichclass,departure_time,start_time,date_made,booking_fee,discount_type,originid,destinationid,repssn,passenger_username,trans_line_name,trainid,total_fare,round_trip,start_date;
	       
	            String searchCommand = "SELECT * FROM Reservation WHERE reservationid ='" + reservationid + "';";
	            ResultSet editItems = stmt.executeQuery(searchCommand);
	            
	            
	            while(editItems.next()) {
	            whichclass = editItems.getString("class");
	            departure_time = editItems.getString("departure_time");
	            start_time = editItems.getString("start_time");
	            date_made = editItems.getString("date_made");
	            booking_fee = editItems.getString("booking_fee");
	            discount_type = editItems.getString("discount_type");
	            originid = editItems.getString("originid");
	            destinationid = editItems.getString("destinationid");
	            repssn = editItems.getString("repssn");
	            passenger_username = editItems.getString("passenger_username");
	            trans_line_name = editItems.getString("trans_line_name");
	            trainid = editItems.getString("trainid");
	            total_fare = editItems.getString("total_fare");
	            round_trip = editItems.getString("round_trip");
	            start_date = editItems.getString("start_date");
	            %>
	            <tr>
				    <td>reservationid</td>
				    <td><input type="text" name="txt_reservationid" value="<%=reservationid %>"></td>
			    </tr>
			    <tr>
				    <td>class</td>
				    <td><input type="text" name="txt_class" value="<%=whichclass %>"></td>
			    </tr>
	            <tr>
				    <td>departure_time</td>
				    <td><input type="text" name="txt_departure_time" value="<%=departure_time %>"></td>
			    </tr>
			    <tr>
				    <td>start_time</td>
				    <td><input type="text" name="txt_start_time" value="<%=start_time %>"></td>
			    </tr>			    
	            <tr>
				    <td>date_made</td>
				    <td><input type="text" name="txt_date_made" value="<%=date_made %>"></td>
			    </tr>
			    <tr>
				    <td>booking_fee</td>
				    <td><input type="text" name="txt_booking_fee" value="<%=booking_fee %>"></td>
			    </tr>
	            <tr>
				    <td>discount_type</td>
				    <td><input type="text" name="txt_discount_type" value="<%=discount_type %>"></td>
			    </tr>
			    <tr>
				    <td>originid</td>
				    <td><input type="text" name="txt_originid" value="<%=originid %>"></td>
			    </tr>			    
	            <tr>
				    <td>destinationid</td>
				    <td><input type="text" name="txt_destinationid" value="<%=destinationid %>"></td>
			    </tr>
			    <tr>
				    <td>repssn</td>
				    <td><input type="text" name="txt_repssn" value="<%=repssn %>"></td>
			    </tr>
			    <tr>
				    <td>passenger_username</td>
				    <td><input type="text" name="txt_passenger_username" value="<%=passenger_username %>"></td>
			    </tr>
			    <tr>
				    <td>trans_line_name</td>
				    <td><input type="text" name="txt_trans_line_name" value="<%=trans_line_name %>"></td>
			    </tr>
			    <tr>
				    <td>trainid</td>
				    <td><input type="text" name="txt_trainid" value="<%=trainid %>"></td>
			    </tr>
			    <tr>
				    <td>total_fare</td>
				    <td><input type="text" name="txt_total_fare" value="<%=total_fare %>"></td>
			    </tr>
			    <tr>
				    <td>round_trip</td>
				    <td><input type="text" name="txt_round_trip" value="<%=round_trip %>"></td>
			    </tr>
			    <tr>
				    <td>start_date</td>
				    <td><input type="text" name="txt_start_date" value="<%=start_date %>"></td>
			    </tr>			    
			    
				
			    
			    <input type="hidden" name="user_reservation_original" value="<%=reservationid %>">
			    <input type="hidden" name="user_whichclass" value="<%=whichclass%>">
			    <input type="hidden" name="user_round_trip" value="<%=round_trip%>">
			    
			    
			    <tr>
				    <td><input type="submit" name="btn_update" value="Update"></td> 
			    </tr>
	            <%
	            } 
	            
	            editItems.close();
	            stmt.close();
	            conn.close();
	            
	            }
	        } catch(Exception e) {
	            out.print(e + "<br>");
	            out.print("Login failed. Click <a href='login.jsp'>here</a> to return to the login screen.");
	        }
	    %>
	  </table> 
	  
	  <center>
	    <h1><a href="CustomerRepresentative-main-page.jsp">Back</a></h1>
	  </center>
	  
	 </form>
	</div>
</body>
</html>