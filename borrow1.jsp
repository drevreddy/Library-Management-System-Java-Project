<%@ include file="common1.jsp" %>
<%@ page import="java.sql.*"%>

<%
String sid= request.getParameter("staffidborrow");
String icn = request.getParameter("itemcallnumber");
String bid=  session.getValue("bb").toString();
String bid1= request.getParameter("borroweremail");


out.println(bid);
String bdate= request.getParameter("borrowdate");
String duedate= request.getParameter("duedate");

    java.text.SimpleDateFormat fmt=new java.text.SimpleDateFormat("dd-MMM-yyyy");
    String msgdate=fmt.format(new java.util.Date()).toString();



int a =0;

ResultSet rs=st.executeQuery("select nvl(max(BORROWRECNUMBER),0) from borrowrec");

if(rs.next())
   a=rs.getInt(1) + 1;


PreparedStatement sst=null,sst1=null;
String cmd ="insert into borrowrec values (?,?,?,?,?,?,?,?,?,?)";
sst=con.prepareStatement(cmd);

        
sst.setInt(1,a);
sst.setString(2,icn);
sst.setString(3,sid);
sst.setString(4,null);
sst.setString(5,bid);
sst.setString(6,bid1);
sst.setString(7,msgdate);
sst.setString(8,"24-nov-08");
sst.setString(9,null);
sst.setString(10,"borrowed");


int eff=sst.executeUpdate();


if(eff>0)
{  out.println("record Stored");
%>
   <a href="borrow.jsp"> Back </a>
<%
}



%>
