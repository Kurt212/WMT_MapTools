#include "resource\RscResourse.h"
#include "resource\CfgModuls.h"
#include "resource\CfgFunctions.h"
#include "resource\RscWMTMainMenu.h"
#include "resource\RscWMTOptions.h"
#include "resource\RscWMTAdminPanel.h"
#include "resource\RscWMTFeedback.h"
#include "resource\RscWMTChooseMarker.h"

class CfgPatches
{
	class WMT_Main
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_UI_F"};
		author[] = {"Ezhuk","Zealot"};
		authorUrl = "https://github.com/iEzhuk/WMT_MapTools";
		version = 1.4.3;
		versionStr = "1.4.3";
		versionAr[] = {1,4,3};
	};
};

class CfgSounds
{
	sounds[] = {};
	class wmt_beep
	{
		name = "WMT Freeze end beep";
		sound[] = {"\wmt_main\sounds\beep.ogg", 1, 1};
		titles[]={};
	};
};

class CfgFactionClasses
{
	class WMT
	{
		displayName = "WMT";
		priority = 13;
		side = 7;
	};
};

class RscTitles {
	#include "resource\RscWMTDisableTI.h"
	#include "resource\RscWMTNameTag.h"
	#include "resource\RscWMTDogTag.h"
};