<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reserve a spot</title>
</head>

<body>
	<% 
	ApplicationDB db =  new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String query = "Select * FROM TransitLine";
	ResultSet rs= st.executeQuery(query);
	%>
	
    <%
    Object user= session.getAttribute("user");
    session.setAttribute("user", user);
    if(session.getAttribute("user") == null) {
        out.print("You are not logged in.<br> Please <a href='CustomerRepresentative-Login.jsp'>log in</a>.");
    } else {
    	%>
    	<form method="get" action="add-reservation2.jsp">
        <br/>
        
        <tr> 
            <td> Username: </td><td> <input type="text" name="username"></td>
        </tr>
        
         Select Transit Line
        <select name="transit_line">
        <option value=""></option>
        <%
        out.println(user+"user");
   	    while(rs.next()){
        	%> 
        	  <option value="<%=rs.getString("name") %>"> <%=rs.getString("name") %> </option>
        	  
      <%   }
        %>
        </select>
        Select Fare Type
        <select name="fare_type">
        <option value="single">Single</option>
        <option value="weekly">Weekly</option>
        <option value="monthly">Monthly</option>
        </select>
        <br/><br/><br/>
        <% 
        rs.close();
        st.close();
        con.close();
        %>        
         
          <!--Button-->  
			
         <input type="submit" value="submit">
    	</form>
        <%} %>
	

</body>

</html>