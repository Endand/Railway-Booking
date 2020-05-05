<!-- AUTHOR: Sangjun Ko -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.NumberFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>
<body>
	<b>Your search results:</b>
	<br>
    <%
    try {
        // database authentication
        ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();
        Statement stmt = conn.createStatement();

        // parameters
        String search = request.getParameter("searchquery");
        String searchby = request.getParameter("searchby");
        String sortby = request.getParameter("sortby");

        // Search for the desired results
        
        String searchCommand = "";
        if(searchby.equals("origin")) {
            searchCommand = "select t.trans_line_name, t.trainid, t.start_date, t.start_time ";
            searchCommand += "from Station st, TrainSchedule t join Stops s on t.trans_line_name=s.trans_line_name ";
            searchCommand += "where s.stopid=1 and st.stationid=s.stationid and st.name like '%" + search + "%' group by t.trans_line_name, t.trainid, t.start_date, t.start_time;";
        } else if(searchby.equals("destination")) {
            searchCommand = "select t.trans_line_name, t.trainid, t.start_date, t.start_time ";
            searchCommand += "from Station st, TrainSchedule t join Stops s on t.trans_line_name=s.trans_line_name ";
            searchCommand += "where s.stopid=(select max(stopid) from Stops s where s.trans_line_name=t.trans_line_name) "; 
            searchCommand += "and st.stationid=s.stationid and st.name like '%" + search + "%' group by t.trans_line_name, t.trainid, t.start_date, t.start_time;";
        } else {
            searchCommand = "select t.trans_line_name, t.trainid, t.start_date, t.start_time from Station st, TrainSchedule t join Stops s on t.trans_line_name=s.trans_line_name ";
            searchCommand += "where " + searchby + " like '%"+ search + "%' and st.stationid=s.stationid and t.trans_line_name=s.trans_line_name group by t.trans_line_name, t.trainid, t.start_date, t.start_time;";
        }
        ResultSet searchResult = stmt.executeQuery(searchCommand);
        searchResult.last();
        int rowNum = searchResult.getRow();
        searchResult.beforeFirst();
        
        // Populate result matrix
        int rowcounter = 0;
        String[][] queryResult = new String[rowNum][8];
        while(searchResult.next()) {
        	queryResult[rowcounter][0] = searchResult.getString("t.trans_line_name");
        	queryResult[rowcounter][1] = "" + searchResult.getInt("t.trainid");
        	queryResult[rowcounter][2] = searchResult.getDate("t.start_date").toString();
        	queryResult[rowcounter][3] = searchResult.getTime("t.start_time").toString();
        	rowcounter++;
        }
        
            
        
        
        searchResult.close();
        
        // Calculate arrival time
        String arrivalTimeQuery = "select t.trans_line_name, t.trainid, t.start_time, t.start_date, sec_to_time(time_to_sec(t.start_time)+sum(time_to_sec(s.`travel time`))) end_time ";
        arrivalTimeQuery += "from TrainSchedule t, Stops s where t.trans_line_name=s.trans_line_name group by t.trans_line_name, t.trainid, t.start_date;";
        
        ResultSet arrivalTimes = stmt.executeQuery(arrivalTimeQuery);
        for(int i = 0; i < rowNum; i++) {
        	arrivalTimes.first();
        	while(!queryResult[i][0].equals(arrivalTimes.getString("t.trans_line_name")) 
        		 || !queryResult[i][1].equals("" + arrivalTimes.getInt("t.trainid")) 
        		 || !queryResult[i][2].equals(arrivalTimes.getDate("t.start_date").toString()) 
        		 || !queryResult[i][3].equals(arrivalTimes.getTime("t.start_time").toString())) {
        		arrivalTimes.next();
        	}
        	queryResult[i][4] = arrivalTimes.getTime("end_time").toString();
        }
        
        arrivalTimes.close();
        
		
		// Get a table of origins, to populate the result matrix
        ResultSet origins = stmt.executeQuery("select trans_line_name, s.stationid, name from Stops s join Station st on s.stationid=st.stationid where stopid=1;");
        for(int i = 0; i < rowNum; i++) {
        	origins.first();
        	while(!origins.getString("trans_line_name").equals(queryResult[i][0])) {
        		origins.next();
        	}
        	queryResult[i][5] = origins.getString("name");
        }
        
        origins.close();
        
        
        // Get a table of destinations.
        String destSearch = "select trans_line_name, s.stationid, name from Stops s join Station st on s.stationid=st.stationid ";
        destSearch += "where stopid = (select max(stopid) from Stops where trans_line_name=s.trans_line_name);";
        ResultSet destinations = stmt.executeQuery(destSearch);
        for(int i = 0; i < rowNum; i++) {
        	destinations.first();
        	while(!destinations.getString("trans_line_name").equals(queryResult[i][0])) {
        		destinations.next();
        	}
        	queryResult[i][6] = destinations.getString("name");
        }
        
        destinations.close();
        
        // Get a table of fares.
        String fareSearch = "select name, fare_per_stop from TransitLine";
        ResultSet fares = stmt.executeQuery(fareSearch);
        for(int i = 0; i < rowNum; i++) {
        	fares.first();
        	while(!fares.getString("name").equals(queryResult[i][0])) {
        		fares.next();
        	}
        	queryResult[i][7] = "" + NumberFormat.getCurrencyInstance().format(fares.getDouble("fare_per_stop"));
        }
        
        fares.close();
        
        
        
        
        
        session.setAttribute("searchResult", queryResult);
        session.setAttribute("sortby", sortby);
        session.setAttribute("search", search);
        session.setAttribute("searchby", searchby);
        
        final int sortColumnNumber;
        if(sortby.equals("arrivaltime")) {
        	sortColumnNumber = 4;
        } else if(sortby.equals("depttime")) {
        	sortColumnNumber = 3;
        } else if(sortby.equals("origin")) {
        	sortColumnNumber = 5;
        } else if(sortby.equals("destination")) {
        	sortColumnNumber = 6;
        } else if(sortby.equals("fare")) {
        	sortColumnNumber = 7;
        } else {
        	sortColumnNumber = 0;
        }
        
        Arrays.sort(queryResult, new Comparator<String[]>() {
        	@Override
        	public int compare(String[] arr1, String[] arr2) {
        		if(sortColumnNumber == 5 || sortColumnNumber== 6 || sortColumnNumber == 0) {	// we're looking at strings
        			return arr1[sortColumnNumber].compareTo(arr2[sortColumnNumber]);
        		} else if(sortColumnNumber == 4 || sortColumnNumber == 3) {			// we're looking at time
        			return Time.valueOf(arr1[sortColumnNumber]).compareTo(Time.valueOf(arr2[sortColumnNumber]));
        		} else {															// we're looking at double
        			return Double.compare(Double.parseDouble(arr1[sortColumnNumber].substring(1)), Double.parseDouble(arr2[sortColumnNumber].substring(1)));
        		}
        	}
        });
       
        
        
        out.println("<table>");
        
 
        
        out.print("<tr><td>Entry</td><td> <b>Transit Line </b></td>");
        out.print("<td><b>Train Number</b></td>");
        out.print("<td><b>Date</b></td>");
        out.print("<td><b>Departure Time</b></td>");
        out.print("<td><b>Arrival Time</b></td>");
        out.print("<td><b>Origin</b></td>");
        out.print("<td><b>Destination</b></td>");
        out.print("<td><b>Fare Per Stop</b></td></tr>");

		for(int i = 0; i < rowNum; i++) {
			out.print("<tr><b><td>" + (i+1) + "</b></td><td>" + queryResult[i][0] + "</td>");
			out.print("<td>" + queryResult[i][1] + "</td>");
			out.print("<td>" + queryResult[i][2] + "</td>");
			out.print("<td>" + queryResult[i][3] + "</td>");
			out.print("<td>" + queryResult[i][4] + "</td>");
			out.print("<td>" + queryResult[i][5] + "</td>");
			out.print("<td>" + queryResult[i][6] + "</td>");
			out.print("<td>" + queryResult[i][7] + "</td></tr>");
		}
				
        
        out.println("</table>");
        out.println("<br><br><b>To view more information about the searched train schedules, use the drop-down menu below and click \"submit\".</b>");
        out.println("<form method=\"GET\" action=train-schedule-more-info.jsp>");
        out.println("<select name=\"schedulenumber\">");
        for(int i = 0; i < rowNum; i++) { 
        	out.println("<option value=\"" + i + "\">" + (i+1) + "</option>");
        	//System.out.println("<option value=\"" + i + ">\"" + (i+1) + "</option>");
        }
        out.println("</select>");
        out.println("<br> <input type=\"submit\" value=\"Submit\">");
        out.println("</form>");
        
        stmt.close();
        conn.close();

    } catch(Exception e){ 
        out.println("Searching failed. <br>");
        out.print(e);
    }
    





    %>
    <br>
    <a href="train-schedule-search.jsp">Return to search page</a>

</body>
</html>