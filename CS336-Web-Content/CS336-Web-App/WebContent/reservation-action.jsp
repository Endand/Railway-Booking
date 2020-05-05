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
<title>You did it!</title>
</head>
<body>

		<%
	  	ApplicationDB db =  new ApplicationDB();
    	Connection con = db.getConnection();
    	Statement st = con.createStatement();
    	 Object username= session.getAttribute("user");
 	    session.setAttribute("user", username);
		
		String origin = request.getParameter("origin");
       	String dest = request.getParameter("destination");
       	String trainSchedule = request.getParameter("schedule");
       	String classType = request.getParameter("class");
       	String discountType = request.getParameter("discount");
       	String tripType = request.getParameter("tripType");
     	String user= (String) username;
     	String transitLine= (String) session.getAttribute("transitLine");
		
     	if(origin.isEmpty()||dest.isEmpty()){
     		out.print("Please select both origin and destination stations!<br><br>");
     		%> 
     		Click <a href="reservation.jsp"> here</a> to make a reservation!
     		
     	<%}
     	else{
     	
     	
     	//get the reservaionid
     	String query ="select if(max(r.reservationid) is null,1,max(r.reservationid)+1) as nextRid from RailwayBooking.Reservation r";
     	ResultSet rs= st.executeQuery(query);	
     	int reservationid=0;
     	if(rs.next()){
     	reservationid= rs.getInt("nextRid");
     	}
     	
   		 session.setAttribute("reservationid",reservationid);
     	
     	
    	//get the station names
    	int originInt=java.lang.Integer.parseInt(origin);
        int destInt=java.lang.Integer.parseInt(dest);
        String originName="";
        String destName="";
     	query="select s.name from RailwayBooking.Station s where s.stationid="+origin;
     	rs= st.executeQuery(query);
     	if(rs.next()){
     		originName= rs.getString("name");
         	}
     	query="select s.name from RailwayBooking.Station s where s.stationid="+dest;
     	rs= st.executeQuery(query);
     	if(rs.next()){
     		destName= rs.getString("name");
         	}
     	
     	//get the repssn (selected randomly from repesentatives)
     	/*
     	query="SELECT e.ssn FROM RailwayBooking.Employee e where e.role='Representative' order by rand() limit 1;";
     	rs=st.executeQuery(query);
     	int repssn=0;
     	if(rs.next()){
     		repssn= rs.getInt("ssn");
     	}
     	*/
     	
     	//gets start_time and start_date and trainid
     	String[] dateTime= trainSchedule.split(" ");
     	String start_date=dateTime[0];
     	String start_time=dateTime[1];
     	String trainid=dateTime[2];
     	
     	//gets date_made
     	java.text.DateFormat df = new java.text.SimpleDateFormat("YYYY-MM-dd");
     	String date_made= df.format(new java.util.Date());
     	
     	//gets departure time
     	    query="select sec_to_time(sum(time_to_sec(stop.travelTime))) as totalTime from (select tl.`travel time` as travelTime, tl.stopid from (SELECT * FROM RailwayBooking.Stops s where s.trans_line_name='"+transitLine+"' order by stopid)as tl where tl.stopid<='"+origin+"') as stop";
     		rs= st.executeQuery(query);
     		String travelTime="";
     		if(rs.next()){
     			travelTime=rs.getString("totalTime");
     		}
     		java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm:ss");
     		timeFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
     		java.util.Date date1= timeFormat.parse(start_time);
     		java.util.Date date2= timeFormat.parse(travelTime);
     		long sum = date1.getTime() + date2.getTime();

     		String departureTime = timeFormat.format(new java.util.Date(sum));
     	
     	//calculate the total fare
     		query="select (t.fare_per_stop * count(stop.stopid)) as totalFare from RailwayBooking.TransitLine t, (select * from (SELECT * FROM RailwayBooking.Stops s where s.trans_line_name='"+transitLine+"' order by stopid)as tl where tl.stopid<='"+dest+"') as stop where t.name=stop.trans_line_name;";
     		rs= st.executeQuery(query);
     		String totalFareString="";
     		double totalFare=0;
     		if(rs.next()){
     			totalFareString=rs.getString("totalFare");
     		}
     		//turn into double
     		totalFare=Double.parseDouble(totalFareString);
     		
     		if(classType.equals("business")){
     			totalFare*=1.5;
     		}else if(classType.equals("first")){
     			totalFare*=2;
     		}
     		if(tripType.equals("1")){
     			totalFare=Double.parseDouble(totalFareString)*2;
     		}
     		if(!discountType.isEmpty()){
     			totalFare-=5; //$5 discount
     		}
     		if(totalFare<0){
     			totalFare=0;
     		}
     		
     		query="SELECT tf.exp_date FROM RailwayBooking.TimedFare tf where tf.customer_name='"+user+"' and tf.line_name='"+transitLine+"';";
     		rs= st.executeQuery(query);
     		boolean active=false;
     		if(rs.next()){
     			java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
     			String expDate= rs.getString("exp_date");
     			java.util.Date ed= df2.parse(expDate);
     			java.util.Date dm= df2.parse(date_made);
     			if(ed.compareTo(dm)>=0){
         			totalFare=0;
         			active=true;
         		}
     		}
     		
     	
     	//check if user enter both origin and destination
       	if(origin.isEmpty() || dest.isEmpty()){
			out.print("Please choose both the origin and the destination" + "<br><br>");
			out.print("Click <a href='reservation.jsp'>here</a> to return to the reservation screen.");
       	}
       	else{
        	java.util.Date dateMade=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(date_made);
        	java.sql.Date sqlDateMade = new java.sql.Date(dateMade.getTime());
        	java.util.Date startDate=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(start_date);
        	java.sql.Date sqlStartDate = new java.sql.Date(startDate.getTime());
        	
        	
        	int trainidInt=java.lang.Integer.parseInt(trainid);
        	int tripTypeInt=java.lang.Integer.parseInt(tripType);
        	Time departure_time= Time.valueOf(departureTime);
        	Time startTime= Time.valueOf(start_time);
        	
        	query="select (available.seats-taken.taken) as leftover from (select t.seats from RailwayBooking.Train t where t.trainid="+trainidInt+") as available, (select count(trainRes.reservationid) as taken from (select * from RailwayBooking.Reservation r where r.trainid="+trainidInt+") as trainRes) as taken";
        	rs= st.executeQuery(query);
        	int leftover=0;
        	if(rs.next()){
        		 leftover= rs.getInt("leftover");
        	}
        	if(leftover<1){
        		out.print("The selected train is full. Please book for another time. <br>");
        		%><a href="reservation.jsp">Click here</a> to make another reservation.<%
        	}else{
        		  query="INSERT INTO `RailwayBooking`.`Reservation` VALUES ('"+ reservationid+"', '"+classType+"', '"+departure_time+"', '"+startTime+"', '"+sqlDateMade+"', '5.0', '"+discountType+"', '"+originInt+"', '"+destInt+"', '-1', '"+user+"', '"+transitLine+"', '"+trainidInt+"', '"+totalFare+"', '"+tripTypeInt+"','"+sqlStartDate+"');";
                  st.executeUpdate(query);
                 	
             	
           	%>
           	<b>Congratulations <%=user %>!</b>
           	<br><br>
           	<%
         		out.print("Your Reservation ID is <b>" + reservationid + "</b> signed up on "+date_made+"<br><br>");
           
           	out.println("Your Origin station is: " + originName + "<br>");
             	out.println("Your Destination station is: " + destName + "<br>");
             	out.println("Your Class Type is: "+ classType+ "<br><br>");
           	
         		
             	if(!discountType.isEmpty()){
             	out.println("You are a: "+ discountType+ "<br>");
             	}
             	if(tripType.equals("1")){
             	out.println("This is a Round-Trip"+"<br><br>");
             	}
             	if(active==true){
             		out.print("Your fare pass is still active!<br>");
             	}
             	out.println("Hence your Total Fare is: " +"$" + totalFare + "<br><br>");
          	
          	
          	out.println("You will be using our Transit Line " + transitLine +" and our Train Number " +trainid);
         		out.println(" which starts running on " + start_date + " at "+start_time+".<br><br>" );
         		out.println("Your Departure Time is: " + departureTime + "<br>");
         		out.println("Your Estimated Travel Time is: " + travelTime + "<br><br>");
          	
          	out.println("Please reach out to our Representatives for any questions and concerns."+"<br>");
          			
          	rs.close();
              st.close();
              con.close();
              %>
              <br><br><br><br>
          	
          	Wrong Trip Booked? <a href="cancel.jsp">Click Here</a> to Cancel.
          	
          	<br><br>
          	<a href="reservation.jsp">Click here</a> to make another reservation.
          	<br><br>
          	<a href="all_reservations.jsp">Click here</a> to view all your past reservations.
           	<%
       		}
       		}	
        	}%>
        	
          
     	
    		
    	
     	
     
</body>
</html>