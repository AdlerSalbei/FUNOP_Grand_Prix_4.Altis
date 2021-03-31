params ["_vehicle"];

private _unit = driver _vehicle;

if !((_unit getVariable ["grad_grandPrix_race_timerID", -1]) isEqualTo -1) exitWith {};

private _id = [] call grad_grandPrix_fnc_startTimer;
_unit setVariable ["grad_grandPrix_race_timerID", _id, true];

["grad_grandPrix_race_driversUp", [_unit]] call CBA_fnc_serverEvent;

playMusic "nightOfFire";
[{
	playMusic "90s";
}, [], 315] call CBA_fnc_waitAndExecute;

_vehicle allowDamage false;
_unit allowDamage false;

