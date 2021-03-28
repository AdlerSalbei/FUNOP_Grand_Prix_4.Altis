#define TIME_PER_TARGET 2
#define BEST_TIME 140

params ["_group", "_vehicle", "_startTime", "_station", "_handle"];

if !(canSuspend) exitWith {_this spawn GRAD_grandPrix_fnc_manageKunstflugEnd;};

waitUntil { (_group getVariable ["GRAD_KunstflugFinished", false]) && !(isEngineOn _vehicle) && ( _vehicle inArea[[5271.05,9819.14,0.5], 6, 6, 0, true, 5]) };

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

[[], {
	if (acex_volume_enabled) then {
		5 fadeMusic 0;
		waitUntil { isNull (objectParent player) };
		playMusic "";
	} else {
		5 fadeMusic 0;
	}
}] remoteExec ["spawn", (units _group) + [_nearestInstructor]];

private _timeTaken = time - _startTime;

private _allGates = missionNamespace getVariable ["GRAD_KunstflugGates", []];
private _allTargets = missionNamespace getVariable ["GRAD_KunstflugTargets", []];

{
	_x hideObjectGlobal true;		
} forEach _allGates;

{
	_x hideObjectGlobal true;
	_x removeAllEventHandlers "HitPart";
} forEach _allTargets;

private _targetsHit = _group getVariable ["GRAD_KunstflugTargetsHit", 0];
private _totalTime = _timeTaken - _targetsHit * TIME_PER_TARGET;
// private _points = (round((BEST_TIME/_totalTime) * 1000)) min 1000;
private _points = [_group, _totalTime, BEST_TIME, 1000, "Kunstflug"] call grad_grandPrix_fnc_addTime;
// private _pointsToAdd = [_group, _totalTime, 110, 1000, "Kunstflug"] call grad_grandPrix_fnc_addTime;

private _result = format[
	"Eure Flugzeit betrug %1. Dabei habt ihr %2 von %3 Zielen getroffen. Eure Gesamtzeit beträgt also %4. Damit habt ihr euch %5 Punkte erspielt!",
	[_timeTaken, "MM:SS"] call BIS_fnc_secondsToString,
	_targetsHit,
	count _allTargets,
	[_totalTime, "MM:SS"] call BIS_fnc_secondsToString,
	_points
];

[_result] remoteExec ["hint", (units _group) + [_nearestInstructor]];

waitUntil { count (crew _vehicle) <= 0 };

deleteVehicle _vehicle;
{
	_x setUnitLoadout (_x getVariable["GRAD_Kunstflug_savedLoadout", []]);
} forEach (units _group);

_station setVariable ["stationIsRunning", false, true];

sleep 5;
[""] remoteExec ["playMusic", (units _group) + [_nearestInstructor]];
[0, 1] remoteExec ["fadeMusic", (units _group) + [_nearestInstructor]];

{
	// Current result is saved in variable _x
	[_x, false] remoteExec ["allowDamage", _x];
} forEach (units _group);