<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Trainschedule</title>
</head>
<body>
	<div class="main"> 
	<form method="post" action="update-Trainschedule-action.jsp"> 
	 
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
	            
	            if(request.getParameter("editStartTime")!=null) 
	            {
	             String start_time=request.getParameter("editStartTime");
	             String trainid=request.getParameter("editTrianID");
	             String trans_line_name=request.getParameter("editTriansLineName");
	             String start_date=request.getParameter("editStartDate");

	            
	       
	            String searchCommand = "SELECT start_time, trainid, trans_line_name, start_date FROM TrainSchedule WHERE start_time ='" + start_time + "'and trainid = '"+ trainid +"'and trans_line_name ='"+ trans_line_name +"'and start_date = '"+ start_date +"';";
	            ResultSet editItems = stmt.executeQuery(searchCommand);
	            
	            
	            while(editItems.next()) {

	            %>
	            <tr>
				    <td>start_time</td>
				    <td><input type="text" name="txt_start_time" value="<%=start_time %>"></td>
			    </tr>
			    <tr>
				    <td>trainid</td>
				    <td><input type="text" name="txt_trainid" value="<%=trainid %>"></td>
			    </tr>
	            <tr>
				    <td>trans_line_name</td>
				    <td><input type="text" name="txt_trans_line_name" value="<%=trans_line_name %>"></td>
			    </tr>
			    <tr>
				    <td>start_date</td>
				    <td><input type="text" name="txt_start_date" value="<%=start_date %>"></td>
			    </tr>			    
	           
			    
			   
			    <input type="hidden" name="StartTime_original" value="<%=start_time%>">
		        <input type="hidden" name="TrianID_original" value="<%=trainid%>">
		        <input type="hidden" name="TriansLineName_original" value="<%=trans_line_name%>">
		        <input type="hidden" name="StartDate_original" value="<%=start_date%>">
		           
		        <tr>
				    <td><input type="submit" name="btn_update" value="Update"></td> 
			    </tr>
			       
	            <%
	            } 
	            
	            editItems.close();
	            stmt.close();
	            conn.close();
	            
	            }
	        } catch(Exception e) {
	            out.print(e + "<br>");
	            out.print("Login failed. Click <a href='CustomerRepresentative-Login.jsp'>here</a> to return to the login screen.");
	        }
	    %>
	  </table> 
	  
	  <center>
	    <h1><a href="CustomerRepresentative-main-page.jsp">Back</a></h1>
	  </center>
	  
	 </form>
	</div>
</body>
</html>