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
	String query = "SELECT ts.trans_line_name, ts.trainid, ts.start_date, ts.start_time FROM TrainSchedule ts JOIN Train t ON t.trainid = ts.trainid JOIN  TransitLine tl ON tl.name = ts.trans_line_name ORDER BY ts.trans_line_name, ts.trainid, ts.start_date, ts.start_time;";
	ResultSet rs= st.executeQuery(query);
	
	
	session.setAttribute("customer?", false);
	%>
	
    <%
   	%>
   	<form method="get" action="delay-alert-msg-action.jsp">
    <br/>
    
	Select Train schedule
    <select name="selection">
    <option value=""></option>
    
    <%
	while(rs.next()){
		String opt = (rs.getString("trans_line_name") + "," + rs.getInt("trainid") + "," + rs.getString("start_date") + "," + rs.getString("start_time"));
	%> 
		<option value=<%=opt%> > <%= opt %> </option>
	
	<%
	}
	%>
	</select>
	
	<br><br>
	<% 
	rs.close();
	st.close();
	con.close();
	%>        
	
	<!--Button-->  
	
	<input type="submit" value="submit">
	</form>
	

</body>

</html>