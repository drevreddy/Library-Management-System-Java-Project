<%  response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cahce");
// 	URLcurrent = "return.jsp";
//	URLcurrent=response.encodeURL(URLcurrent);	
%>
<%@ page import="java.util.Date, java.text.DateFormat, java.util.*" %>
<%@ include file="common.jsp" %>
<%@ include file="dbconnect.jsp" %>
<jsp:setProperty name="form" property="formName" value="borrowrec" />
<jsp:setProperty name="form" property="formType" value="return" />
<jsp:setProperty name="form" property="formURL" value="return.jsp" />

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
	Date returnDate = new Date();
	String returnDateStr = DateFormat.getDateInstance(DateFormat.MEDIUM).format(returnDate);

	String queryOrderField= "";
	String queryOrderType= "";
	String queryParameter= "";

	String queryFilter= "";
	String querySearch= "";
	String queryCondition= "";
	String queryOrder= "";
	String query= "";

	String borrowerID = "";
	boolean skipSearch = false;
	int recDisplayNum= 0;
	String recDisplayNumStr= "";

	ResultSet myResultSet=null;
	ResultSet myResultSet1=null;
	ResultSet rsCount=null;

	int pageCurrent=0;
	int pageOffSet=0;
    String errorMsg= "";

	// Get the HTTP request parameter
	borrowerID = request.getParameter("borrowerID");
	recDisplayNumStr= request.getParameter("recDisplayNum");
	queryOrderField = request.getParameter("queryOrderField");
	queryOrderType = request.getParameter("queryOrderType");

	// Checking the HTTP request parameter
	if (recDisplayNumStr==null)
		recDisplayNum = 5;
	else
		recDisplayNum = Integer.parseInt(recDisplayNumStr);
	if (recDisplayNum <1) recDisplayNum = 1;

	if(borrowerID == null)
		borrowerID = "";

	if (!borrowerID.equals(""))  {
		if (borrowerID.equals(staff.getUserID())) {
			errorMsg = "Error: borrower ID " + borrowerID +" cannot be same as staff in charge";
			skipSearch = true;
		} else {
			querySearch = " borrowerID = '" + borrowerID +"' ";
		}
	} else {
		skipSearch = true;
	}

	// Generate the search query
	queryFilter = " WHERE borrowStatus != 'return' ";

	if(queryOrderField ==null)
		queryOrderField ="";

	if (queryOrderType ==null)
		queryOrderType ="";

	if((queryOrderField.equals("")) || (queryOrderType.equals("")))
		queryOrder = " ORDER BY itemCallNumber";
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
      <p align="center"><b>Return</b></p>
        <center>
        <table width="75%" border="0">
          <tr> 
            <td width="25%">Staff ID: <%= staff.getUserID() %></td>
            <td width="25%">&nbsp;</td>
            <td width="25%">Today: 
              <% out.println(returnDateStr); %>
            </td>
            <td width="25%">&nbsp;</td>
          </tr>
        </table>
        <font color=RED> 
        <% out.println("<font color=RED><b><i>" +errorMsg +"</i></b></font>"); %>
        </font><br>
        </center>
        <center>
          <font color=RED> </font> 
        </center>
        <hr>
        <table width="100%" border="0" bgcolor="#66FFCC">
          <tr> 
            <td> 
              <%
	queryParameter="&queryOrderField=" +queryOrderField +
		"&queryOrderType=" +queryOrderType +"&recDisplayNum=" +recDisplayNum;
%>
              <form name="form1" method="post" action="return.jsp?<%= queryParameter%>">
                
              <p>Borrower ID 
                <input type="text" name="borrowerID" size="30">
                <input type="submit" name="Submit" value="Submit">
              </p>
              </form>
			
            </td>
          </tr>
        </table>
        <hr>
        <table width="100%" border="0" bgcolor="#66FFCC">
          <tr> 
            <td> 
              <%		queryParameter="&queryOrderField=" +queryOrderField +
		"&queryOrderType=" +queryOrderType +"&borrowerID=" +borrowerID;
%>
              <form action="return.jsp?<%= queryParameter%>" name="form2" method="post">
                <p> 
                  <input type="submit" name="Show" value="Show">
                  <input type="text" name="recDisplayNum" maxlength="2" size="4" value="<%= recDisplayNum %>">
                  records per page </p>
              </form>
              <center>
                <b><br>
                </b> 
              </center>
              <%
	queryParameter="&borrowerID=" +borrowerID +"&recDisplayNum=" +recDisplayNum;
