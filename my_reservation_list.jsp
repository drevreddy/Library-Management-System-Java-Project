<%@ include file="common.jsp" %>
<%@ include file="dbconnect.jsp" %>
<jsp:setProperty name="form" property="formName" value="reserve" />
<jsp:setProperty name="form" property="formType" value="delete" />
<jsp:setProperty name="form" property="formURL" value="my_reservation_list.jsp" />
<%  response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cahce");
// 	URLcurrent = "my_reservation_list.jsp";
//	URLcurrent=response.encodeURL(URLcurrent);	
%>
<html>
<head>
<title>SVPG Online Library Management System</title>
<META NAME="description" CONTENT="">
<META NAME="keywords" CONTENT="">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
   A:link                  { text-decoration:  none; font-weight: bold; color: #660033}
   A:active                { text-decoration:  none; font-weight: bold; color: #660033}
   A:visited               { text-decoration:  none; font-weight: bold; color: #336699}
   A:hover                 { text-decoration:  underline; font-weight: bold; color: #FF9999}
.footerLink {  font-family: Arial, Helvetica, sans-serif; font-size: 9pt; font-weight: bold; color: #000099}
-->
</style>
</head>

<body bgcolor="#0099ff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="">
<%
	// Initialize the variables
	String queryOrderField= "";
	String queryOrderType= "";
	String queryParameter= "";

	String queryFilter= "";
	String querySearch= "";
	String queryCondition= "";
	String queryOrder= "";
	String query= "";

	String reserveStatus = "";

	int recDisplayNum= 0;
	String recDisplayNumStr= "";

	ResultSet myResultSet=null;
	ResultSet rsCount=null;

	int pageCurrent=0;
	int pageOffSet=0;
    String errorMsg= "";

	// Get the HTTP request parameter
	reserveStatus = request.getParameter("reserveStatus");
	recDisplayNumStr= request.getParameter("recDisplayNum");
	queryOrderField = request.getParameter("queryOrderField");
	queryOrderType = request.getParameter("queryOrderType");

	// Checking the HTTP request parameter
	if (recDisplayNumStr==null)
		recDisplayNum = 5;
	else
		recDisplayNum = Integer.parseInt(recDisplayNumStr);
	if (recDisplayNum <1) recDisplayNum = 1;

	if (reserveStatus == null)
		reserveStatus = "all";
	
	if (reserveStatus.equals("all")) {
		queryFilter = " WHERE reserverID ='" +login.getUserID() +"' ";
	} else {
		queryCondition = "";
		queryFilter = " WHERE reserverID='" +login.getUserID() +"'AND reserveStatus = '" +reserveStatus +"'";
	}

	if(queryOrderField ==null)
		queryOrderField ="";

	if (queryOrderType ==null)
		queryOrderType ="";

	// Generate the search query
	if((queryOrderField.equals("")) || (queryOrderType.equals("")))
		queryOrder = " ORDER BY itemCallNumber";// ASC ";
	else 
		queryOrder = " ORDER BY " +queryOrderField +" " +queryOrderType;

	if( queryFilter.equals("") ) {
		if(querySearch.equals(""))
			queryCondition = "";
		else			
			queryCondition = " where " +querySearch;
	} else {
		if (querySearch.equals(""))
			queryCondition = queryFilter;
		else
			queryCondition = queryFilter + " and " +querySearch;
	}
%>
<a name="top"></a> 
<%@ include file="header_select.jsp" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="#f1f1f1"> 
    <td width="180" align="left" valign="top"> 
	  	  <%@ include file = "navi.jsp" %>
    </td>
        <TD width=1 bgColor=#999999><IMG height=1 alt="" 
      src="1ptrans.gif" 
      width=1 border=0></TD>
    <td valign="top" width="100%" bgcolor="#f1f1f1"> 
      <p align="center"><b>My Reservation Record</b><br>
        <br>
        <%@ include file="printview.jsp" %>
      </p>
<%
	queryParameter="&queryOrderField=" +queryOrderField +
		"&queryOrderType=" +queryOrderType +"&recDisplayNum=" +recDisplayNum;
%>
      <form name="form1" action="my_borrow_list.jsp?<%= queryParameter%>" method="post">
        <center>
          Limiting options: 
          <select name=reserveStatus>
            <option value="all" selected>All reserve records</option>
            <option value="over">Over reserve period</option>
            <option value="available">Available</option>
            <option value="queue">Queue</option>
          </select>
          <input type="submit" name="Search" value="Go">
          <br>
        </center>
      </form>
<%		queryParameter="reserveStatus="+reserveStatus +"&queryOrderField=" +queryOrderField +
		"&queryOrderType=" +queryOrderType;
%>
      <form name="form2" method="post" action="my_borrow_list.jsp?<%= queryParameter%>">
        <input type="submit" name="Show" value="Show">
          <input type="text" name="recDisplayNum" maxlength="2" size="4" value="<%= recDisplayNum %>">
          records per page 
        </form>
<%
	queryParameter="reserveStatus="+reserveStatus +"&recDisplayNum=" +recDisplayNum;
%>
        
      <form name="form2" method="post" action="./formprocess">
        <i>* click on User ID to view/edit the record</i><br>

          <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
          <tr> 
            <td width="3%"></td>
            <th width="22%" bgcolor="#D3DCE3">Item Call No<a href=my_reservation_list.jsp?&queryOrderField=itemCallNumber&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemCallNumber") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=my_reservation_list.jsp?&queryOrderField=itemCallNumber&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemCallNumber") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a></th>
            <th width="23%" bgcolor="#D3DCE3">Reserve Date<a href=my_reservation_list.jsp?&queryOrderField=reserveDate&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("reserveDate") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=my_reservation_list.jsp?&queryOrderField=reserveDate&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("reserveDate") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a></th>
            <th width="19%" bgcolor="#D3DCE3">Cancel Date<a href=my_reservation_list.jsp?&queryOrderField=reserveCancelDate&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("reserveCancelDate") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=my_reservation_list.jsp?&queryOrderField=reserveCancelDate&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("reserveCancelDate") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a></th>
            <th width="17%" bgcolor="#D3DCE3">Inform Date<a href=my_reservation_list.jsp?&queryOrderField=reserveInformDate&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("reserveInformDate") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=my_reservation_list.jsp?&queryOrderField=reserveInformDate&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("reserveInformDate") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a></th>
            <th width="16%" bgcolor="#D3DCE3">Status<a href=my_reservation_list.jsp?&queryOrderField=reserveStatus&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("reserveStatus") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=my_reservation_list.jsp?&queryOrderField=reserveStatus&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("reserveStatus") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a></th>
          </tr>

<%
	queryParameter="reserveStatus="+reserveStatus +"&queryOrderField=" +queryOrderField +
		"&queryOrderType=" +queryOrderType +"&recDisplayNum=" +recDisplayNum;
	
	// calculate the total record that will display for navigation
	String queryCount = "SELECT count(*) FROM reserverec" + queryCondition;
   	try {  
      		Connection connection = connectionPool.getConnection();
			rsCount=DatabaseUtilities.getQueryResultSet(connection, queryCount, false);                                           
      		connectionPool.free(connection);
    	} catch(Exception e) {
      		errorMsg = "Error: " + e;    		
    	}  

		int recCount=0;  
		while (rsCount.next()){
			recCount=rsCount.getInt(1);
		}

		int pageCount = (recCount+recDisplayNum-1)/recDisplayNum;
		String strPage;
		strPage=request.getParameter("pageCurrent");
		if (strPage==null){
			pageCurrent = 1;
		} else{
			pageCurrent=Integer.parseInt(strPage);
		}
		if (pageCurrent<1) pageCurrent=1;
			pageOffSet=(pageCurrent-1)*recDisplayNum;
		
	// Get the request record result from search query
	query = "SELECT * FROM reserverec" + queryCondition + queryOrder;
	//+" limit " +pageOffSet +"," +recDisplayNum;
  		try {  
      		Connection connection = connectionPool.getConnection();
			myResultSet = DatabaseUtilities.getQueryResultSet(connection, query, false);                                        
      		connectionPool.free(connection);
    	} catch(Exception e) {
      		errorMsg = "Error: " + e;    		
    	}            	
%>
	<%@ include file="page_count.jsp" %>
<%
		// Display the search result
    	if (myResultSet != null){
			int rowCount = 1 ; // set counter to separate even or odd
			try{
				while(myResultSet.next()) {
					String itemCNo=myResultSet.getString("itemCallNumber");
	    			if (rowCount % 2 == 0)
	       				out.println ("<tr bgcolor=#CCCCCC align=left>");
					else 
					out.println ("<tr bgcolor=#DDDDDD align=left>");
					out.println("<TD><input type=\"checkbox\" name=\"reserveRecNumber\" value=\"" +myResultSet.getString("reserveRecNumber") +"\">");
					out.println("</TD><TD><a href='libraryitem_view.jsp?itemCallNumber=" +itemCNo+"'>" +itemCNo+"</a>");
					out.println("</TD><TD>" +myResultSet.getString("reserveDate"));
					out.println("</TD><TD>" +myResultSet.getString("reserveCancelDate"));
					out.println("</TD><TD>" +myResultSet.getString("reserveInformDate"));
					out.println("</TD><TD>" +myResultSet.getString("reserveStatus"));
					out.println("</TD></TR>");
					rowCount = rowCount+1;					
				}
			} catch(SQLException sqle) {
				System.err.println("my_reservation Error connecting: " +sqle);		
			}
		} 
%>   </table>
<br>
        <img src="arrow_ltr.gif" width="38" height="22">With 
        selected: 
        <input type='submit' name='Delete' value='Cancel Reservation'>
        Or 
        <input type='reset' name='Reset' value='Reset'>
      </form>    
    </td>
  </tr>
</table>
<jsp:include page="footer.jsp" flush="true" />
<% connectionPool.closeAllConnections(); %>
</body>
</html>