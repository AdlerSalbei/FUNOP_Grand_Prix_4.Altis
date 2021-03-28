if !(isServer) exitWith {_this remoteExecCall ["grad_grandPrix_fnc_addPoints", 2];};

params ["_group", "_points", "_stage"];

private _groupName = groupId _group;

private _groupStats = missionNamespace getVariable [_groupName, []];

_groupStats pushBack [_stage, _points];
// _stages pushBackUnique [_stage, _points];
// _overallPoints = _overallPoints + _points;

missionNamespace setVariable [_groupName, _groupStats, true];