


waituntil {not isNull player};
if ("ItemMap" in assignedItems player) exitWith {};
player linkItem "ItemMap";
waituntil {time > 0};
player unlinkItem "itemMap";