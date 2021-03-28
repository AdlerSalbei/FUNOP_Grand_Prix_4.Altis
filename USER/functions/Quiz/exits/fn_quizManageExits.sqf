params ["_unit"];

if !(isServer) exitWith { _this remoteExecCall ["GRAD_GrandPrix_fnc_quizManageExits", 2]; };

private _availableExits = missionNamespace getVariable ["GRAD_quizAvailableExits", []];
private _chosenExit = selectRandom _availableExits;
_availableExits deleteAt (_availableExits find _chosenExit);
missionNamespace setVariable ["GRAD_quizAvailableExits", _availableExits, true];

switch (_chosenExit) do {
	case "Yeeet": { [_unit] spawn GRAD_GrandPrix_fnc_quizYeeetExit; };
	case "Missile" : { [_unit] spawn GRAD_GrandPrix_fnc_quizMissileExit; };
	case "Pillar" : { [_unit] spawn GRAD_GrandPrix_fnc_quizFallingPillarExit; };
	case "ZSU" : { [_unit] spawn GRAD_GrandPrix_fnc_quizZSUExit; };
	case "Tractor": { [_unit] spawn GRAD_GrandPrix_fnc_quizTractorExit; };
};