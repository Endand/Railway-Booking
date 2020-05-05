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
<title>Updating Customer....</title>
</head>
<body>
    <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

          
            String username,password,phone,email,firstName,lastName,city,state,zipCode,street;
            
            String updateUsername = request.getParameter("user_name_original");
            
            username = request.getParameter("txt_user_name");
            password = request.getParameter("txt_password");
            phone = request.getParameter("txt_phone");
            email = request.getParameter("txt_email");
            firstName = request.getParameter("txt_first_name");
            lastName = request.getParameter("txt_last_name");
            city = request.getParameter("txt_city");
            state = request.getParameter("txt_state");
            zipCode = request.getParameter("txt_zip_code");
            street = request.getParameter("txt_street");
            
		    //Create a SQL statement
            PreparedStatement pstmt;
		    pstmt = conn.prepareStatement("UPDATE Customer SET username = ?, password = ?, phone = ?, email = ?, name_first = ?, name_last = ?, address_city = ?, address_state = ?, address_zip = ?, address_street = ? WHERE username = ?;");
            pstmt.setString(1,username);
            pstmt.setString(2,password);
            pstmt.setString(3,phone);
            pstmt.setString(4,email);
            pstmt.setString(5,firstName);
            pstmt.setString(6,lastName);
            pstmt.setString(7,city);
            pstmt.setString(8,state);
            pstmt.setString(9,zipCode);
            pstmt.setString(10,street);
            pstmt.setString(11,updateUsername);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            out.println("Sucessfully edited customer. <a href='admin-main-page.jsp'>Return to main page</a>");

        } catch(Exception e) {
            out.print(e + "<br>");
            out.println("Error: Not able to edit customer. <a href='admin-main-page.jsp'>Return to main page</a>");
        }
    %>


</body>


</html>