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
	
	//System Admin
	addICPMenu("AdminMenu", "Admin", "Admin", "");
	addICPSubMenu("AdminMenu", "User List", "user_list.jsp");
	addICPSubMenu("AdminMenu", "Library Item List", "libraryitem_list.jsp");
	addICPSubMenuLine("AdminMenu");
	addICPSubMenu("AdminMenu", "Borrow List", "borrow_list.jsp");
	addICPSubMenu("AdminMenu", "Reserve List", "reserve_list.jsp");
	addICPSubMenu("AdminMenu", "Penalty List", "p.jsp");	

	//Search
	addICPMenu("SearchMenu", "Search", "Search","search_libraryitem.jsp");
	
	//Operation
	addICPMenu("OperationMenu", "Operation", "Operation", "");
	addICPSubMenu("OperationMenu", "Borrow", "borrow.jsp");
	addICPSubMenu("OperationMenu", "Return", "return.jsp");
	addICPSubMenu("OperationMenu", "Mail Compose", "mail.jsp");
	addICPSubMenu("OperationMenu", "Inbox", "inbox.jsp");
	

}
