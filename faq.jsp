<%@ include file="common.jsp" %>
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
        <b><a name="top"></a>Frequently Asked Questions (FAQs) </b> 
      </center>
      <p><img height=1 alt="" src="line_blu.gif" 
width="100%" border=0><br>
      </p><table cellspacing=5 cellpadding=5 width=620 border=0>
        <tbody> 
        <tr valign=top> 
          <td width=30><img height=8 alt="" 
      src="1ptrans.gif" width=30 border=0></td>
          <td width=590> 
            <ul type=square>
              <li><a href="faq_member_policy.jsp">Membership policies</a> 
              <li><a href="faq_library_open_hours.jsp">Library open hours</a> 
              <li><a href="faq_reservation_item.jsp">Reservation of library items</a> 
              <li><a href="faq_apply_membership.jsp">Apply for membership</a>
            </ul>
          </td>
        </tr>
        </tbody>
      </table>
      <a name=Policy></a><img height=1 alt="" src="line_blu.gif" 
width="100%" border=0><br>
    </td>
  </tr>
</table>
<jsp:include page="footer.jsp" flush="true" />
</body>
</html>