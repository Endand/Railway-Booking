<!-- AUTHOR: Paul John -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
if(session.getAttribute("user") != null && request.getParameter("deleteCustomer")!=null) {
	try
	{ 
	 //Get the database connection
	 String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	 Class.forName("com.mysql.jdbc.Driver");
	 Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // **** 

	 String username=request.getParameter("deleteCustomer");
	  
	 PreparedStatement pstmt=null; //create statement
	  
	 pstmt=conn.prepareStatement("DELETE FROM Customer WHERE username = ?"); //sql delete query
	 pstmt.setString(1,username);
	 pstmt.executeUpdate(); //execute query
	  
	 pstmt.close();
	 conn.close(); //close connection
	}
	catch(Exception e)
	{
	 out.println(e);
	}
} else if(session.getAttribute("user") != null && request.getParameter("deleteEmployee")!=null) {
	try
	{ 
	 //Get the database connection
	 String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	 Class.forName("com.mysql.jdbc.Driver");
	 Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // **** 

	 String ssn=request.getParameter("deleteEmployee");
	  
	 PreparedStatement pstmt=null; //create statement
	  
	 pstmt=conn.prepareStatement("DELETE FROM Employee WHERE ssn = ?"); //sql delete query
	 pstmt.setString(1,ssn);
	 pstmt.executeUpdate(); //execute query
	  
	 pstmt.close();
	 conn.close(); //close connection
	}
	catch(Exception e)
	{
	 out.println(e);
	}
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
</head>

<body>

		<%
	    if(session.getAttribute("user") == null) {
	        out.print("You are not logged in.<br> Please <a href='admin-login.jsp'>log in</a>.");
	        return;
	    } else {
	        out.print("Welcome, " + session.getAttribute("user") + "!<br>");
	        out.print("<a href='admin-logout.jsp'>Log out</a>");
	    }
    	%>
    	
    	<br>
    	<br>
    	<form method="POST" action="add-customer.jsp">
            <!--Button-->
            <input type="submit" value="Add Customer">
        </form>
    	<br>
    	
    	<table>
  
	   <tr>
	    <th>user name</th>
	    <th>password</th>
	    <th>phone</th>
	    <th>email</th>
	    <th>first name</th>
	    <th>last name</th>
	    <th>city</th>
	    <th>state</th>
	    <th>zip code</th>
	    <th>street</th>
	   </tr>
    	
	    <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

		    //Create a SQL statement
            Statement stmt = conn.createStatement();

            // Select customers from DB
            String searchCommand = "SELECT * FROM Customer;";
            ResultSet rs = stmt.executeQuery(searchCommand);
            
            while(rs.next()) {
            %>
            <tr>
		     <td> <%=rs.getString("username")%> </td>
		     <td> <%=rs.getString("password")%> </td>
		     <td> <%=rs.getString("phone")%> </td>
		     <td> <%=rs.getString("email")%> </td>
		     <td> <%=rs.getString("name_first")%> </td>
		     <td> <%=rs.getString("name_last")%> </td>
		     <td> <%=rs.getString("address_city")%> </td>
		     <td> <%=rs.getString("address_state")%> </td>
		     <td> <%=rs.getString("address_zip")%> </td>
		     <td> <%=rs.getString("address_street")%> </td>
		     <td>
		     	<form method="POST" action="update-customer.jsp">
		            <!--Button-->
		            <input type="submit" value="Edit Customer">
		            <input type="hidden" name="edit" value="<%=rs.getString("username")%>">
		        </form> 
			 </td>
		     <td>
		     	<form method="POST" action="admin-main-page.jsp">
		            <!--Button-->
		            <input type="submit" value="Delete Customer">
		            <input type="hidden" name="deleteCustomer" value="<%=rs.getString("username")%>">
		        </form> 
		     </td>
		     
		    </tr>
            <%   
            }
            
            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e) {
            out.print(e + "<br>");
            out.println("Error: Something went wrong");
        }
    	%>
    	
		</table>
		
		<br>
		<br>
		<form method="POST" action="add-employee.jsp">
            <!--Button-->
            <input type="submit" value="Add Employee">
        </form>
    	<br>
		
	   <table>
  
	   <tr>
	    <th>ssn</th>
	    <th>username</th>
	    <th>password</th>
	    <th>first name</th>
	    <th>last name</th>
	    <th>role</th>
	   </tr>
	   
	   <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

		    //Create a SQL statement
            Statement stmt = conn.createStatement();

            // Select customers from DB
            String searchCommand = "SELECT * FROM Employee;";
            ResultSet rs = stmt.executeQuery(searchCommand);
            
            while(rs.next()) {
            %>
            <tr>
		     <td> <%=rs.getString("ssn")%> </td>
		     <td> <%=rs.getString("username")%> </td>
		     <td> <%=rs.getString("password")%> </td>
		     <td> <%=rs.getString("name_first")%> </td>
		     <td> <%=rs.getString("name_last")%> </td>
		     <td> <%=rs.getString("role")%> </td>
		     <td>
		     	<form method="POST" action="update-employee.jsp">
		            <!--Button-->
		            <input type="submit" value="Edit Employee">
		            <input type="hidden" name="edit" value="<%=rs.getString("ssn")%>">
		        </form>
		     </td>
		     <td>
		     	<form method="POST" action="admin-main-page.jsp">
		            <!--Button-->
		            <input type="submit" value="Delete Employee">
		            <input type="hidden" name="deleteEmployee" value="<%=rs.getString("ssn")%>">
		        </form> 
		     </td>
		     
		    </tr>
            <%   
            }
            
            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e) {
            out.print(e + "<br>");
            out.println("Error: Something went wrong");
        }
    	%>
	   
	   </table>
	   
	   <br>
	   
	   <form method="POST" action="view-monthly-sales.jsp">
		<label>Monthly Sales Report:</label>
			<select name="month">
		        <option value="January">January</option>
		        <option value="February">February</option>
		        <option value="March">March</option>
		        <option value="April">April</option>
		        <option value="May">May</option>
		        <option value="June">June</option>
		        <option value="July">July</option>
		        <option value="August">August</option>
		        <option value="September">September</option>
		        <option value="October">October</option>
		        <option value="November">November</option>
		        <option value="December">December</option>
	        </select>
			
			<!--Button-->
			<input type="submit" value="See Sales Report">
		</form>
	   
	   <br>
	 	
    	Reservations:
    	<br>
    	<br>
		<form method="POST" action="view-reservations.jsp">
		    <!--Button-->
		    <input type="submit" value="See All Reservations">
		</form>
		<br>
		
		<form method="POST" action="view-customer-reservations.jsp">
		Reservations by Customer: 
			<select name="customers">
			<% 
	        try {
	            //Get the database connection
	            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****
	
			    //Create a SQL statement
	            Statement stmt = conn.createStatement();
	
	            // Select customers from DB
	            String searchCommand = "SELECT username FROM Customer;";
	            ResultSet rs = stmt.executeQuery(searchCommand);
	            
	            while(rs.next()) {
	        %>
		        <option value="<%=rs.getString("username")%>"><%=rs.getString("username")%></option>
		    <%   
	            }
	            
	            rs.close();
	            stmt.close();
	            conn.close();
	
	        } catch(Exception e) {
	            out.print(e + "<br>");
	            out.println("Error: Something went wrong");
	        }
	    	%>
	        </select>
			
			<!--Button-->
			<input type="submit" value="Submit">
		</form>
		
		<br>
	   	Revenue Listing:
	   	<form method="POST" action="view-revenue-listing.jsp">
	   	<p>Please select filter:<br>
	   	   <input type='radio' name='filter-option' value='transit-line' checked> Transit Line<br>
		   <input type='radio' name='filter-option' value='destination-city'> Destination City<br>
		   <input type='radio' name='filter-option' value='customer-name'> Customer Name<br>
		   <input type="submit" value="Submit">
		</form>
		</p>

		<br>
		Best Customer: 
		<% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

		    //Create a SQL statement
            Statement stmt = conn.createStatement();

            // Select customers from DB
            String searchCommand = "SELECT passenger_username FROM Reservation GROUP BY passenger_username ORDER BY SUM(booking_fee+total_fare) DESC LIMIT 1;";
            ResultSet rs = stmt.executeQuery(searchCommand);
            rs.next();
		%>
		<%=rs.getString("passenger_username")%>
		<%		        
	        rs.close();
	        stmt.close();
	        conn.close();
	
	    } catch(Exception e) {
	        out.print(e + "<br>");
	        out.println("Error: Something went wrong"+e);
	    }
        %>
        <br>
        <br>
        Most Active Transit Lines:
        <br>
        <% 
        try {
            //Get the database connection
            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****

		    //Create a SQL statement
            Statement stmt = conn.createStatement();

            // Select customers from DB
            String searchCommand = "SELECT trans_line_name FROM Reservation GROUP BY trans_line_name ORDER BY SUM(booking_fee+total_fare) DESC LIMIT 5;";
            ResultSet rs = stmt.executeQuery(searchCommand);
            int i = 1;
            while(rs.next()) {
		%>
		<%=i+". "+rs.getString("trans_line_name")%>
		<br>
		<%
			i++;
            }
	        rs.close();
	        stmt.close();
	        conn.close();
	
	    } catch(Exception e) {
	        out.print(e + "<br>");
	        out.println("Error: Something went wrong"+e);
	    }
        %>
        
</body>

</html>