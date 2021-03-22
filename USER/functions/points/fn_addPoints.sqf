if !(isServer) exitWith {_this remoteExecCall ["grad_grandPrix_points_fnc_addPoints", 2];};

params ["_group", "_points", "_stage"];

private _groupName = [_group] call grad_grandPrix_fnc_getGroup;

private _groupStats = missionNamespace getVariable [_groupName, []];

_groupStats params ["_overallPoints", "_stages"];
_stages pushBack [_stage, _points];
_overallPoints = _overallPoints + _points;

missionNamespace setVariable [_groupName, [_overallPoints, _stages]];