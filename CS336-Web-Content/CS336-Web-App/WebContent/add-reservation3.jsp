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
    	
		
		String origin = request.getParameter("origin");
       	String dest = request.getParameter("destination");
       	String trainSchedule = request.getParameter("schedule");
       	String classType = request.getParameter("class");
       	String discountType = request.getParameter("discount");
       	String tripType = request.getParameter("tripType");
     	//String user= (String) session.getAttribute("user");//before this verion
     	//String user= request.getParameter("username");//TODO check if I passed name from previous page successfully
     	//String user= request.getParameter("user");//try this
     	String transitLine= (String) session.getAttribute("transitLine");
     	
     	//String user = session.setAttribute("user", user);
     	//String user = session.getAttribute("user");
     	//String user = (String) session.getAttribute("user");
     	String user_customerName = request.getParameter("customerName");
     			//out.println(user_customerName+"user");
     	
     			
     	if(origin.isEmpty()||dest.isEmpty()){
     		out.print("Please select both origin and destination stations!<br><br>");
     		%> 
     		Click <a href="add-reservation2.jsp"> here</a> to make a reservation!
     		
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
     	
     	Object testCPname = session.getAttribute("user");
     	//out.println(testCPname + "CPname");
     	
     	
     	query="SELECT e.ssn FROM RailwayBooking.Employee e WHERE e.username ='"+testCPname+"';";
     	rs=st.executeQuery(query);
     	int repssn=0;
     	if(rs.next()){
     		repssn= rs.getInt("ssn");
     	}
     	
     	
     	//gets start_time and start_date and trainid
     	String[] dateTime= trainSchedule.split(" ");
     	String start_date=dateTime[0];
     	String start_time=dateTime[1];
     	String trainid=dateTime[2];
     	
     	//gets date_made
     	java.text.DateFormat df = new java.text.SimpleDateFormat("YYYY-MM-dd");
     	String date_made= df.format(new java.util.Date());
     	
     	//gets departure time
     	    query="select sec_to_time(sum(time_to_sec(stop.travelTime))) as totalTime from (select tl.`travel time` as travelTime, tl.stopid from (SELECT * FROM RailwayBooking.Stops s where s.trans_line_name='"+transitLine+"' order by stopid)as tl where tl.stopid<='"+dest+"') as stop";
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
     		
     		query="SELECT tf.exp_date FROM RailwayBooking.TimedFare tf where tf.customer_name='"+user_customerName+"' and tf.line_name='"+transitLine+"';";
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
			out.print("Click <a href='add-reservation2.jsp'>here</a> to return to the reservation screen.");
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
        	
            query="INSERT INTO `RailwayBooking`.`Reservation` VALUES ('"+ reservationid+"', '"+classType+"', '"+departure_time+"', '"+startTime+"', '"+sqlDateMade+"', '5.0', '"+discountType+"', '"+originInt+"', '"+destInt+"', '"+repssn+"', '"+user_customerName+"', '"+transitLine+"', '"+trainidInt+"', '"+totalFare+"', '"+tripTypeInt+"','"+sqlStartDate+"');";
            st.executeUpdate(query);
           	
       	}
     	%>
     	<b>Congratulations!</b>
     	<br><br>
     	<%
   		out.print("The Reservation ID is <b>" + reservationid + "</b> signed up on "+date_made+"<br><br>");
     
     	out.println("The Origin station is: " + originName + "<br>");
       	out.println("The Destination station is: " + destName + "<br>");
       	out.println("The Class Type is: "+ classType+ "<br><br>");
     	
   		
       	if(!discountType.isEmpty()){
       	out.println("The type is: "+ discountType+ "<br>");
       	}
       	if(tripType.equals("1")){
       	out.println("This is a Round-Trip"+"<br><br>");
       	}
       	if(active==true){
       		out.print("The fare pass is still active!<br>");
       	}
       	out.println("Hence the Total Fare is: " +"$" + totalFare + "<br><br>");
    	
    	
    	out.println("Customer will be using our Transit Line " + transitLine +" and the Train Number " +trainid);
   		out.println(" which starts running on " + start_date + " at "+start_time+".<br><br>" );
   		
   		out.println("The Estimated Travel Time is: " + travelTime + "<br>");
    	out.println("The Estimated Arrival Time is: " + departureTime + "<br>");
    			
    	rs.close();
        st.close();
        con.close();
        %>
        <br><br><br><br>
    	
    	
    	<br><br>
    	<a href="CustomerRepresentative-main-page.jsp">Click here</a> back to Customer Representative Home Page.

     	<% }%>	
     	
    		
    	
     	
     
</body>
</html>