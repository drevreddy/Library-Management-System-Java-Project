<%@ include file="common1.jsp" %>
<%@ page import="java.sql.*"%>
<%
String itemcallNumber = request.getParameter("itemcallnumber");
String itemsubject = request.getParameter("itemsubject");
String itemcategory = request.getParameter("itemcategory");
String itemmediatype = request.getParameter("itemmediatype");
String itemlanguage = request.getParameter("itemlanguage");
String itemrecNumber = request.getParameter("itemrecnumber");
String itemtitle = request.getParameter("itemtitle");
String itembriefDesc = request.getParameter("itembriefdesc");
String itemauthor = request.getParameter("itemauthor");
String itemkeyword= request.getParameter("itemkeyword");
String itempublishername= request.getParameter("itempublishername");
String itemisbn= request.getParameter("itemisbn");
String itemlength= request.getParameter("itemlength");
String itemyear= request.getParameter("itemyear");
int itemtotquantity= Integer.parseInt(request.getParameter("itemtotquantity"));
int itemtotavailable=Integer.parseInt(request.getParameter("itemtotavailable").trim());
int itemtotborrow= Integer.parseInt(request.getParameter("itemtotborrow"));
int itemtotreserve= Integer.parseInt(request.getParameter("itemtotreserve"));
int a =0;



ResultSet rs=st.executeQuery("select nvl(max(itemrecnumber),0) from libraryitem");

if(rs.next())
   a=rs.getInt(1) + 1;


PreparedStatement sst=null,sst1=null;
String cmd ="insert into libraryitem values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
sst=con.prepareStatement(cmd);


         
sst.setInt(1,a);
sst.setString(2,itemcallNumber);
sst.setString(3,itemcategory);
sst.setString(4,itemsubject);
sst.setString(5,itemmediatype);
sst.setString(6,itemlanguage);
sst.setString(7,itemtitle);
sst.setString(8,itembriefDesc);
sst.setString(9,itemauthor);
sst.setString(10,itemkeyword);
sst.setString(11,itempublishername);
sst.setString(12,itemisbn);
sst.setString(13,itemlength);
sst.setString(14,itemyear);
sst.setInt(15,itemtotquantity);
sst.setInt(16,0);
sst.setInt(17,itemtotavailable);
sst.setInt(18,0);


int eff=sst.executeUpdate();
out.println(itemtotavailable);

if(eff>0)
{  out.println("record Stored");
%>
   <a href="libraryitem_list.jsp"> Back </a>
<%
}

%>
