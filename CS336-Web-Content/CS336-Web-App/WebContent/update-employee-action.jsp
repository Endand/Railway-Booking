<!-- AUTHOR: Paul John -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Updating Employee....</title>
</head>
<body>
    <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

          
            String ssn,username,password,firstName,lastName,role;
            
            String updateSSN = request.getParameter("ssn_original");
            
            ssn = request.getParameter("txt_ssn");
            username = request.getParameter("txt_user_name");
            password = request.getParameter("txt_password");
            firstName = request.getParameter("txt_first_name");
            lastName = request.getParameter("txt_last_name");
            role = request.getParameter("txt_role");
            
		    //Create a SQL statement
            PreparedStatement pstmt;
		    pstmt = conn.prepareStatement("UPDATE Employee SET ssn = ?, username = ?, password = ?, name_first = ?, name_last = ?, role = ? WHERE ssn = ?;");
		    pstmt.setString(1,ssn);
		    pstmt.setString(2,username);
            pstmt.setString(3,password);
            pstmt.setString(4,firstName);
            pstmt.setString(5,lastName);
            pstmt.setString(6,role);
            pstmt.setString(7,updateSSN);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            out.println("Sucessfully edited employee. <a href='admin-main-page.jsp'>Return to main page</a>");

        } catch(Exception e) {
            out.print(e + "<br>");
            out.println("Error: Not able to edit employee. <a href='admin-main-page.jsp'>Return to main page</a>");
        }
    %>


</body>


</html>