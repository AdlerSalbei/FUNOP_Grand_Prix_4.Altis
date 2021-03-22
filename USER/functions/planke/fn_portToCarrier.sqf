params ["_unit"];

if !(isPlayer _unit) exitWith {};

cutText ["", "BLACK", 0.1];

[{
	params ["_unit"];

	playSound "jumpTPSound";
	_unit setPos ((getPosATL plankeTP_oben) vectorAdd [(random 6) -4, (random 6) -4, 0]);

	_unit addBackpack "B_Parachute";
	_unit linkItem "ACE_Altimeter";
	_unit linkItem "ItemGPS";
	
	cutText ["", "BLACK IN", 3];
},[_unit], 0.3] call CBA_fnc_waitAndExecute;