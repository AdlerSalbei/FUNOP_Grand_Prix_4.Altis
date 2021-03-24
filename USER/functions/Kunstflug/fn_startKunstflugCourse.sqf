params ["_station", "_group"];

if !(isServer) exitWith {
	_this remoteExecCall ["GRAD_GrandPrix_fnc_startKunstflugCourse", 2];
};
if !(canSuspend) exitWith {_this spawn GRAD_GrandPrix_fnc_startKunstflugCourse;};

_station setVariable ["stationIsRunning", true, true];

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


private _heliClass = "B_Heli_Light_01_F";
private _spawnPos = getPosATL GRAD_Kunstflug_heliSpawn;

private _vehicle = createVehicle[_heliClass, _spawnPos, [], 0, "CAN_COLLIDE"];
_vehicle setDir 155.391;
_vehicle allowDamage false;
clearBackpackCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
// _vehicle addMagazineCargoGlobal ["rhsgref_296Rnd_792x57_SmK_alltracers_belt", 10];

{
	_x setVariable ["GRAD_Kunstflug_savedLoadout", getUnitLoadout _x, true];
	[_x] remoteExec ["removeAllWeapons", _x];
	[_x] remoteExec ["removeBackpack", _x];
	removeVest _x;
	removeHeadgear _x;

	_x addVest "V_Safety_orange_F";
	_x addHeadgear "H_Construction_earprot_orange_F";
	// [_x, "B_Messenger_IDAP_F"] remoteExec ["addBackpack", _x];
	[_x, "GrandPrix_LMG_Zafir_F"] remoteExec ["addWeapon", _x];
	[_x, "10000Rnd_762x54_Box_Tracer"] remoteExec ["addPrimaryWeaponItem", _x];
	// [_x, "rhsgref_296Rnd_792x57_SmK_alltracers_belt"] remoteExec ["addMagazine", _x];

} forEach (units _group);

["Mit dem Einschalten des Heli-Motors, läuft eure Zeit!"] remoteExec ["hint", (units _group) + [_nearestInstructor]];
waitUntil { isEngineOn _vehicle };

private _handle = [{
	_args params ["_vehicle"];

	if (alive _vehicle) then {
		[_vehicle, false] remoteExec ["allowDamage", _vehicle];
	} else {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
}, 2, [_vehicle]] call CBA_fnc_addPerFrameHandler;

["Die Zeit läuft!"] remoteExec ["hintSilent",(units _group) + [_nearestInstructor]];

{
	// Current result is saved in variable _x
	[_x, false] remoteExec ["allowDamage", _x];
} forEach (units _group);

[_group, _vehicle, _station] spawn GRAD_GrandPrix_fnc_manageKunstflugGates;
missionNamespace setVariable ["GRAD_KunstflugCurrentGroup", _group, true];
[_group] spawn GRAD_grandPrix_fnc_manageKunstflugTargets;


private _startTime = time;
[_group, _vehicle, _startTime, _station, _handle] spawn GRAD_grandPrix_fnc_manageKunstflugEnd;

["CantStop"] remoteExec ["playMusic", (units _group) + [_nearestInstructor]];