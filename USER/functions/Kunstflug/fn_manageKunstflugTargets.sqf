params ["_group"];

private _allTargets = missionNamespace getVariable ["GRAD_KunstflugTargets", []];

if (count _allTargets == 0) exitWith { systemChat "No targets found!"; };
if !(canSuspend) exitWith {_this spawn GRAD_GrandPrix_fnc_manageKunstflugTargets;};

private _allInstructors = [];
{
	_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
} forEach allCurators;
private _nearestInstructor = objNull;
private _distance = ((units _group)#0) distance (_allInstructors#0);
{
	if ((((units _group)#0) distance _x) < _distance) then {
		_distance = ((units _group)#0) distance _x;
		_nearestInstructor = _x;
	}
} forEach _allInstructors;

_group setVariable ["GRAD_KunstflugTargetsHit", 0, true];

[[_allTargets], {
	params ["_allTargets"];
	{
		_x hideObject false;
		private _id = _x addEventHandler ["HitPart", {
			(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
			private _group = missionNamespace getVariable ["GRAD_KunstflugCurrentGroup", []];
			// systemChat format["shooterGroup: %1 | stationGroup: %2", group _shooter, _group];
			if ((group _shooter) isEqualTo _group) then {
				// _target removeAllEventHandlers "Hit";
				[_target, "HitPart"] remoteExec ["removeAllEventHandlers"];
				private _targetsHit = _group getVariable ["GRAD_KunstflugTargetsHit", 0];
				_targetsHit = _targetsHit + 1;
				_group setVariable ["GRAD_KunstflugTargetsHit", _targetsHit, true];
				[_target, true] remoteExec ["hideObjectGlobal", 2];
			};
		}];
	} forEach _allTargets;
}] remoteExecCall ["BIS_fnc_call", (units _group) + [_nearestInstructor]];