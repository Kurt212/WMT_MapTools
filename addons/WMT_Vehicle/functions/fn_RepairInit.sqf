/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Add list of squads and players to briefing 

*/
if (isNil "WMT_repairEnabled" or {WMT_repairEnabled == true}) then {
	[] call WMT_fnc_fieldrepair;
};