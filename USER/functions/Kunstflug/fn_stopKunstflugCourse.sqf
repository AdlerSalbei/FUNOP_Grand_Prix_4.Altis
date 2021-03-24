params ["_group", "_vehicle", "_nearestInstructor", "_station"];

private _allTargets = missionNamespace getVariable ["GRAD_KunstflugTargets", []];
{
	// Current result is saved in variable _x
	[_x, "HitPart"] remoteExec ["removeAllEventHandlers"];
	_x hideObjectGlobal true;
} forEach _allTargets;

private _allGates = missionNamespace getVariable ["GRAD_KunstflugGates", []];
{
	// Current result is saved in variable _x
	_x hideObjectGlobal true;
} forEach _allGates;

deleteVehicle _vehicle;

sleep 0.5;

{
	// Current result is saved in variable _x
	_x setPos [5253.28,9828.01,0];
	hintSilent "";
} forEach (units _group);

{
	_x setUnitLoadout (_x getVariable["GRAD_Kunstflug_savedLoadout", []]);
} forEach (units _group);
[""] remoteExec ["playMusic", (units _group) + [_nearestInstructor]];

_station setVariable ["stationIsRunning", false, true];