if !(isServer) exitWith {_this remoteExecCall ["grad_grandPrix_fnc_getGroup", 2];};

params ["_group"];

private _groups = missionNamespace getVariable "grad_user_groups";
if (isNil "_groups") exitWith {systemChat "Error no groups";};

private _return = nil;

{
	_x params ["_name", "_member"];

	if (groupId _group isEqualTo _name) exitWith {
		_return = _group;
	};

	if (leader _group  in _member) exitWith {
		_return = _name;
	};
}forEach _groups;

_return