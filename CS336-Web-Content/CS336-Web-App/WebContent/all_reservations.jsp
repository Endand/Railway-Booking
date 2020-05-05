<!-- AUTHOR: Jihun Joo -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Reservations</title>
</head>
<body>
<%
ApplicationDB db =  new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();
String username=(String) session.getAttribute("user");
String query="select * from RailwayBooking.Reservation where passenger_username = '"+username +"'order by reservationid desc";
ResultSet rs= st.executeQuery(query);

while(rs.next()){
	int reservationid= rs.getInt("reservationid");
	String classType=rs.getString("class");
	String departureTime = rs.getString("departure_time");
	String start_date=rs.getString("start_date");
	String date_made=rs.getString("date_made");
	String discountType=rs.getString("discount_type");
	String tripType=rs.getString("round_trip"); 
	int totalFare=rs.getInt("total_fare");
	String transitLine=rs.getString("trans_line_name");
	int trainid=rs.getInt("trainid");
	String start_time= rs.getString("start_time");
	int repssn=rs.getInt("repssn");
	int origin= rs.getInt("originid");
	int dest= rs.getInt("destinationid");
	
	
	out.print("Your Reservation ID is <b>" + reservationid + "</b> signed up on "+date_made+"<br><br>");
    
 	out.println("Your Origin station is: " + origin + "<br>");
   	out.println("Your Destination station is: " + dest + "<br>");
   	out.println("Your Class Type is: "+ classType+ "<br><br>");
 	
		
   	if(!discountType.isEmpty()){
   	out.println("You are a: "+ discountType+ "<br>");
   	}
   	if(tripType.equals("1")){
   	out.println("This is a Round-Trip"+"<br><br>");
   	}
   	
   		
	
	//out.println("Your Estimated Travel Time is: " + travelTime + "<br>");
	out.println("Hence your Total Fare is: " +"$" + totalFare + "<br><br>");
	
	
	
	out.println("You will be using our Transit Line " + transitLine +" and our Train Number " +trainid);
		
		out.println(" which starts running on " + start_date + " at "+start_time+".<br><br>" );
		
		if(repssn!= -1){
	out.println("Please reach out to our Representative# " + repssn + " for any questions and concerns."+"<br>");
		}else{
			out.println("Please reach out to our Representatives for any questions and concerns."+"<br>");
		}
	out.print("----------------------------------------------------------------------------------------------------");
	out.print("<br><br>");
}
%>
<% 		rs.close();
        st.close();
        con.close(); %>
</body>
</html>