<%@ include file="common.jsp" %>
<%@ include file="dbconnect.jsp" %>
<jsp:setProperty name="form" property="formName" value="libraryitem" />
<jsp:setProperty name="form" property="formType" value="delete" />
<jsp:setProperty name="form" property="formURL" value="search_libraryitem.jsp" />
<%  response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cahce");
// 	URLcurrent = "search_libraryitem.jsp";
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

	String itemSubject = "";
	String filterOpt1 = "";
	String itemMediaType = "";
	String filterOpt2 = "";
	String itemLanguage = "";
	String itemTitle = "";
	String searchOpt1 = "";
	String itemCallNumber = "";
	String searchOpt2 = "";
	String itemKeyword = "";
	String searchOpt3 = "";
	String itemISBN = "";

	int recDisplayNum= 0;
	String recDisplayNumStr= "";

	ResultSet myResultSet=null;
	ResultSet rsCount=null;

	int pageCurrent=0;
	int pageOffSet=0;
    String errorMsg= "";

	// Get the HTTP request parameter
	itemSubject = request.getParameter("itemSubject");
	filterOpt1 = request.getParameter("filterOpt1");
	itemMediaType = request.getParameter("itemMediaType");
	filterOpt2 = request.getParameter("filterOpt2");
	itemLanguage = request.getParameter("itemLanguage");
	itemTitle = request.getParameter("itemTitle");
	searchOpt1 = request.getParameter("searchOpt1");
	itemCallNumber = request.getParameter("itemCallNumber");
	searchOpt2 = request.getParameter("searchOpt2");
	itemKeyword = request.getParameter("itemKeyword");
	searchOpt3 = request.getParameter("searchOpt3");
	itemISBN = request.getParameter("itemISBN");

	recDisplayNumStr = request.getParameter("recDisplayNum");
	queryOrderField = request.getParameter("queryOrderField");
	queryOrderType = request.getParameter("queryOrderType");

	// Checking the HTTP request parameter
	if (recDisplayNumStr==null)
		recDisplayNum = 5;
	else
		recDisplayNum = Integer.parseInt(recDisplayNumStr);

	if (recDisplayNum <1) recDisplayNum = 1;

	if (itemSubject == null)
		itemSubject = "all";

	if (!(itemSubject.equals("all"))) {

		if ((itemSubject.equals("Arts")) || (itemSubject.equals("Business")) 
				|| (itemSubject.equals("Computing"))  || (itemSubject.equals("Commerce")) 
				|| (itemSubject.equals("Education")) || (itemSubject.equals("Engineering and Surveying")) 
				|| (itemSubject.equals("Science and Technology"))) {
			queryFilter = " WHERE itemSubject = '" +itemSubject +"' ";
		} else {
			queryFilter = " WHERE itemSubject = '" +itemSubject +"' ";
		}
	}

	if(itemMediaType == null)
		itemMediaType = "all";
	
	if(!(itemMediaType.equals("all"))) {
		if(queryFilter.equals("")) {
			queryFilter = " WHERE itemMediaType = '" +itemMediaType +"' ";
		} else {
			queryFilter = queryFilter +filterOpt1 +" itemMediaType = '" +itemMediaType +"' ";
		}
	}

	if(itemLanguage == null)
		itemLanguage = "all";
	
	if(!(itemLanguage.equals("all"))) {
		if(queryFilter.equals("")) {
			queryFilter = " WHERE itemLanguage = '" +itemLanguage +"' ";
		}else {
			queryFilter = queryFilter +filterOpt2 +" itemLanguage = '" +itemLanguage +"' ";
		}
	}

	if(itemTitle == null)
		itemTitle = "";

	if (!itemTitle.equals("")) 
		querySearch = " itemTitle like '%" + itemTitle +"%' ";

	if(itemCallNumber ==null)
		itemCallNumber = "";
	
	if(!itemCallNumber.equals("")){
		if(!querySearch.equals(""))
			querySearch = querySearch +" " +searchOpt1 +" itemCallNumber like '%" +itemCallNumber +"%' ";
		else
			querySearch = " itemCallNumber like '%" +itemCallNumber +"%' ";	
	}

	if(itemKeyword ==null)
		itemKeyword = "";
	
	if(!itemKeyword.equals("")){
		if(!querySearch.equals(""))
			querySearch = querySearch +" " +searchOpt2 +" itemKeyword like '%" +itemKeyword +"%' ";
		else
			querySearch = " itemKeyword like '%" +itemKeyword +"%' ";	
	}

	if(itemISBN ==null)
		itemISBN = "";
	
	if(!itemISBN.equals("")){
		if(!querySearch.equals(""))
			querySearch = querySearch +" " +searchOpt3 +" itemISBN like '%" +itemISBN +"%' ";
		else
			querySearch = " itemISBN like '%" +itemISBN +"%' ";	
	}

	// Generate the search query
	if(queryOrderField ==null)
		queryOrderField ="";

	if (queryOrderType ==null)
		queryOrderType ="";

	if((queryOrderField.equals("")) || (queryOrderType.equals("")))
		queryOrder = " ORDER BY itemTitle ASC ";
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
      <center>
        <b>Search Items<br>
        </b>
      </center>
      <center>
        <%@ include file="printview.jsp" %>
