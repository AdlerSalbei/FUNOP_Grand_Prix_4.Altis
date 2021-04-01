#define BEST_AVERAGE 65

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
_allDistances deleteAt 0;
private _sum = 0;
{
	_sum = _sum + _x;	
} forEach _allDistances;
private _averageDistance = _sum / (count _allDistances);
private _points = (round((BEST_AVERAGE / _averageDistance) * 1000)) min 1000;
[_group, _points, "Demolition Dart"] call grad_grandPrix_fnc_addPoints;

private _result = format[
	"Ihr wart durchschnittlich %1m vom Ziel entfernt. Damit habt ihr euch %2 Punkte erspielt!",
	round _averageDistance,
	_points
];

[_result] remoteExec ["hint", (units _group) + [_nearestInstructor]];
{
	// Current result is saved in variable _x
	[_x, false] remoteExec ["allowDamage", _x];
} forEach (units _group);

_station setVariable ["stationIsRunning", false, true];