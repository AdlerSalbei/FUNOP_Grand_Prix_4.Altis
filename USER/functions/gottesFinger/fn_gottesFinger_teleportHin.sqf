params ["_target"];

private _action = [
    "teleport_toZeus",
    "Gottes Finger",
    "",
    {
		cutText ["", "BLACK", 0.1];

		[{
			params ["_unit"];

			playSound "jumpTPSound";
			_unit setPos ((getPosATL tpGottesFinger) vectorAdd [(random 6) -4, (random 6) -4, 0]);
			
			cutText ["", "BLACK IN", 3];
		},[_player], 0.3] call CBA_fnc_waitAndExecute;
	},
    {true}
] call ace_interact_menu_fnc_createAction;

[_target, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;