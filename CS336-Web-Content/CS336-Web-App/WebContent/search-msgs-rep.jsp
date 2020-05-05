<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Messages</title>
</head>

<!--Log-in form-->

<body>
        Search results: 
        ---------------------------------------------------------------------------------------------------------------- <br>
        <% 
      	//set up SQL statement
        ApplicationDB db =  new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
      	//Create a SQL statement to get top msgs
        PreparedStatement pstmt;
	    pstmt = con.prepareStatement("SELECT msgid FROM RailwayBooking.Messages m WHERE is_reply = -1 ORDER BY date, time;");
        //"SELECT * FROM RailwayBooking.Messages m WHERE m.is_reply IN (SELECT msgid FROM RailwayBooking.Messages m WHERE m.cust_asks = ?) OR m.cust_asks = ?;"
        ResultSet rs = pstmt.executeQuery();
        
        //Plan for search:
        //get table of top msgs (is_reply = -1)
        //put entire msg chain in arraylist<int> as msgids
        //query for individual msgids and see if they match search
        
        //stores top msgs
        ArrayList<Integer> top = new ArrayList<Integer>();
        while(rs.next()) {
        	top.add(rs.getInt("msgid"));
        }
        
        //stores all msgs
        ArrayList<Integer> all = new ArrayList<Integer>();
        
        //loops to get all msgids that are relevant
        for(int i = 0; i < top.size(); i++)
        {
        	int msgidi = top.get(i);
        	
        	//gets all msgs in chain
        	while(msgidi != -1)
        	{
        		pstmt = con.prepareStatement("SELECT has_reply FROM RailwayBooking.Messages m WHERE m.msgid = ?;");
        		pstmt.setInt(1, msgidi);
                ResultSet message = pstmt.executeQuery();
                all.add(msgidi);
                message.next();
                msgidi = message.getInt("has_reply");
        	}
        }
        
        
        //for every item in arraylist, if seach string exists in title or message print title + message + reply button
        for(int i = 0; i < all.size(); i++)
        {
        	pstmt = con.prepareStatement("SELECT * FROM RailwayBooking.Messages m WHERE m.msgid = ?;");
    		pstmt.setInt(1, all.get(i));
            rs = pstmt.executeQuery();
            rs.next();
        	
        	//extract variables from table
        	String title = rs.getString("title");
        	String msg = rs.getString("msg");
        	int msgid = rs.getInt("msgid");//need to get the top msgid!
        	String search = request.getParameter("search");
        	
        	//get msg maker
        	String temp = (String)session.getAttribute("customer?");
        	String user1 = rs.getString("cust_asks");
			String user = "";
			if(user1 == null || (user1.equals("null"))) {
				//need to do query for employee username
				pstmt = con.prepareStatement("SELECT username FROM RailwayBooking.Employee e WHERE e.ssn = ?;");
				pstmt.setInt(1, rs.getInt("empl_ans"));
	            ResultSet eset = pstmt.executeQuery();
	            eset.next();
				user = eset.getString("username");
			} else {
				user = user1;
			}
			
        	
        	//boolean value to see if search was successful
        	if(title.contains(search) || msg.contains(search)) {
        		
        		//look for "top" statement
        		int next = msgid;
        		while(next != -1){
        			msgid = next;
	        		pstmt = con.prepareStatement("SELECT is_reply FROM RailwayBooking.Messages WHERE msgid = ?");
	        		pstmt.setString(1, msgid + "");
	        		ResultSet tempset = pstmt.executeQuery();
	        		tempset.next();
	        		next = tempset.getInt("is_reply");
	        		
        		}
        		
        		%>
        		<br>
				Title: <%=title%> <br>
				From: <%=user %> <br>
				Message:<br><%=msg%> <br>
				<form method="POST" action="replies.jsp"> <!-- A button to see replies -->
					<input type="hidden" name="msgid" value="<%=msgid%>" />
					<input type="submit" value="See entire QA chain"></input>
				</form>
				
				<%
				
				out.println("----------------------------------------------------------------------------------------------------------------");
        	}
        	
        }
        
        %>
   
</body>
</html>
