<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delay Alert Message</title>
</head>

<body>
	<%
	//set up SQL statement
    ApplicationDB db =  new ApplicationDB();
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    
    //get parameters from previous page
    String everything = request.getParameter("selection");
    
    String[] arr = everything.split(",", 4);
    
    String trans_line_name = arr[0];
    String trainid = arr[1];
    String start_date = arr[2];
    String start_time = arr[3];
    
  	//Create a SQL statement. Find people on a particular train schedule (train#, time, date, trans_line_name)
    PreparedStatement pstmt;
    pstmt = con.prepareStatement("SELECT DISTINCT passenger_username FROM RailwayBooking.Reservation r WHERE r.trainid = ? AND r.trans_line_name = ? AND r.start_date = ? AND r.start_time = ?;");
    pstmt.setString(1, trainid + "");//int
	pstmt.setString(2, trans_line_name);//string
	pstmt.setString(3, start_date);//string
	pstmt.setString(4, start_time);//string
    ResultSet customer_set = pstmt.executeQuery();
	%>
	
	<!-- Now need to send a message to each passenger_usename! Will make a new message! -->
	<!-- Values (msgid = query, is_reply = -1, has_reply = -1, cust_asks = null, empl_ans = -1, msg = alertmsg, timedate. title = getTitle) -->
	<%
	
   	
   	int is_reply = -1;
   	int has_reply = -1;
   	String cust_asks = null;
   	int empl_ans = -2;
   	String title = "Alert! Your reservation has been delayed!";
   	
   	//gets the current date and time
    Calendar c = Calendar.getInstance();
    String time = (c.get(Calendar.HOUR_OF_DAY)) + ":" + (c.get(Calendar.MINUTE)) + ":" + (c.get(Calendar.SECOND));
    String date =  (c.get(Calendar.YEAR)) + "-" + (c.get(Calendar.MONTH) + 1) + "-" + (c.get(Calendar.DAY_OF_MONTH));
    
    //generates message
    String msg = "Your reservation for " + trans_line_name + " on train " + trainid + 
    		" at " + start_date + ", " + start_time + 
    		" has been delayed! Please check the reservation for more details.";
    
    %>
		
	<%
	while(customer_set.next())
	{
		//gets msgid
	   	String query ="select if(max(m.msgid) is null, 1, max(m.msgid) + 1) as nextMsgid from RailwayBooking.Messages m";
	   	ResultSet rs = st.executeQuery(query);
	   	int msgid = -1;
	   	rs.next();
	   	msgid = rs.getInt("nextMsgid");
		
		String cust = customer_set.getString("passenger_username");
		
		pstmt = con.prepareStatement("INSERT INTO Messages (msgid, date, time, msg, cust_asks, empl_ans, is_reply, has_reply, title)\n"
				+ "Values (?, ?, ?, ?, ?, ?, ?, ?, ?);");
		pstmt.setString(1, msgid + "");//int
		pstmt.setString(2, date);//string
		pstmt.setString(3, time);//string
		pstmt.setString(4, msg);//string
		pstmt.setString(5, cust);//string
		pstmt.setString(6, empl_ans + "");//int
		pstmt.setString(7, is_reply + "");//int
		pstmt.setString(8, has_reply + "");//int
		pstmt.setString(9, title);//string
		pstmt.executeUpdate();
	}
	
	//close the connections
	pstmt.close();
    con.close();
    
    //send the person back to the main page
    out.println("Successfully sent the alert message. <a href='CustomerRepresentative-main-page.jsp'>Return to main page</a>");
	
	%>
</body>

</html>