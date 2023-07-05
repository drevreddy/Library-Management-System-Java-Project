
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="240"> 
      <div align="center"><img src="welcome.gif"></div>
    </td>

    </td>
  </tr>
</table>
<p><br>
  <%	
	// Display the login user ID
	if((login.getUserType()).equals("admin")) {
		//out.println("<i>U had login as ADMIN access level</i><p>");
		out.println(" ");
	} else if((login.getUserType()).equals("librarian")) {
		//out.println("<i>U had login as LIBRARIAN access level</i><p>");
		out.println(" ");
	} else{
		out.println("  ");
	}
%>
  <br>
  <br>
  <%

int numberOfOverDueRec = 0;
int numberOfReserveAvailable = 0;
String query = "";
String errorMsg="";
ResultSet myResultSet = null;

// Calculate the total number of overdue borrow record and number of reserve item that had available already
// And display the result as notice.

query = "SELECT count(*) FROM borrowrec where borrowStatus='overdue' and borrowerID='" +login.getUserID() +"'"; 
try {  
	Connection connection = connectionPool.getConnection();
	myResultSet = DatabaseUtilities.getQueryResultSet(connection, query, false);                                        
    connectionPool.free(connection);
} catch(Exception e) {
	errorMsg = "Error: " + e;    		
}            	

if (myResultSet != null){
	try{
		while(myResultSet.next()) {
			numberOfOverDueRec = Integer.parseInt(myResultSet.getString("count(*)"));
		}
	} catch(SQLException sqle) {
		System.out.println("Hello");
		System.err.println("login_menu.jsp Error connecting: " +sqle);		
	}
}   

query = "SELECT count(*) FROM reserverec where reserveStatus='available' and reserverID = '" +login.getUserID() +"'";
try {  
	Connection connection = connectionPool.getConnection();
	myResultSet = DatabaseUtilities.getQueryResultSet(connection, query, false);                                        
    connectionPool.free(connection);
} catch(Exception e) {
	errorMsg = "Error: " + e;    		
}            	

if (myResultSet != null){
	try{
		while(myResultSet.next()) {
			numberOfReserveAvailable = Integer.parseInt(myResultSet.getString("count(*)"));
		}
	} catch(SQLException sqle) {
		System.err.println("try login_menu.jsp Error connecting: " +sqle);		
	}
}   
if ((numberOfOverDueRec !=0) || (numberOfReserveAvailable !=0)){
	out.println("<ul>");
	if (numberOfOverDueRec != 0) 
		out.println("<li>You have <i>" +numberOfOverDueRec +" </i>over due items not yet return!</li>");
	if (numberOfReserveAvailable != 0)
		out.println("<li>You have <i>" +numberOfReserveAvailable +" </i>reserve items available now!</li>"); 
	out.println("</ul><hr>");
}
%>