params ["_obj"];

private _action = [
	"race_action_1", 
	"Start Race", 
	"", 
	{["race_marker_1"] call grad_grandPrix_fnc_startRace;},
	{true},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

private _action = [
	"race_action_2", 
	"Reset Race", 
	"", 
	{[] call grad_grandPrix_fnc_resetRace;},
	{true},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;