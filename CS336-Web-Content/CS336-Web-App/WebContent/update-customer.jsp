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
<title>Update Customer</title>
</head>
<body>
	<div class="main"> 
	<form method="post" action="update-customer-action.jsp">
	 
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
	             String username=request.getParameter("edit");
	             String password,phone,email,firstName,lastName,city,state,zipCode,street;
	            
	       
	            String searchCommand = "SELECT * FROM Customer WHERE username ='" + username + "';";
	            ResultSet editItems = stmt.executeQuery(searchCommand);
	            
	            
	            while(editItems.next()) {
	            password = editItems.getString("password");
	            phone = editItems.getString("phone");
	            email = editItems.getString("email");
	            firstName = editItems.getString("name_first");
	            lastName = editItems.getString("name_last");
	            city = editItems.getString("address_city");
	            state = editItems.getString("address_state");
	            zipCode = editItems.getString("address_zip");
	            street = editItems.getString("address_street");
	            %>
	            <tr>
				    <td>user name</td>
				    <td><input type="text" name="txt_user_name" value="<%=username %>"></td>
			    </tr>
			    <tr>
				    <td>password</td>
				    <td><input type="text" name="txt_password" value="<%=password %>"></td>
			    </tr>
	            <tr>
				    <td>phone</td>
				    <td><input type="text" name="txt_phone" value="<%=phone %>"></td>
			    </tr>
			    <tr>
				    <td>email</td>
				    <td><input type="text" name="txt_email" value="<%=email %>"></td>
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
				    <td>city</td>
				    <td><input type="text" name="txt_city" value="<%=city %>"></td>
			    </tr>
			    <tr>
				    <td>state</td>
				    <td><input type="text" name="txt_state" value="<%=state %>"></td>
			    </tr>			    
	            <tr>
				    <td>zip code</td>
				    <td><input type="text" name="txt_zip_code" value="<%=zipCode %>"></td>
			    </tr>
			    <tr>
				    <td>street</td>
				    <td><input type="text" name="txt_street" value="<%=street %>"></td>
			    </tr>			    
			    
				<tr>
				    <td><input type="submit" name="btn_update" value="Update"></td> 
			    </tr>
			    
			    <input type="hidden" name="user_name_original" value="<%=username %>">
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