<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservation Changing....</title>
</head>
<body>
    <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

          
            //String username,password,phone,email,firstName,lastName,city,state,zipCode,street;
            //String reservationid,whichclass,departure_time,start_time,date_made,booking_fee,discount_type,originid,destinationid,repssn,passenger_username,trans_line_name,trainid,total_fare,round_trip,start_date;
            
            //String updateUsername = request.getParameter("user_name_original");
            String updateReservationid = request.getParameter("user_reservation_original");
            String updateclass = request.getParameter("txt_class");
            String updateround_trip = request.getParameter("txt_round_trip");
            String start_date = request.getParameter("txt_start_date");
            
           String reservationid = request.getParameter("txt_reservationid");
           //String whichclass = request.getParameter("txt_class");
            String departure_time = request.getParameter("txt_departure_time");
            String start_time = request.getParameter("txt_start_time");
            String date_made = request.getParameter("txt_date_made");
            String booking_fee = request.getParameter("txt_booking_fee");
            String discount_type = request.getParameter("txt_discount_type");
            String originid = request.getParameter("txt_originid");
            String destinationid = request.getParameter("txt_destinationid");
            String repssn = request.getParameter("txt_repssn");
            String passenger_username = request.getParameter("txt_passenger_username");
            String trans_line_name = request.getParameter("txt_trans_line_name");
            String trainid = request.getParameter("txt_trainid");
            String total_fare = request.getParameter("txt_total_fare");
            //String round_trip = request.getParameter("txt_round_trip");
            
            
            
            //out.println(updateclass);
		    //Create a SQL statement
            PreparedStatement pstmt;
		    pstmt = conn.prepareStatement("UPDATE Reservation SET reservationid = ?, class = ?, departure_time = ?, start_time = ?, date_made = ?, booking_fee = ?, discount_type = ?, originid = ?, destinationid = ?, repssn = ? , passenger_username = ?, trans_line_name = ?, trainid = ?, total_fare = ?, round_trip = ?, start_date = ? WHERE reservationid = ?;");
            pstmt.setString(1,reservationid);
            pstmt.setString(2,updateclass);
            pstmt.setString(3,departure_time);
            pstmt.setString(4,start_time);
            pstmt.setString(5,date_made);
            pstmt.setString(6,booking_fee);
            pstmt.setString(7,discount_type);
            pstmt.setString(8,originid);
            pstmt.setString(9,destinationid);
            pstmt.setString(10,repssn);
            pstmt.setString(11,passenger_username);
            pstmt.setString(12,trans_line_name);
            pstmt.setString(13,trainid);
            pstmt.setString(14,total_fare);
            pstmt.setString(15,updateround_trip);
            pstmt.setString(16,start_date);
            pstmt.setString(17,updateReservationid);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            out.println("Sucessfully edited Reservation. <a href='CustomerRepresentative-main-page.jsp'>Return to main page</a>");

        } catch(Exception e) {
            out.print(e + "<br>");
            out.println("Error: Not able to edit Reservation. <a href='CustomerRepresentative-main-page.jsp'>Return to main page</a>");
        }
    %>


</body>


</html>