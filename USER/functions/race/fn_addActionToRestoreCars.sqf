params ["_obj"];

private _action = [
	"race_action_3", 
	"Reset Cars", 
	"", 
	{
		[trigger_carReset] call grad_grandPrix_fnc_clearZone;
		{
			private _veh = createVehicle ["O_LSV_02_unarmed_F", _x, [], 0, "CAN_COLLIDE"];
			_veh setPos _x;
			_veh setDir 188.497;
		}forEach [
			[6495.82,2725.96,0],
			[6501.98,2726,0],
			[6508,2726.07,0],
			[6514.02,2726.02,0],
			[6520.02,2725.93,0]
		];
	},
	{true},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;