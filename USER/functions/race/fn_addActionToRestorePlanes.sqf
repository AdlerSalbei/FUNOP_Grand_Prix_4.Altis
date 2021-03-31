params ["_obj"];

private _action = [
	"race_action_3", 
	"Reset Planes", 
	"", 
	{
		[trigger_resetPlanes] call grad_grandPrix_fnc_clearZone;
		{
			private _veh = createVehicle ["C_Plane_Civil_01_racing_F", _x, [], 0, "CAN_COLLIDE"];
			_veh setPos _x;
			_veh setDir 116.152;
			_veh setVariable ["grad_gradPrix4_planePathNum", (_forEachIndex +1), true];
			_veh addEventHandler ["Local", { 
				params ["_entity", "_isLocal"];
				if (_isLocal) then {
				_entity allowDamage false;
				}; 
			}];
		}forEach [
			[8445.54,3997.17,0],
			[8452,4010,0],
			[8458,4022,0],
			[8464.03,4034,0],
			[8469.99,4046.01,0]
		];
	},
	{true},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;