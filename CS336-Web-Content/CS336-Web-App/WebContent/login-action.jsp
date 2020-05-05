<!-- AUTHOR: Sangjun Ko -->

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
            ApplicationDB db = new ApplicationDB();
            Connection conn = db.getConnection();

		    //Create a SQL statement
            Statement stmt = conn.createStatement();
            
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
           

            // check if username is present
            String searchCommand = "SELECT username, password from Customer WHERE username ='" + username + "' and password = '" + password + "';";
            //out.println(searchCommand);
            ResultSet checkUsername = stmt.executeQuery(searchCommand);
            
            
            if(checkUsername.next()) {
                session.setAttribute("user", username);
                out.println("Welcome! " + username);
                out.println("<a href = 'logout.jsp' > Log out</a>");
                response.sendRedirect("login-success.jsp");
            } else {
                out.println("Invalid password. <a href='login.jsp'>Return to login screen</a>");
            }
            checkUsername.close();
            stmt.close();
            conn.close();


            

        } catch(Exception e) {
            out.print(e + "<br>");
            out.print("Login failed. Click <a href='login.jsp'>here</a> to return to the login screen.");
        }
    %>


</body>


</html>