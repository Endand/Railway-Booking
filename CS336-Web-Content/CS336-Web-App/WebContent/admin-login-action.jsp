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
<title>Logging in....</title>
</head>
<body>
    <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

		    //Create a SQL statement
            Statement stmt = conn.createStatement();
            
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
           

            // check if username is present
            String searchCommand = "SELECT username, password from Employee WHERE username ='" + username + "' and password = '" + password + "' and role = 'Admin';";
            //out.println(searchCommand);
            ResultSet checkUsername = stmt.executeQuery(searchCommand);
            
            
            if(checkUsername.next()) {
                session.setAttribute("user", username);
                out.println("Welcome! " + username);
                out.println("<a href = 'logout.jsp' > Log out</a>");
                response.sendRedirect("admin-main-page.jsp");
            } else {
                out.println("Invalid password. <a href='admin-login.jsp'>Return to login screen</a>");
            }
            checkUsername.close();
            stmt.close();
            conn.close();


            

        } catch(Exception e) {
            out.print(e + "<br>");
            out.print("Login failed. Click <a href='admin-login.jsp'>here</a> to return to the login screen.");
        }
    %>


</body>


</html>