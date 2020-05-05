<!-- AUTHOR: Paul John -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Creating account...</title>
</head>
<body>
    <% 
    try {
        // first check if username is present in the database already
        String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl");

        Statement stmt = conn.createStatement();

        // parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("confirmpassword");
        String fname = request.getParameter("firstname");
        String lname = request.getParameter("lastname");
        String pnumber = request.getParameter("phonenumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zip = request.getParameter("zip");

        // check if username is present
        String usernameQuery = "SELECT username from Customer WHERE username='" + username + "'";

        ResultSet checkUsername = stmt.executeQuery(usernameQuery);

        if(checkUsername.next()) {
            out.println("The requested username already exists.");
            out.println("<br> <a href='add-customer-action.jsp'>Return to customer account creation page</a>");
        	out.println("<br> <a href='admin-main-page.jsp'>Return to main page</a>");
        } else if(!password.equals(passwordConfirm)) {
        	out.println("The passwords are not equal. Check and try again.");
        	out.println("<br> <a href='add-customer-action.jsp'>Return to customer account creation page</a>");
        	out.println("<br> <a href='admin-main-page.jsp'>Return to main page</a>");
        } else if(username.equals("") || password.equals("") || passwordConfirm.equals("") || 
        		fname.equals("") || lname.equals("") || pnumber.equals("") || address.equals("") ||
        		city.equals("") || state.equals("") || zip.equals("")) {
        	out.println("Please do not leave any fields blank.");
        	out.println("<br> <a href='add-customer-action.jsp'>Return to customer account creation page</a>");
        	out.println("<br> <a href='admin-main-page.jsp'>Return to main page</a>");
        } else {
        	String insertQuery = "INSERT INTO Customer VALUES('" + username + "', '" + password + "', '" + pnumber + "', '";
            insertQuery += email + "', '" + fname + "', '" + lname + "', '" + city + "', '" + state + "', '" + zip + "', '" +  address + "')";

            out.print(insertQuery + "<br>");

            stmt.executeUpdate(insertQuery);
            response.sendRedirect("admin-main-page.jsp");
        }

        checkUsername.close();
        stmt.close();
        conn.close();

    } catch(NullPointerException e) {
    	out.print("Invalid session. How'd you get here, anyway?<br>");
    	out.println("<br> <a href='admin-login.jsp'>Return to login page</a>");
    } catch(Exception e) {
        out.print("Account creation failed.<br>");
        out.print(e);
    } 
        
    %>
</body>
</html>