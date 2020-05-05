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
        String ssn = request.getParameter("ssn");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("confirmpassword");
        String fname = request.getParameter("firstname");
        String lname = request.getParameter("lastname");
        String role = request.getParameter("role");

        // check if username is present
        String usernameQuery = "SELECT ssn from Employee WHERE ssn='" + ssn + "'";

        ResultSet checkSSN = stmt.executeQuery(usernameQuery);

        if(checkSSN.next()) {
            out.println("The requested ssn already exists.");
            out.println("<br> <a href='add-employee-action.jsp'>Return to employee account creation page</a>");
        	out.println("<br> <a href='admin-main-page.jsp'>Return to main page</a>");
        } else if(!password.equals(passwordConfirm)) {
        	out.println("The passwords are not equal. Check and try again.");
        	out.println("<br> <a href='add-employee-action.jsp'>Return to employee account creation page</a>");
        	out.println("<br> <a href='admin-main-page.jsp'>Return to main page</a>");
        } else if(username.equals("") || password.equals("") || passwordConfirm.equals("") || 
        		fname.equals("") || lname.equals("") || ssn.equals("") || role.equals("")) {
        	out.println("Please do not leave any fields blank.");
        	out.println("<br> <a href='add-employee-action.jsp'>Return to employee account creation page</a>");
        	out.println("<br> <a href='admin-main-page.jsp'>Return to main page</a>");
        } else {
        	String insertQuery = "INSERT INTO Employee VALUES('" + ssn + "', '" + username + "', '" + password + "', '";
            insertQuery += fname + "', '" + lname + "', '" + role + "')";

            out.print(insertQuery + "<br>");

            stmt.executeUpdate(insertQuery);
            response.sendRedirect("admin-main-page.jsp");
        }

        checkSSN.close();
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