<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display Searching Result</title>
</head>
<body>
<%
String Train =request.getParameter("Train");
int result = Integer.parseInt(Train);
String TransitLine =request.getParameter("TransitLine");

ApplicationDB db =  new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();
%>


<%
//out.println("This is Line: "+ OandD1);
String url = "jdbc:mysql://cs336db.cauy6sf96qf6.us-east-1.rds.amazonaws.com:3306/RailwayBooking";
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(url, "admin", "CoCPgEAcRUvmCxcAkzUl"); // ****
Statement stmt = conn.createStatement();

//out.println(result+"train");
//out.println(TransitLine+"TransitLine1");

PreparedStatement pstmt;
//pstmt = conn.prepareStatement("SELECT DISTINCT c.username FROM Customer c JOIN Reservation r ON c.username = r.passenger_username WHERE r.trainid = ? AND r.trans_line_name = ?;");
pstmt = conn.prepareStatement("SELECT DISTINCT r.passenger_username FROM Reservation r WHERE r.trainid = ? AND r.trans_line_name = ?;");//since reservation already stored passenger_username, so we can actually use it straight


pstmt.setInt(1,result);//convert from string to int already
pstmt.setString(2,TransitLine);
ResultSet rs = pstmt.executeQuery();
while(rs.next()){//loop through all possible results
	out.println(rs.getString("passenger_username"));
	%>
	<br>
	<%
	
}

%>

<% 

out.print("Searching Finished. Available Uers Name Printed Above.<br> Back to Home <a href='CustomerRepresentative-main-page.jsp'> now </a>.");
	%>	     
<%
rs.close();
pstmt.close();
st.close();
con.close();
%>
</table>
</body>
</html>