<!-- AUTHOR: Sangjun Ko -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.NumberFormat, java.text.DecimalFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>More information</title>
</head>
<body>

<%
	try {
		ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();
        Statement stmt = conn.createStatement();
        
        String search = (String)session.getAttribute("search");
        String searchby = (String)session.getAttribute("searchby");
        String sortby = (String)session.getAttribute("sortby");
        
        int row = Integer.parseInt(request.getParameter("schedulenumber"));
        String[][] queryResult = (String[][])session.getAttribute("searchResult");
        out.println("<b>Transit line: </b>" + queryResult[row][0]);
        out.println("<b>Train ID: </b>" + queryResult[row][1]);
        out.println("<b>Date: </b>" + queryResult[row][2]);
        out.println("<table>");
        
        String stopQuery = "select st.name, s.stationid, s.stopid, time_to_sec(s.`travel time`) travel_time ";
        stopQuery += "from Station st, Stops s where s.stationid=st.stationid and s.trans_line_name = '" + queryResult[row][0] + "' order by s.stopid;";
        ResultSet stops = stmt.executeQuery(stopQuery);
        String departureTime = queryResult[row][3];
        //System.out.println(departureTime);
       	long hours = Long.parseLong(departureTime.substring(0,2));
       	//System.out.println(hours);
       	long minutes = Long.parseLong(departureTime.substring(3,5));
       	long seconds = Long.parseLong(departureTime.substring(6,8));
       	long timeSeconds = (hours * 3600) + (minutes * 60) + seconds;
       	
        out.println("<tr><td><b>Station</b></td><td><b>Departure/Arrival Time</b></td></tr>");
        while(stops.next()) {
        	out.println("<tr><td>" + stops.getString("st.name") + "</td>");
        	timeSeconds += stops.getLong("travel_time");
     
			long newHours = timeSeconds / 3600;
			long newMinutes = (timeSeconds % 3600) / 60;
			long newSeconds = (timeSeconds % 3600) % 60;
			DecimalFormat timeFormatter = new DecimalFormat("00");
        	out.println("<td>" + timeFormatter.format(newHours) + ":" + timeFormatter.format(newMinutes) + ":" + timeFormatter.format(newSeconds) + "</td></tr>");
        	
        }
        out.println("</table>");
        out.println("<a href=\"train-schedule-search-action.jsp?searchby=" + searchby + "&sortby=" + sortby + "&searchquery=" + search + "\">Go back to results page</a>");
        stops.close();
        stmt.close();
        conn.close();
		
	} catch (NullPointerException e) {
		out.println(e);
		out.println("<br>One of the attributes is missing. <a href=\"train-schedule-search.jsp\">Return to search page</a>");
	} catch (Exception e) {
		out.println("Query failed. <a href=\"train-schedule-search.jsp\"> Return to search page</a><br>");
		out.println(e);
	}

%>

<a href="train-schedule-search.jsp">Return to search page</a>

</body>
</html>