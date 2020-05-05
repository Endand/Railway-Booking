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
<title>Create a new account...</title>
</head>

<body>
    <b>Create a new account:</b>
        <br>
        <form method="POST" action="add-customer-action.jsp">
            <b>Create account information:</b>
            <table>
                <tr> 
                    <td> Username: </td><td> <input type="text" name="username"></td>
                </tr>
                <tr>
                    <td> Password: </td><td> <input type="password" name="password"></td> 
                </tr>
                <tr>
                    <td> Confirm Password: </td><td> <input type="password" name = "confirmpassword"></td>
                </tr>
            </table>
            <b>Your Personal Information:</b>
            <table>
                <tr>
                    <td> First Name: </td><td> <input type="text" name="firstname"></td><td> Last Name: </td><td> <input type="text" name="lastname"></td>
                </tr>
                <tr>
                    <td> Your Phone Number: </td><td> <input type="tel" name="phonenumber"></td>
                </tr>
                <tr>
                    <td> Your email: </td><td> <input type="email" name="email"></td>
                </tr>
                <tr>
                    <td> Address: </td><td><input type="text" name="address"></td>
                </tr>
                <tr>
                    <td> City: </td><td><input type="text" name="city"></td> <td> State: </td><td><input type="text" name="state"></td><td> Zip: </td><td> <input type="text" name="zip"></td>
                </tr>
            </table>
            
            
            <!--Button-->
            <input type="submit" value="Create!">
        </form>
        <br>
</body>