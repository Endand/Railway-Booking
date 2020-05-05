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
<title>Welcome to Choo-Choo Land</title>
</head>

<body>

    <header>Welcome to Choo-Choo Train Scheduler.</header>

    Please <a href='login.jsp'>log in </a> to make a reservation.
    <br>
    Don't have an account? <a href='createaccount.jsp'>Create one now.</a>
    <br>
    <a href='train-schedule-search.jsp'>Browse for train schedules...</a>
    

</body>

</html>