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
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

          	String start_time,trainid,trans_line_name,start_date;

            String updatestart_time_original = request.getParameter("StartTime_original");
            String updateTrianID_original = request.getParameter("TrianID_original");
            String updateTriansLineName_original = request.getParameter("TriansLineName_original");
            String updateStartDate_original = request.getParameter("StartDate_original");
            
            start_time = request.getParameter("txt_start_time");
            trainid = request.getParameter("txt_trainid");
            trans_line_name = request.getParameter("txt_trans_line_name");
            start_date = request.getParameter("txt_start_date");
      
		    //Create a SQL statement
            PreparedStatement pstmt;
		    pstmt = conn.prepareStatement("UPDATE TrainSchedule SET start_time = ? , trainid = ? , trans_line_name = ? , start_date = ? WHERE start_time = ? AND trainid = ? AND trans_line_name = ? AND start_date = ?;");
            //use ,,,and and and, instead of all 'and'
		    pstmt.setString(1,start_time);
            pstmt.setString(2,trainid);
            pstmt.setString(3,trans_line_name);
            pstmt.setString(4,start_date);
            pstmt.setString(5,updatestart_time_original);
            pstmt.setString(6,updateTrianID_original);
            pstmt.setString(7,updateTriansLineName_original);
            pstmt.setString(8,updateStartDate_original);

            
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            out.println("Sucessfully edited TrainSchedule. <a href='CustomerRepresentative-main-page.jsp'>Return to main page</a>");

        } catch(Exception e) {
            out.print(e + "<br>");
            out.println("Error: Not able to edit TrainSchedule. <a href='CustomerRepresentative-main-page.jsp'>Return to main page</a>");
        }
    %>


</body>


</html>