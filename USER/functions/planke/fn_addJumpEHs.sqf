params ["_unit"];

if !((_unit getVariable ["Grad_grandPrix_plank_pullhight", -1]) isEqualTo -1) exitWith {};

[_unit, "GetInMan", {
	params ["_unit"];

	_unit removeEventHandler ["GetInMan", _thisID];
	_unit setVariable ["Grad_grandPrix_plank_pullhight", (getPosASL _unit) select 2];

	["grad_grandPrix_plank_jumpersUp", [_unit]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addBISEventHandler;

[_unit, "GetOutMan", {
	params ["_unit"];

	_unit removeEventHandler ["GetOutMan", _thisID];
	[_unit] call grad_grandPrix_fnc_jumpResults;

	["grad_grandPrix_plank_jumpersDown", [_unit]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addBISEventHandler;

["grad_grandPrix_plank_jumpersUp", [_unit]] call CBA_fnc_serverEvent;

playMusic "hinunter_bis_auf_eins";