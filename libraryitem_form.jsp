	<jsp:include page="header_admin.jsp" flush="true"/>
<body bgcolor="#0099ff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="item_form" method="post" action="proudct.jsp">
  * Require to fill out<br><br>
  <table width="100%" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td width="31%">ItemCall Number</td>
      <td width="69%"> 
        <p> 
          <input type="text" name="itemcallnumber" maxlength="10" size="12">
        </p>
      </td>
    </tr>
	
	<tr> 
      <td width="31%">Subject*</td>
      <td width="69%"> 
        <select name="itemsubject">
          <option value="">&nbsp;</option>
          <option value="Arts">Arts</option>
          <option value="Anthropology">....Anthropology</option>
        </select>
        <input type='text' name='itemcategory' value=''>
      </td>
    </tr>
    <tr> 
      <td width="31%">Media*</td>
      <td width="69%"> 
        <select name=itemmediatype>
          <option value="">&nbsp;</option>
          <option value="Book">Book</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="31%">Language*</td>
      <td width="69%"> 
        <select name=itemlanguage>
          <option value="">&nbsp</option>
          <option value="English" >English</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="31%"> </td>
    </tr>
    <tr> 
      <td width="31%">Call Number</td>
      <td width="69%"> 
<input type='text' name='itemcallnumber' value=''>;
      </td>
    </tr>
    <tr> 
      <td width="31%"> Title*</td>
      <td width="69%"> 
        <textarea name="itemtitle" cols="50" rows="3"></textarea>
      </td>
    </tr>
    <tr> 
      <td width="31%">Brief Description</td>
      <td width="69%"> 
        <textarea name="itembriefdesc" cols="50" rows="4"></textarea>
      </td>
    </tr>
    <tr> 
      <td width="31%">Author</td>
      <td width="69%"> 
        <textarea name="itemauthor" cols="50" rows="4"></textarea>
      </td>
    </tr>
    <tr> 
      <td width="31%">Keyword*</td>
      <td width="69%"> 
        <textarea name="itemkeyword" cols="50" rows="2"></textarea>
      </td>
    </tr>
    <tr> 
      <td width="31%">Publisher Name</td>
      <td width="69%"> 
        <input type="text" name="itempublishername" size="32" maxlength="30">
      </td>
    </tr>
    <tr> 
      <td width="31%" height="32">ISBN</td>
      <td width="69%" height="32"> 
        <input type="text" name="itemisbn" size="17" maxlength="15" >
      </td>
    </tr>
    <tr> 
      <td width="31%">Length</td>
      <td width="69%"> 
        <input type="text" name="itemlength" maxlength="6" size="8" >
        Hour(s) or Page(s)</td>
    </tr>
    <tr> 
      <td width="31%">Year</td>
      <td width="69%"> 
        <input type="text" name="itemyear" maxlength="4" size="6" >
      </td>
    </tr>
    <tr> 
      <td width="31%">Total Quantity*</td>
      <td width="69%"> 
        <input type="text" name="itemtotquantity">
      </td>
    </tr>
    <tr> 
      <td width="31%">Total Available*</td>
      <td width="69%"> 
        
	<input type="text" name="itemtotavailable">
      </td>
    </tr>
    <tr> 
      <td width="31%">Total Borrow Out</td>
      <td width="69%"> 
  	<input type="text" name="itemtotborrow"> 
      </td>
    </tr>
    <tr> 
      <td width="31%">Total Reserve*</td>
      <td width="69%"> 

<input type='text' name='itemtotreserve'>


      </td>
    </tr>
  </table>
  <p> 
    <input type="submit" name="Submit" value="Submit">
    <input type="reset" name="Reset" value="Reset">
  </p>
</form>
        