%>
<i> Borrower ID: <%= borrowerID %>  </i>           
            <form name="form3" method="post" action="./formprocess">
              * Penalty = Total over due day * .25<br>
                
              <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
                <tr valign="top"> 
                  <td width="4%"></td>
                  <th width="14%" bgcolor="#D3DCE3">Item Call No<br>
                    <a href=return.jsp?&queryOrderField=itemCallNumber&queryOrderType=ASC&<%= queryParameter%>> 
                    <% if(queryOrderField.equals("itemCallNumber") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
                    </a> <a href=return.jsp?&queryOrderField=itemCallNumber&queryOrderType=DESC&<%= queryParameter%>> 
                    <% if(queryOrderField.equals("itemCallNumber") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
                    </a></th>
                  <th width="18%" bgcolor="#D3DCE3">Borrow Date<br>
                    <a href=return.jsp?&queryOrderField=borrowDate&queryOrderType=ASC&<%= queryParameter%>> 
                    <% if(queryOrderField.equals("borrowDate") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
                    </a> <a href=return.jsp?&queryOrderField=borrowDate&queryOrderType=DESC&<%= queryParameter%>> 
                    <% if(queryOrderField.equals("borrowDate") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
                    </a></th>
                  <th width="18%" bgcolor="#D3DCE3">Due Date<br>
                    <a href=return.jsp?&queryOrderField=dueDate&queryOrderType=ASC&<%= queryParameter%>> 
                    <% if(queryOrderField.equals("dueDate") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
                    </a> <a href=return.jsp?&queryOrderField=dueDate&queryOrderType=DESC&<%= queryParameter%>> 
                    <% if(queryOrderField.equals("dueDate") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
                    </a></th>
                  <th width="13%" bgcolor="#D3DCE3">Status<br>
                    <a href=return.jsp?&queryOrderField=borrowStatus&queryOrderType=ASC&<%= queryParameter%>> 
                    <% if(queryOrderField.equals("borrowStatus") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
                    </a> <a href=return.jsp?&queryOrderField=borrowStatus&queryOrderType=DESC&<%= queryParameter%>> 
                    <% if(queryOrderField.equals("borrowStatus") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
                    </a></th>
                  <th width="13%" bgcolor="#D3DCE3">Overdue Day</th>
                  <th width="13%" bgcolor="#D3DCE3">Penalty</th>
                </tr>
                <%
if(!skipSearch) {
	queryParameter="&borrowerID=" +borrowerID +"&queryOrderField=" +queryOrderField +
		"&queryOrderType=" +queryOrderType +"&recDisplayNum=" +recDisplayNum;
	
	// calculate the total record that will display for navigation
	String queryCount = "SELECT count(*) FROM borrowrec" + queryCondition;

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
	//query = "SELECT * FROM borrowrec" + queryCondition + queryOrder; 
	// +" limit " +pageOffSet +"," +recDisplayNum;
	 query = "SELECT BORROWRECNUMBER,ITEMCALLNUMBER,STAFFIDBORROW,STAFFIDRETURN,BORROWERID,BORROWEREMAIL,BORROWDATE,DUEDATE,RETURNDATE,BORROWSTATUS,(sysdate-to_date(DUEDATE)) AS OVERDUEDAY FROM borrowrec "+ queryCondition + queryOrder; // +" limit " +pageOffSet +"," +recDisplayNum;*/
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
					
					String iCNo=myResultSet.getString("itemCallNumber");
					System.out.println("HaiWorld");

					int bRecNo=Integer.parseInt(myResultSet.getString("BORROWRECNUMBER"));
					System.out.println("return.jsp bRecNo " +bRecNo);

					System.out.println();
					System.out.println("Hello1");
	    			
					if (rowCount % 2 == 0) {
						System.out.println("Hello2");
	       				out.println ("<tr bgcolor=#CCCCCC align=left>");
					} else { 
						System.out.println("Hello3");
						out.println ("<tr bgcolor=#DDDDDD align=left>");
					}
					System.out.println("Hello4");
										
					out.println("<TD><input type=\"checkbox\" name=\"borrowRecNumber\" value=\"" + bRecNo +"\">");
					System.out.println("Hello5");

					out.println("</TD><TD><a href='libraryitem_view.jsp?itemCallNumber=" +iCNo+"'>" +iCNo+"</a>");
					System.out.println("Hello6");

					out.println("</TD><TD>" +myResultSet.getString("borrowDate"));
					System.out.println("Hello7");

					out.println("</TD><TD>" +myResultSet.getString("dueDate"));
					System.out.println("Hello8");

					out.println("</TD><TD>" +myResultSet.getString("borrowStatus"));
					System.out.println("Hello9");

					int oDueDay=(int)Float.parseFloat(myResultSet.getString("OVERDUEDAY"));
					System.out.println("return.jsp No of OverDueDays " +oDueDay );

					//int oDueDay=12;
					if( oDueDay > 0) {
						System.out.println("Hello11");
						out.println("</TD><TD>" + oDueDay);
						out.println("</TD><TD>Rs." + oDueDay*.25);
					} else {
						System.out.println("Hello12");
						out.println("</TD><TD>-");
						out.println("</TD><TD>-");
					}
					System.out.println("Hello13");
					out.println("</TD></TR>");
					rowCount = rowCount+1;					
				}
			} catch(SQLException sqle) {
				System.err.println("return.jsp Error connecting: " +sqle);		
			}
		} 
}
%>
              </table>
                <input type="hidden" name="borrowerID" value="<%= borrowerID %>">
                <input type="hidden" name="returnDate" value="<%= ServletUtilities.dateToString(returnDate) %>">
                <br>
                <% if(!skipSearch) { %>
                <img src="arrow_ltr.gif" width="38" height="22">With 
                selected: 
                <input type='submit' name='Delete' value='Process item return'>
                Or 
                <input type='reset' name='Reset' value='Reset'>
                <% } %>
              </form>
              <p>&nbsp;</p>
            </td>
          </tr>
        </table>


</td>
  </tr>
</table>
<jsp:include page="footer.jsp" flush="true" />
<% connectionPool.closeAllConnections(); %>
</body>
</html>