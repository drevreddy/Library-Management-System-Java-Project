<script language=JavaScript 
src="toolbar.js">
</script>
<script language=JavaScript 
src="globalMNP.js">
</script>
<script language=JavaScript 
src="localMNP_borrower.js">
</script>
<script language=JavaScript>
drawToolbar();
</script>
<script language=JavaScript 
src="hpmain.js">
</script>

<link href="ksrm.cdf" rel="stylesheet">
<%@page import="java.sql.*"%>
<%@ include file="common1.jsp" %>
<html xmlns=""><head>

<meta http-equiv="page-enter" content="blendTrans(duration=1)">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>


<div style="position:absolute;left:50;top:50;">
</div>
<br><br><br><br><br><br><br>

<fieldset>
<legend>Send Message</legend>
<br><table width=600 align=center cellspacing=0 cellpadding=3><form method=post action="sendto.jsp">
<TR><TD align=right>From:</td><Td><input name=from readonly value='<%=session.getValue("login")%>'style='width:350px'></td></tr>
<TR><TD align=right>To:</td><td><input type=hidden value='admin_inbox' name=table><select name=to style='width:350px'>
<%  
try {
  String uname="Admin";
 out.println("<option value='"+uname+"'>ksrm Administrator</option>");
	ResultSet rs = st.executeQuery("select * from libuser");
	String un=null;
	while(rs.next())
{un = rs.getString(2);
	  out.println("<option value='"+ rs.getString(1) +"'>" + un + "</option>");
}
}
 catch(Exception e) 
{
	out.println("<option value='null'>Error Occured or No Users Found</option>");}
%>
</td></tr>
<TR><TD align=right>Subject:</td><td>
<select name=subject style='width:350px'>
<option> Mail </option>
<option> Question </option>
<option> Clarification </option>
</select>
</td></tr>
<TR><Td align=right valign=top>Message:</td><td><textarea name=message rows=5 cols=50 wrap=off style='width:350px;font-family:tahoma;font-size:11px;font-weight:bold;color:lightslategray;border:1px solid gray;background:honeydew;overflow:auto'></textarea></td></tr>
<tr><td colspan=2 align=center><button type=submit>Send It !</button>&nbsp;&nbsp;<button type=reset>Refresh</button></td></tr>
</form></table><br></fieldset></body></html>