<%
	queryParameter="&queryOrderField=" +queryOrderField +
		"&queryOrderType=" +queryOrderType +"&recDisplayNum=" +recDisplayNum;
%>
        <form name="form1" method="post" action="search_libraryitem.jsp?<%= queryParameter%>">
          <p>Limiting options:<br>
          </p>
          <table width="60%" border="0">
            <tr> 
              <td width="24%">Subject:</td>
              <td width="45%"> 
                <select name="itemSubject">
                  <option value="all" selected>All Subject</option>
                  <option value="Arts">Arts</option>
                  <option value="Anthropology">....Anthropology</option>
                  <option value="Journalism">....Journalism</option>
                  <option value="English Literature">....English Literature</option>
                  <option value="Media">....Media</option>
                  <option value="Music">....Music</option>
                  <option value="Theatre">....Theatre</option>
                  <option value="Visual Arts">....Visual Arts</option>
                  <option value="Business">Business</option>
                  <option value="CRM">....CRM</option>
                  <option value="Economics">....Economics</option>
                  <option value="Employment">....Employment</option>
                  <option value="HRM">....HRM</option>
                  <option value="Marketing">....Marketing</option>
                  <option value="Information Systems">....Information Systems</option>
                  <option value="Resource Management">....Resource Management</option>
                  <option value="Commerce">Commerce</option>
                  <option value="Accounting">....Accounting</option>
                  <option value="Banking">....Banking</option>
                  <option value="Finance">....Finance</option>
                  <option value="Law">....Law</option>
                  <option value="Computing">Computing</option>
                  <option value="Application">....Application</option>
                  <option value="Certify Exam">....Certify Exam</option>
                  <option value="Computer Graphics">....Computer Graphics</option>
                  <option value="Database">....Database</option>
                  <option value="Networking">....Networking</option>
                  <option value="Operating System">....Operating System</option>
                  <option value="Programming">....Programming</option>
                  <option value="Telecommunication">....Telecommunicaiton</option>
                  <option value="Web Development">....Web Development</option>
                  <option value="Education">Education</option>
                  <option value="Early Childhood">....Early Childhood</option>
                  <option value="Further Edu and Training">....Further Edu and Training</option>
                  <option value="Engineering and Surveying">Engineering and Surveying</option>
                  <option value="Agricultural">....Agricultural</option>
                  <option value="Civil">....Civil</option>
                  <option value="Electrical">....Electrical</option>
                  <option value="Mechanical">....Mechanical</option>
                  <option value="Science and Technology">Science and Technology</option>
                  <option value="Biology">....Biology</option>
                  <option value="Chemistry">....Chemistry</option>
                  <option value="Maths">....Maths</option>
                  <option value="Nursing">....Nursing</option>
                  <option value="Physics">....Physics</option>
                  <option value="Psychology">....Psychology</option>
                </select>
              </td>
             
            </tr>

              <td width="44%"> 
                <div align="center"> 
                  <input type="submit" name="Search" value="Search">
                </div>
              </td>
            </tr>
          </table>
          </form>
</center>

<% queryParameter="itemSubject=" +itemSubject +"&filterOpt1=" +filterOpt1 +
		"&itemMediaType=" +itemMediaType + "&filterOpt2=" +filterOpt2 +
		"&itemLanguage=" +itemLanguage +"&itemTitle=" +itemTitle +"&searchOpt1=" +searchOpt1 +
	 	"&itemCallNumber=" +itemCallNumber +"searchOpt2=" +searchOpt2 +
		"&itemKeyword=" +itemKeyword +"searchOpt3=" +searchOpt3 +"&itemISBN=" +itemISBN + 
		"&queryOrderField=" +queryOrderField +"&queryOrderType=" +queryOrderType;
