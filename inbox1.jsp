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
<link class="catg" href="ksrm.cdf" rel="stylesheet">
<%@ include file="common1.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

 <script>
 function getMessage(val) {
 styles="<link href='air.cdf' rel='stylesheet'><title>Message</title>"
 nwin=open("","","scrollbars=yes,width=500 height=300,left=120,top=200");
 nwin.document.write(styles+"<p>"+document.getElementById('msgs'+val).innerHTML+"</p>");
 nwin.document.close();
 }
 </script>
<html xmlns=""><head>
<meta http-equiv="page-enter" content="blendTrans(duration=1)">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<link class="catg" href="ksrm.cdf" rel="stylesheet">
</head>

<body >


<br><br>
<BR>
<fieldset>
<legend>Messages From Staff/Administrator</legend><BR>
<%  String buff="";
    String head="";
	try {

    st=con.createStatement();
	String cmd="select  * from user_inbox";
ResultSet    rs=st.executeQuery(cmd);
	head+="<table align=center width=600 cellspacing=1 cellpadding=2 bgcolor=lightslategray><form method=post action=\"userdelmsg.jsp\">";
	head+="<tr bgcolor=lightslategray><th style='color:aliceblue'>S.no</th><th style='color:aliceblue'>From</th><th style='color:aliceblue'>Subject</th><th style='color:aliceblue'>Date</th></tr>";
	int count=0;
	boolean rec=false;
	while(rs.next()) {
        rec=true;
		count++;
		int id=rs.getInt("mid");
		String from=rs.getString("user_name");
		String sub=rs.getString("msg_subject");
        String data=rs.getString("msg_data");
		from="Admin";
		sub=(sub!=null)?sub:"[&nbsp;None&nbsp;]";
		data=(data!=null)?data:"[&nbsp;No Message is Available&nbsp;]";
		java.text.SimpleDateFormat fmt=new java.text.SimpleDateFormat("dd-MMM-yyyy");
        String msgdate=fmt.format(rs.getDate("msg_date")).toString();
		buff+="<TR bgcolor=whitesmoke><TD>"+count+"</td>";
		buff+="<td><input name='from' value='"+id+"' type=checkbox class=check>"+from+"</td>";
		buff+="<Td><div id='msgs"+count+"' style='display:none'>"+data+"</div><a href='javascript:getMessage("+count+")'>"+sub+"</a></td>";
		buff+="<TD>"+msgdate+"</td></tr>";
	}
	if(buff.length()>0)	out.println(head+buff+"</table>");
	else out.println("<link href='air.cdf' rel='stylesheet'><center><p>No Messages Found.Your Inbox Terminal is Empty</p></center>");
    }   catch(Exception e) { out.println("No Items Found"+e); }
%>
<table align=center width=600>
<tr><Td align=center><button type=submit accesskey="D"><u>D</u>elete</button>
&nbsp;&nbsp;
</td></tr></table><BR></fieldset>
</body></html>
