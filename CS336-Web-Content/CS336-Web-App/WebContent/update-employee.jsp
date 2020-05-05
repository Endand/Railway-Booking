<!-- AUTHOR: Paul John -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Employee</title>
</head>
<body>
	<div class="main"> 
	<form method="post" action="update-employee-action.jsp">
	 
	  <center>
	   <h1>Update Record</h1>
	  </center>
	  
	  <table> 
	      <% 
	        try {
	            //Get the database connection
	            String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****
	
			    //Create a SQL statement
	            Statement stmt = conn.createStatement();
	            
	            if(request.getParameter("edit")!=null) 
	            {
	             String ssn=request.getParameter("edit");
	             String username,password,firstName,lastName,role;
	            
	       
	            String searchCommand = "SELECT * FROM Employee WHERE ssn ='" + ssn + "';";
	            ResultSet editItems = stmt.executeQuery(searchCommand);
	            
	            
	            while(editItems.next()) {
	            ssn = editItems.getString("ssn");	
	            username = editItems.getString("username");
	            password = editItems.getString("password");
	            firstName = editItems.getString("name_first");
	            lastName = editItems.getString("name_last");
	            role = editItems.getString("role");
	            %>
	            <tr>
				    <td>ssn</td>
				    <td><input type="text" name="txt_ssn" value="<%=ssn %>"></td>
			    </tr>
	            <tr>
				    <td>user name</td>
				    <td><input type="text" name="txt_user_name" value="<%=username %>"></td>
			    </tr>
			    <tr>
				    <td>password</td>
				    <td><input type="text" name="txt_password" value="<%=password %>"></td>
			    </tr>	    
	            <tr>
				    <td>first name</td>
				    <td><input type="text" name="txt_first_name" value="<%=firstName %>"></td>
			    </tr>
			    <tr>
				    <td>last name</td>
				    <td><input type="text" name="txt_last_name" value="<%=lastName %>"></td>
			    </tr>	    
			    <tr>
				    <td>role</td>
				    <td><input type="text" name="txt_role" value="<%=role %>"></td>
			    </tr>
				<tr>
				    <td><input type="submit" name="btn_update" value="Update"></td> 
			    </tr>
			    
			    <input type="hidden" name="ssn_original" value="<%=ssn %>">
	            <%
	            } 
	            
	            editItems.close();
	            stmt.close();
	            conn.close();
	            
	            }
	        } catch(Exception e) {
	            out.print(e + "<br>");
	            out.print("Login failed. Click <a href='login.jsp'>here</a> to return to the login screen.");
	        }
	    %>
	  </table> 
	  
	  <center>
	    <h1><a href="admin-main-page.jsp">Back</a></h1>
	  </center>
	  
	 </form>
	</div>
</body>
</html>