%>
<form name="form2" method="post" action="search_libraryitem.jsp?<%= queryParameter%>">
        <input type="submit" name="Show" value="Show">
        <input type="text" name="recDisplayNum" maxlength="2" size="4" value="<%= recDisplayNum %>">
        records per page 
      </form>

<% queryParameter="itemSubject=" +itemSubject ;
  
%>

<form name='userList' action='./formprocess'>

        <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
          <tr> 
            <td width="2%"></td>
            <th width="36%" bgcolor="#D3DCE3"><b>Title*</b> <a href=search_libraryitem.jsp?&queryOrderField=itemTitle&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemTitle") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=search_libraryitem.jsp?&queryOrderField=itemTitle&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemTitle") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a> </th>
            <th width="21%" bgcolor="#D3DCE3"><b>Subject</b> <a href=search_libraryitem.jsp?&queryOrderField=itemSubject&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemSubject") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=search_libraryitem.jsp?&queryOrderField=itemSubject&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemSubject") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a> </th>
            <th width="13%" bgcolor="#D3DCE3"><b>Media</b> <a href=search_libraryitem.jsp?&queryOrderField=itemMediaType&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemMediaType") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=search_libraryitem.jsp?&queryOrderField=itemMediaType&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemMediaType") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a> </th>
            <th width="15%" bgcolor="#D3DCE3"><b>Lang</b> <a href=search_libraryitem.jsp?&queryOrderField=itemLanguage&queryOrderType=ASC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemLanguage") && queryOrderType.equals("ASC")) 
					out.println("<img src='icon_sort_up_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_up_off.gif' width='20' height='7' border='0'>");
				%>
              </a> <a href=search_libraryitem.jsp?&queryOrderField=itemLanguage&queryOrderType=DESC&<%= queryParameter%>> 
              <% if(queryOrderField.equals("itemLanguage") && queryOrderType.equals("DESC")) 
					out.println("<img src='icon_sort_down_on.gif' width='20' height='7' border='0'>");
					else
					out.println("<img src='icon_sort_down_off.gif' width='20' height='7' border='0'>");
				%>
              </a> </th>
            <th width="3%" bgcolor="#D3DCE3">Qty</th>
            <th width="3%" bgcolor="#D3DCE3"><b>Ava</b></th>
            <th width="3%" bgcolor="#D3DCE3">Bor</th>
            <th width="4%" bgcolor="#D3DCE3">Res</th>
          </tr>
          <% queryParameter="itemSubject=" +itemSubject; 

	// calculate the total record that will display for navigation
String queryCount = "SELECT count(*) FROM libraryitem" + queryCondition;
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
	query = "SELECT * FROM libraryitem" + queryCondition;
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
	    			if (rowCount % 2 == 0)
	       				out.println ("<tr bgcolor=#CCCCCC align=left><td>");
					else 
					out.println ("<tr bgcolor=#DDDDDD align=left><td>");		
					out.println("</TD><TD><a href='libraryitem_view.jsp?itemRecNumber=" +myResultSet.getString("itemRecNumber") +"'>" +myResultSet.getString("itemTitle") +"</a>");
					out.println("</TD><TD>" +myResultSet.getString("itemSubject"));
					out.println("</TD><TD>" +myResultSet.getString("itemMediaType"));
					out.println("</TD><TD>" +myResultSet.getString("itemLanguage"));
					out.println("</TD><TD>" +myResultSet.getString("itemTotQuantity"));
					out.println("</TD><TD>" +myResultSet.getString("itemTotAvailable"));
					out.println("</TD><TD>" +myResultSet.getString("itemTotBorrow"));
					out.println("</TD><TD>" +myResultSet.getString("itemTotReserve"));				
					out.println("</TD></TR>");
					rowCount = rowCount+1;					
				}
			} catch(SQLException sqle) {
				System.err.println("search_libraryitem.jsp Error connecting: " +sqle);		
			}
		} 
%>
        </table>
</form>

<br>
		</td>
  </tr>
</table>
<jsp:include page="footer.jsp" flush="true" />
<% connectionPool.closeAllConnections(); %>
</body>
</html>