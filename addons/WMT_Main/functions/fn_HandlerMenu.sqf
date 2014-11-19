/*
 	Name: WMT_fnc_HandlerMenu
 	
 	Author(s):
		Ezhuk

 	Description:
		Handler function for main menu
	
	Parameters:
		0 - STR: type of event
		1 - ARRAY: argument from event
 	
 	Returns:
		BOOL: for standart handlers 
*/
#include "defines.sqf"
		
PR(_event) = _this select 0;
PR(_arg) = _this select 1;
PR(_return) = false;

switch (_event) do 
{
	case "init": {	
		PR(_dialog) = _arg select 0;
		uiNamespace setVariable ["WMT_Dialog_Menu", _dialog];
		if(serverCommandAvailable('#kick')) then {
			
			(_dialog displayCtrl IDC_MENU_ADMIN) ctrlSetText localize 'STR_WMT_AdminPanel';
		};
		if ( WMT_pub_frzState < 3 && (leader player == player || serverCommandAvailable('#kick')) ) then {
			(_dialog displayCtrl IDC_MENU_TEAM_READY) ctrlShow true;
			(_dialog displayCtrl IDC_MENU_TEAM_NOT_READY) ctrlShow true;
		} else {
			(_dialog displayCtrl IDC_MENU_TEAM_READY) ctrlShow false;
			(_dialog displayCtrl IDC_MENU_TEAM_NOT_READY) ctrlShow false;
		};

		if(isNil "WMT_global_EnableConsole") then {
			// 							[STELS]Zealot,			[TF]nkey
			WMT_global_EnableConsole = 	["76561198015283887", 	"76561198043905076"];
		};
		
		if (!((getPlayerUID player) in WMT_global_EnableConsole) && !serverCommandAvailable('#kick')) then {
			(_dialog displayCtrl IDC_MENU_CONSOLE) ctrlShow false;
		};
	};
	case "teamready" :{
		closeDialog 0;
		[] call WMT_fnc_FreezeVoteStart;
	};
	
	case "teamnotready" : {
		closeDialog 0;
		[] call WMT_fnc_FreezeVoteWait;
	};
	
	case "close": {
		uiNamespace setVariable ["WMT_Dialog_Menu", nil];
	};
	case "options": {
		closeDialog 0;
		createDialog "RscWMTOptions";
	};
	case "admin": {
		closeDialog 0;
		if(serverCommandAvailable('#kick')) then {
			createDialog "RscWMTAdminPanel";
		}else{
			createDialog "RscWMTFeedback";
		};
	};
	case "console": {
		closeDialog 0;
		createDialog "RscDisplayDebugPublic";
	};
};
_return