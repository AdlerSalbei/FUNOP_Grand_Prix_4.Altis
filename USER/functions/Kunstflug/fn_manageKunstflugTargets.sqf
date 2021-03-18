params ["_group"];

private _allTargets = missionNamespace getVariable ["GRAD_KunstflugTargets", []];

if (count _allTargets == 0) exitWith { systemChat "No targets found!"; };
if !(canSuspend) exitWith {_this spawn GRAD_GrandPrix_fnc_manageKunstflugTargets;};

{
	_x hideObjectGlobal false;
} forEach _allTargets;

_group setVariable ["GRAD_KunstflugTargetsHit", 0, true];

{
	private _id = _x addEventHandler ["HitPart", {
		(_this select 0) params ["_target", "_shooter"];
		private _group = missionNamespace getVariable ["GRAD_KunstflugCurrentGroup", []];
		if ((group _shooter) isEqualTo _group) then {
			_target removeAllEventHandlers "HitPart";
			private _targetsHit = _group getVariable ["GRAD_KunstflugTargetsHit", 0];
			_targetsHit = _targetsHit + 1;
			_group setVariable ["GRAD_KunstflugTargetsHit", _targetsHit, true];
			_target hideObjectGlobal true;
		};
	}];

} forEach _allTargets;