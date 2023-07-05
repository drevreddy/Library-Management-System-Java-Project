var ToolBar_Supported = ToolBar_Supported ;
if (ToolBar_Supported != null && ToolBar_Supported == true)
{
	//To Turn on/off Frame support, set Frame_Supported = true/false.
	Frame_Supported = false;

	// Customize default ICP menu color - bgColor, fontColor, mouseoverColor
	setDefaultICPMenuColor("#0099FF", "white", "red");
	
	// Customize toolbar background color
	//setToolbarBGColor("white");
	setBannerColor("#0099FF", "#0099FF", "White", "red");

	// display ICP Banner

	
	//Back to Home
	addICPMenu("Home Menu", "Home", "Home", "mainmenu.jsp");

	//Search
	addICPMenu("SearchMenu", "Search", "Search","search_libraryitem.jsp");
	
	//My Account
	addICPMenu("MyACMenu", "My Account","My Account", "");
	addICPSubMenu("MyACMenu", "Check My Account","myaccount.jsp");
	addICPSubMenuLine("MyACMenu");	
	addICPSubMenu("MyACMenu", "My Borrow List","my_borrow_list.jsp");

	addICPSubMenuLine("MyACMenu");
	addICPSubMenu("MyACMenu", "Add Reservatioin","reservation_add.jsp");	
	addICPSubMenu("MyACMenu", "My Reservatioin List","my_reservation_list.jsp");
	addICPSubMenu("MyACMenu", "Compose","mail1.jsp");	
	addICPSubMenu("MyACMenu", "Inbox","inbox1.jsp");


}
