params ["_station", "_group"];

{
	_x setVelocity [0,0,0];
	private _pos = (_station getRelPos [10, (getDir _station) + 180]) findEmptyPosition [0, 4.9, typeOf _x];
	_x setPos _pos;
	_x setVariable ["GRAD_DemolitionDart_roleChosen", false, true];
} forEach (units _group);

private _allInstructors = [];
{
	_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
} forEach allCurators;
private _nearestInstructor = objNull;
private _distance = _station distance (_allInstructors#0);
{
	if ((_station distance _x) < _distance) then {
		_distance = _station distance _x;
		_nearestInstructor = _x;
	}	
} forEach _allInstructors;

private _allDistances = missionNamespace getVariable ["GRAD_DemolitionDart_allDistances", []];
_allDistances sort false;
systemChat str _allDistances;
_allDistances deleteAt 0;
systemChat str _allDistances;
private _sum = 0;
{
	_sum = _sum + _x;	
} forEach _allDistances;
private _averageDistance = _sum / (count _allDistances);
private _points = 1000 - round(_averageDistance * 2);
[_group, _points, "Demolition Dart"] call grad_grandPrix_fnc_addPoints;

private _result = format[
	"Ihr wart durchschnittlich %1m vom Ziel entfernt. Damit habt ihr euch %2 Punkte erspielt!",
	round _averageDistance,
	_points
];

[_result] remoteExec ["hint", (units _group) + [_nearestInstructor]];

_station setVariable ["stationIsRunning", false, true];