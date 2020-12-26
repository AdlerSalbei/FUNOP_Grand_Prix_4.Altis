if !(isServer) exitWith {};

if (serverTime < 60) exitWith {
	[{[] call grad_user_points_fnc_initGroup}, [], 60] call CBA_fnc_waitAndExecute;
};

private _groups = [];

{
	private _player = _x;

	//Exclude Zeus
	//if !() then {
		
		//Structur groups
		private _bool = false;

		{
			_x params ["_name", "_member"];
			if (groupId group _player isEqualTo _name) exitWith {
				_member pushBackUnique _player;
				_groups set [_forEachIndex, [_name, _member]];
				_bool = true;
			};
		}forEach _groups;

		if !(_bool) then {
			_groups pushBack [(groupId group _player), [_player]];
		};
	//}
}forEach allPlayers;

missionNamespace setVariable ["grad_user_groups", _groups];
