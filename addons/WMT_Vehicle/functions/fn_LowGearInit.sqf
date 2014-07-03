/*
 	Name: 
 	
 	Author(s):
		Ezhuk

 	Description:
		

*/
/*
	Low gear action
*/
if (isDedicated) exitwith {};

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyDown",
{_key =_this select 1;
if(_key in actionKeys "carForward" or _key in actionKeys "carForward" or _key in actionKeys "carFastForward" or _key in actionKeys "carSlowForward")  then {wmt_carforward = true;};
}];
(findDisplay 46) displayAddEventHandler ["KeyUp"  , {_key =_this select 1;
if(_key in actionKeys "carForward" or _key in actionKeys "carForward" or _key in actionKeys "carFastForward" or _key in actionKeys "carSlowForward")  then {wmt_carforward = false;};
}];





Func_LowGear = {
	private["_min","_max","_veh","_vecorS"];
	_veh = vehicle player;
	_vecorS = 1.8;
	_min = 20;
	_max = 35;

	if((["MBT",str(typeOf _veh)] call BIS_fnc_inString) || (["APC",str(typeOf _veh)] call BIS_fnc_inString) )then{
		_vecorS = 1.5;
		_min = 15;
		_max = 25;
	};
	if(Local_LowGearOn)exitWith{};

	Local_LowGearOn = true;
	while {(player==(driver _veh)) && (Local_LowGearOn) && (canMove _veh) && (isEngineOn _veh) } do
	{
		private ["_speed","_vel","_dir"];
		_speed = speed _veh;
		_vel   = velocity _veh;
		_dir  = direction _veh;

		if (_speed < _min) then
		{
			if (wmt_carforward) then
			{
				if ( _speed >= -1 && _speed <= 0.5) then
				{			
					_vel= [(sin _dir)*_vecorS, (cos _dir)*_vecorS, 0];
					_veh setVelocity _vel;
				}else{
					if (_speed >0.5) then
					{		
						_vel=[(_vel select 0)*1.15,(_vel select 1)*1.15,(_vel select 2)*1.1];
						_veh setVelocity _vel;
					}else{
						if ( _speed <=-3 && _speed > -20) then
						{		
							_vel= [(_vel select 0)*0.99, (_vel select 1)*0.99, (_vel select 2)*0.99];
							_veh setVelocity _vel;
						}else{
							if ( _speed >=-3 && _speed<-1) then
							{		
								_vel= [0, 0, 0];
								_veh setVelocity _vel;
							};
						};
					};
				};
			};		
		}
		else
		{	
			if (_speed > _max) then
			{		
			_vel=[(_vel select 0)*0.95,(_vel select 1)*0.95,(_vel select 2)*0.95];
			_veh setVelocity _vel;
			}else{
				_vel=[(_vel select 0)*1.1,(_vel select 1)*1.1,(_vel select 2)*1.1];
			};
		};
		if((getPosASL _veh select 2) - (getPosATL _veh select 2) < -2) then {
			Local_LowGearOn = false;
		};
		sleep 0.1;
	};

	Local_LowGearOn = false;
};


Func_LowGearCond = {
	private ["_res","_veh"];
	_veh = vehicle player;
	_res = false;

	if(!Local_LowGearOn)then{
		if(player != _veh && player==(driver _veh))then{
			if(alive player && alive _veh && canMove _veh && isEngineOn _veh)then{
				if((["APC",str(typeOf _veh)] call BIS_fnc_inString) || (["MBT",str(typeOf _veh)] call BIS_fnc_inString) || (["Truck",str(typeOf _veh)] call BIS_fnc_inString) || (["MRAP",str(typeOf _veh)] call BIS_fnc_inString) || (["Offroad",str(typeOf _veh)] call BIS_fnc_inString))then{
					if( (getPosASL _veh select 2) - (getPosATL _veh select 2) > -2) then {
						if( (abs (speed _veh)) < 25)then{
							_res = true;
						};
					};
				};
			};
		};
	};
	_res
};

Local_LowGearOn = false;
player addAction[ format ["<t color='#ff0000'>%1</t>", (localize "STR_ACTION_LOWGEARON") ], Func_LowGear, [], 1, false, false, '','[] call Func_LowGearCond'];
player addAction[ format ["<t color='#ff0000'>%1</t>", (localize "STR_ACTION_LOWGEAROFF")], {Local_LowGearOn=false;}, [], 1, false, false, '','Local_LowGearOn'];

