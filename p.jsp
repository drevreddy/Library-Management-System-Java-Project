<%@page import="java.sql.*"%>
<%@ include file="common.jsp" %>
<%@ include file="dbconnect.jsp" %>
<%@ include file="common1.jsp" %>
<%@ include file="header_select.jsp" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="white"> 
    <td width="180" align="left" valign="top"> 
	  <%@ include file = "navi.jsp" %>
    </td>
        <TD width=1 bgColor=#999999><IMG height=1 alt="" 
      src="1ptrans.gif" 
      width=1 border=0></TD>
    <td valign="top" width="100%" bgcolor="#f1f1f1"> 
      <center>
        <b>Penality List<br>
        </b> 
      </center>
      <center>
</table>
<%
         try 
        {

      String title = "  ";

       out.println("<div style='position:absolute;left:280;top:120;'><p style='font-size:15px;font-family:tahoma;font-weight:bold;padding:5px;text-align:center;background:linen;color:maroon'> " +" " + title +"</p></div>");
	
       String ds;
         int iv;
         String data="SELECT ITEMCALLNUMBER,BORROWERID,BORROWDATE,DUEDATE,RETURNDATE,BORROWSTATUS,(sysdate-to_date(DUEDATE)),(sysdate-to_date(DUEDATE)) * .25  AS OVERDUEDAY FROM borrowrec where duedate < sysdate"; 
        
		  PreparedStatement pst=null;
		  ResultSet rs=null;
		  ResultSetMetaData meta=null;

          rs=(st!=null)?st.executeQuery(data):null;
 		  meta=(rs!=null)?rs.getMetaData():null;
		  int ct=0;
		  out.println("<BODY leftMargin=0 topMargin=0 rightMargin=0 bgColor= #bbe9ff><style>");
		  out.println("td {font-family:ms sans serif;color:black;font-size:12px:align=center;}");
		  out.println("th{font-family:ms sans serif;background:#D3DCE3;color:#D3DCE3;font-size:12px;}");
		  out.println("</style>");
		  out.println("<title>Reports Generation</title>");
          out.println("<table style='position:absolute;left:180;top:140;' width=750 border=0 bgcolor=#bbe9ff cellspacing=1 cellpadding=1");
          if(rs!=null) {out.println("  <tr bgcolor='#D3DCE3'>" );  
          for(int mt=1;mt<=meta.getColumnCount();mt+=1) 
          out.println("<Th bgcolor='#D3DCE3' nowrap>&nbsp;&nbsp;"+meta.getColumnName(mt).replace('_','-')+"&nbsp;&nbsp;</th>");
		  out.println("</TR>");} 
		  while(rs!=null && rs.next()) {
          ct++;out.println("  <tr bgcolor='#f1f1f1'> ");
		  for(int d=1;d<=meta.getColumnCount();d++) {
          String metaname=meta.getColumnTypeName(d).toLowerCase();
		  if(metaname.indexOf("varchar")!=-1) {
          ds=rs.getString(d);
          out.println("<td nowrap bgcolor=skyblue>&nbsp;&nbsp;&nbsp;"+ds+"&nbsp;</td>");}
		  else if(metaname.indexOf("date")!=-1) {
          ds=rs.getDate(d).toString();
          out.println("<td wrap bgcolor=skyblue>&nbsp;&nbsp;&nbsp;"+ds+"&nbsp;</td>");}
		  else {
          iv=rs.getInt(d);
          out.println("<td wrap bgcolor=skyblue>&nbsp;&nbsp;&nbsp;"+iv+"&nbsp;</td>");}
  		  }  out.println("</tr>");
  	      } 
out.println("<tr><td align=center colspan=15 bgcolor=whitesmoke><h2><a href=\"javascript:window.print()\"><font face=arial color=gray>Print The Reports</font></a></h2></center><br><hr size=1 color=gray><BR></td></table><br>");

          } 
catch (Exception e) 
{ out.println("<h1>Error Occured<BR>"+e);  }
 



%>