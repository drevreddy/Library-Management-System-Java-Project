<script language=JavaScript 
src="toolbar.js">
</script>
<script language=JavaScript 
src="globalMNP.js">
</script>
<script language=JavaScript 
src="localMNP_admin.js">
</script>
<script language=JavaScript>
drawToolbar();
</script>
<script language=JavaScript 
src="hpmain.js">
</script>

<link href="ksrm.cdf" rel="stylesheet">
<%@ include file="common1.jsp" %>

<%@ page import="java.sql.*"%>
<%
	ResultSet rs=null;
 %>
 <script>
 function getMessage(val) {
 styles="<link href='ksrm.cdf' rel='stylesheet'><title>Message</title>"
 nwin=open("","","scrollbars=yes,width=500 height=300,left=120,top=200");
 nwin.document.write(styles+"<p>"+document.getElementById('msgs'+val).innerHTML+"</p>");
 nwin.document.close();
 }
 </script>
<html xmlns=""><head>
<meta http-equiv="page-enter" content="blendTrans(duration=1)">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="0">


</head>
<body>


 <script type='text/javascript' src='JS/aexmplmenu_var.js'></script>
  <script type='text/javascript' src='JS/menu_com.JS'></script>

</div>

<br><br><br><br><br><br><br><br><br>
<BR>
<fieldset>
<legend>Messages From Administrator</legend><BR>
<%  String buff="";
    String head="";
	try {


	String cmd="Select * from admin_inbox ";
    st=con.createStatement();
    rs=st.executeQuery(cmd);
	int count=0;
	boolean rec=false;
	head+="<table align=center width=600 cellspacing=1 cellpadding=2 bgcolor=lightslategray><form method=post action=\"admin_deletemsgchecked.jsp\">";
	head+="<tr bgcolor=lightslategray><th style='color:aliceblue'>S.no</th><th style='color:aliceblue'>From</th><th style='color:aliceblue'>Subject</th><th style='color:aliceblue'>Date</th><th style='color:aliceblue'>Reply</th></tr>";
	while(rs.next()) {
        rec=true;
		count++;
		int id=rs.getInt("mid");
		String from=rs.getString("msg_from");
		String sub=rs.getString("msg_subject");
        String data=rs.getString("msg_data");
		sub=(sub!=null)?sub:"[&nbsp;None&nbsp;]";
		data=(data!=null)?data:"[&nbsp;No Message is Available&nbsp;]";
		java.text.SimpleDateFormat fmt=new java.text.SimpleDateFormat("dd-MMM-yyyy");
        String msgdate=fmt.format(rs.getDate("msg_date")).toString();
		buff+="<TR bgcolor=whitesmoke><TD>"+count+"</td>";
		buff+="<td><input name='from' value='"+id+"' type=checkbox class=check>"+from+"</td>";
		buff+="<Td><div id='msgs"+count+"' style='display:none'>"+data+"</div><a href='javascript:getMessage("+count+")'>"+sub+"</a></td>";
		buff+="<TD>"+msgdate+"</td><td> <a href='mail.jsp'>Reply</a></tr>";
	}
	if(buff.length()>0)	out.println(head+buff+"</table>");
	else out.println("<link href='ksrm.cdf' rel='stylesheet'><center><p>No Messages Found.Your Inbox Terminal is Empty</p></center>");
 }   catch(Exception e) {
   out.println("No Items Found"+e);
   }
%>
<table align=center width=600>
<tr><Td align=center><button type=submit accesskey="D"><u>D</u>elete Checked</button>
&nbsp;&nbsp;
</td></tr></table><BR></fieldset>
</body></html>
