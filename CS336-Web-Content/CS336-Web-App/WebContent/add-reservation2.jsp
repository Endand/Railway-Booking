<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reserve a spot</title>
</head>

<body>
	<% 
	String transit_line = request.getParameter("transit_line");
    session.setAttribute("choice", transit_line);
    Object choice= session.getAttribute("choice");
    
    String fare_type = request.getParameter("fare_type");
    session.setAttribute("fare_type", fare_type);
    Object fareType= session.getAttribute("fare_type");
    
	ApplicationDB db =  new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();

	String customer_user = request.getParameter("username");
	
	//session version 
	//Object user= session.getAttribute("user");//user>>username TODOdone
	 //session.setAttribute("user", user);
	 //out.println(customer_user+"user");
	 
	 //user=username to be added
	 
	 
	 String transitLine = request.getParameter("transit_line");
	 session.setAttribute("transitLine",transitLine);

	%>
	
	<%
	//check username
	//out.println(user);//user-name didnot pass
 	String searchCommand = "SELECT username from RailwayBooking.Customer WHERE username = '" + customer_user + "';";
    ResultSet checkUsername = st.executeQuery(searchCommand);
    
    if(checkUsername.next()){
    	//session.setAttribute("user", user);
    	out.println("Valid User");
    }else{
    	out.println("No user found! Try again");
    	out.println("<a href = 'CustomerRepresentative-main-page.jsp' > Return to main page</a>");
    } 
    
	%>
	
	
	
	
    <%
    
    if(choice.equals("")) {
        out.print("Transit Line not selected.<br> Please <a href='add-reservation1.jsp'>select one</a>.");
    } else if(!fareType.equals("single")){
    	out.print("Are you sure you want to buy the "+fareType+" pass?<br><br>");
    	
    	//calculates how long the pass will last
    	java.text.DateFormat df = new java.text.SimpleDateFormat("YYYY-MM-dd");
    	df.setTimeZone(TimeZone.getTimeZone("UTC"));
     	String today= df.format(new java.util.Date());
     
		
     
     	String[] todaySplit= today.split("-");
     	String year=todaySplit[0];
     	String month=todaySplit[1];
     	String day=todaySplit[2];
     	int yearInt= Integer.parseInt(year);
     	int monthInt= Integer.parseInt(month);
     	int dayInt=Integer.parseInt(day);
     	
     	String afterWeek="";
     	String afterMonth="";
     	String expDate="";
     	
		if(fareType.equals("weekly")){
			if(monthInt==1||monthInt==3||monthInt==5||monthInt==7||monthInt==8||monthInt==10||monthInt==12){
				if(dayInt+7 >31){
					monthInt++;
					dayInt-=31;
				}else{
					dayInt+=7;
				}
			}else if(monthInt==4||monthInt==6||monthInt==9||monthInt==11){
				if(dayInt+7 >30){
					monthInt++;
					dayInt-=30;
				}else{
					dayInt+=7;
				}
			}else{//feb
				if(dayInt+7 >28){
					monthInt++;
					dayInt-=28;
				}else{
					dayInt+=7;
				}
			}
			if(monthInt>12){
				yearInt++;
				monthInt-=12;
			}
			year=Integer.toString(yearInt);
			month=Integer.toString(monthInt);
			day=Integer.toString(dayInt);
			afterWeek= year+"-"+month+"-"+day;
			expDate=afterWeek;
			
     	}
		
		if(fareType.equals("monthly")){	
			if(monthInt+1>12){
				yearInt++;
				monthInt-=12;
			}else{
				monthInt++;
			}
			year=Integer.toString(yearInt);
			month=Integer.toString(monthInt);
			day=Integer.toString(dayInt);
			afterMonth= year+"-"+month+"-"+day;
			expDate=afterMonth;
		}
		
		String query = "select t2.name, t2.stationid from (SELECT stationid FROM RailwayBooking.Stops where RailwayBooking.Stops.trans_line_name='" + choice + "') as t1, RailwayBooking.Station as t2 where t1.stationid=t2.stationid; ";
		ResultSet rs= st.executeQuery(query);
		
		//check if the user already has a pass
		query="SELECT tf.exp_date FROM RailwayBooking.TimedFare tf where tf.customer_name='"+customer_user+"' and tf.line_name='"+transitLine+"';";
		rs= st.executeQuery(query);
		
		if(rs.next()){// user already has a pass
			out.print("*WARNING* <br> You already have a pass that lasts until "+rs.getDate("exp_date")+"<br>");
			out.print("Buying a new pass will replace the old one. <br><br>");
   		}
		out.print("This pass will last until "+expDate+"<br><br>");
		session.setAttribute("expDate",expDate);
    	%>
    	 
    	Click <a href="passConfirmation.jsp"> here</a> confirm!
    	
    	
    	
    	<%
    	//for single booking
    } else {
    	%>
    	<form method="get" action="add-reservation3.jsp">
        <br/>
        
        Select Origin Station
        <select name="origin">
        <option value=""></option>
        
        
        <%
    	String query = "select t2.name, t2.stationid from (SELECT stationid FROM RailwayBooking.Stops where RailwayBooking.Stops.trans_line_name='" + choice + "') as t1, RailwayBooking.Station as t2 where t1.stationid=t2.stationid; ";
    	ResultSet rs= st.executeQuery(query);
        
        while(rs.next()){
        	%> 
        	  <option value="<%=rs.getString("stationid") %>"> <%=rs.getString("name") %> </option>
      <%   }
        %>        
        </select>
        <br/><br/><br/>
        Select Destination Station
        <select name="destination">
        <option value=""></option>
        <%
        rs.beforeFirst();
        while(rs.next()){
        	%> 
        	  <option value="<%=rs.getString("stationid") %>"> <%=rs.getString("name") %> </option>
      <%   }
        %>        
        </select>
        <br/><br/><br/>
        
        Select Train Schedule
        <select name="schedule">
        <%
         query = "select * from RailwayBooking.TrainSchedule ts where ts.trans_line_name='"+ transitLine+ "'";
    	 rs= st.executeQuery(query);
        while(rs.next()){
        	%> 
        	  <option value="<%=rs.getString("start_date") %> <%=rs.getString("start_time") %> <%=rs.getString("trainid") %>"> <%=rs.getString("start_date") %> <%=rs.getString("start_time") %> </option>
      <%   }
        %>        
        </select>
        <br/><br/><br/>
        
        Select Class
        <select name="class">
        <option value="economy">economy</option>
        <option value="business">business</option>
        <option value="first">first</option>
        </select>
        <br/><br/><br/>
        If you are one of following, you are eligible for a discount:
         <select name="discount">
         <option value=""></option>
        <option value="child">child</option>
        <option value="senior">senior</option>
        <option value="disabled">disabled</option>
        </select>
        <br/><br/><br/>
        Is this a round trip?
        <select name="tripType">
        <option value="0">No</option>
        <option value="1">Yes</option>
        </select>
        <br/><br/><br/>
          <!--Button-->  
	<input type="hidden" name="customerName" value="<%=customer_user%>">
	
	
         <input type="submit" value="submit">
    	</form>
        <%}
    
        st.close();
        con.close();
        checkUsername.close();
        
        %>
	

</body>

</html>