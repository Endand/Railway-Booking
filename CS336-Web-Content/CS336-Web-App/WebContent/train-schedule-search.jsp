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
<title>Search Train Schedule</title>
</head>

<!-- Search bar for trains. -->

<body>
    
    <form method="GET" action=train-schedule-search-action.jsp>
       <b>Search for train schedules:<br> </b> Search by <select name="searchby">
           <option value="origin">origin</option>
           <option value="destination">destination</option>
           <option value="start_date">date</option>
       </select>

        Sort by <select name="sortby"> 
           <option value="arrivaltime">arrival time</option>
           <option value="depttime">departure time</option>
           <option value="origin">origin</option>
           <option value="destination">destination</option>
           <option value="fare">fare</option>
       </select>
       <br>
       <input type="search" name="searchquery" size="100"><input type="submit" value="Search">
       <br>

    </form>
    <a href="index.jsp">Return to main page</a>
   
</body>
</html>