var ToolBar_Supported = ToolBar_Supported ;
if (ToolBar_Supported != null && ToolBar_Supported == true)
{
	//To Turn on/off Instrumentation set DoInstrumentation = true/false.
	DoInstrumentation= false;

	// Customize default menu color - bgColor, fontColor, mouseoverColor
	setDefaultMSMenuColor("#000000", "white", "red");

	// Customize toolbar background color
	setToolbarBGColor("white");

	//***** Add Standard menus *****
	//SearchMenu
	addMSMenu("SearchMenu", "Search", "","");
	addMSSubMenu("SearchMenu", "Library Item", "search_libraryitem.jsp");					

	//MicrosoftMenu	
	addMSMenu("HelpMenu", "About This System","","");
	addMSSubMenu("HelpMenu","Designer: KSRMCE","");
	addMSSubMenuLine("HelpMenu");
	addMSSubMenu("HelpMenu","Contact","");


	addMSFooterMenu("�All rights reserved.", "");

}
