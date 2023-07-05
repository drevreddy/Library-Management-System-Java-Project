<%@ include file="common1.jsp" %>
<%@ page import="java.sql.*"%>
<%

String itemcallNumber = request.getParameter("itemcallnumber");
String reserverid = request.getParameter("reserverid");
String reserveremail = request.getParameter("reserveremail");
String reservecanceldate = "01-dec-08";
String reservestatus ="queue";

out.println(reserverid);

    java.text.SimpleDateFormat fmt=new java.text.SimpleDateFormat("dd-MMM-yyyy");
    String reservedate=fmt.format(new java.util.Date()).toString();


int a =0;


ResultSet rs=st.executeQuery("select nvl(max(RESERVERECNUMBER),0) from  reserverec");

if(rs.next())
   a=rs.getInt(1) + 1;


PreparedStatement sst=null,sst1=null;
String cmd ="insert into reserverec values (?,?,?,?,?,?,?,?)";
sst=con.prepareStatement(cmd);
         
sst.setInt(1,a);
sst.setString(2,itemcallNumber);
sst.setString(3,reserverid);
sst.setString(4,reserveremail);
sst.setString(5,reservedate);
sst.setString(6,reservecanceldate);
sst.setString(7,reservedate);
sst.setString(8,reservestatus);


int eff=sst.executeUpdate();


if(eff>0)
{  out.println("record Stored");
%>
   <a href="reservation_add.jsp"> Back </a>
<%
}


%>
