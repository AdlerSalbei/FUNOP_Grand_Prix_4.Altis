params ["_marker"];

private _racers = allUnits inAreaArray _marker;

["grad_grandPrix_race_triggerCountdown", [], _racers] call CBA_fnc_targetEvent;