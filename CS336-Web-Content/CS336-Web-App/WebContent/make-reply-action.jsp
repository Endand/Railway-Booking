<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging in....</title>
</head>
<body>
    <% 
        //try {
        	//Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

         	//Create a SQL statement
            Statement stmt = conn.createStatement();
            
            //gets the message and title from the previous page
            String msg = request.getParameter("msg");;
            String title = "RE:" + request.getParameter("title");;
            
            //gets the current date and time
            Calendar c = Calendar.getInstance();
            String time = (c.get(Calendar.HOUR_OF_DAY)) + ":" + (c.get(Calendar.MINUTE)) + ":" + (c.get(Calendar.SECOND));
            String date =  (c.get(Calendar.YEAR)) + "-" + (c.get(Calendar.MONTH) + 1) + "-" + (c.get(Calendar.DAY_OF_MONTH));
            String empl_ans, is_reply, has_reply, cust_asks;
            
            //gets msgid
         	String query ="select if(max(m.msgid) is null, 1, max(m.msgid) + 1) as nextMsgid from RailwayBooking.Messages m";
         	ResultSet rs = stmt.executeQuery(query);
         	int msgid = -1;
         	if (rs.next()) {
         		msgid = rs.getInt("nextMsgid");
         	}
            
         	//gets remaining data from request
            cust_asks = request.getParameter("cust_asks");
            empl_ans = request.getParameter("empl_ans");
            is_reply = request.getParameter("is_reply");
            has_reply = request.getParameter("has_reply");
            
            
		    //Create a SQL statement
            PreparedStatement pstmt;
		    pstmt = conn.prepareStatement("INSERT INTO Messages (msgid, date, time, msg, cust_asks, empl_ans, is_reply, has_reply, title)\n"
		    			+ "Values (?, ?, ?, ?, ?, ?, ?, ?, ?);");
		    pstmt.setString(1, msgid + "");//int
		    pstmt.setString(2, date);//string
            pstmt.setString(3, time);//string
            pstmt.setString(4, msg);//string
            pstmt.setString(5, cust_asks);//string
            pstmt.setString(6, empl_ans);//int
            pstmt.setString(7, is_reply);//int
            pstmt.setString(8, has_reply);//int
            pstmt.setString(9, title);//string
            pstmt.executeUpdate();
            
            //update previous msg
            pstmt = conn.prepareStatement("UPDATE Messages SET has_reply = ? WHERE msgid = ?;");
            pstmt.setString(1, msgid + "");//int
		    pstmt.setString(2, is_reply);//string
		    pstmt.executeUpdate();
            
		    pstmt.close();
            conn.close();
		    
            String temp = (String)session.getAttribute("customer?");
            if(temp != null) {
            	out.println("Sucessfully sent a message. <a href='login-success.jsp'>Return to main page</a>");
            } else {
            	//this is for customer rep. 
            	out.println("Sucessfully sent a message. <a href='CustomerRepresentative-main-page.jsp'>Return to main page</a>");
            }
            

    %>


</body>


</html>