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
<title>Log-in</title>
</head>

<!--Log-in form-->

<body>
    
        Log in:
        <br>
        <form method="POST" action="login-action.jsp">
            <table>
                <tr> 
                    <td> Username: </td><td> <input type="text" name="username"></td>
                </tr>
                <tr>
                    <td> Password: </td><td> <input type="password" name="password"></td> 
                </tr>
            </table>
            <!--Button-->
            <input type="submit" value="Log-in">
        </form>
        <br>
        Don't have a username? Click <a href="createaccount.jsp"> here</a> to make one!
        <br>
        <a href="admin-login.jsp">Admin?</a>
        <br>
        <a href="CustomerRepresentative-Login.jsp">Customer Representative?</a>
   
</body>
</html>
