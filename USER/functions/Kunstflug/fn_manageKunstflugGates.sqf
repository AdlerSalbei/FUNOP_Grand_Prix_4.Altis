params ["_group", "_vehicle", "_station"];


private _allGates = missionNamespace getVariable ["GRAD_KunstflugGates", []];

if (count _allGates == 0) exitWith { systemChat "No gates found!"; };
if !(canSuspend) exitWith {_this spawn GRAD_GrandPrix_fnc_startKunstflugCourse;};

private _allInstructors = [];
{
	_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
} forEach allCurators;
private _nearestInstructor = objNull;
private _distance = _vehicle distance (_allInstructors#0);
{
	if ((_vehicle distance _x) < _distance) then {
		_distance = _vehicle distance _x;
		_nearestInstructor = _x;
	}	
} forEach _allInstructors;

{

	private _trigger = createTrigger ["EmptyDetector", _x, false];
	if (_foreachIndex == (count(_allGates) - 1)) then {
		_trigger setTriggerArea [18, 18, getDir _x, true, 3];
	} else {
		_trigger setTriggerArea [18, 8, getDir _x, true, 18];
	};
	_trigger setPosASL (getPosASL _x);
	_trigger setTriggerActivation ["VEHICLE", "PRESENT", false];
	_trigger triggerAttachVehicle [_vehicle];
	_trigger setTriggerStatements ["this", "", ""];
	_trigger setTriggerInterval 0;
	_x hideObjectGlobal false;
	waitUntil { triggerActivated _trigger || !(alive _vehicle) };
	if !(alive _vehicle) exitWith { deleteVehicle _trigger; };
	[format['Tor %1 von %2 wurde passiert!', _foreachIndex + 1, count _allGates]] remoteExec ['hintSilent', (units _group) + [_nearestInstructor]];
	_x hideObjectGlobal true;
	
} forEach _allGates;

if !(alive _vehicle) exitWith {
	[_group, _vehicle, _nearestInstructor, _station] spawn GRAD_GrandPrix_fnc_stopKunstflugCourse;
};

['Alle Tore wurden passiert! Jetzt noch auf dem Heli-Pad landen und den Motor abschalten, dann wird die Uhr gestoppt!'] remoteExec ['hintSilent', (units _group) + [_nearestInstructor]];

_group setVariable ["GRAD_KunstflugFinished", true, true];