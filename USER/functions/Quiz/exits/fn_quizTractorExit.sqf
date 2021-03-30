params ["_unit"];

if !(canSuspend) exitWith { _this spawn GRAD_GrandPrix_fnc_quizTractorExit; };

private _walls = [GRAD_quiz_tractorWall_1, GRAD_quiz_tractorWall_2, GRAD_quiz_tractorWall_3, GRAD_quiz_tractorWall_4];

// missionNamespace setVariable ["GRAD_quiz_yeetStarted", false, true];

private _playerPos = getPos GRAD_quiz_tractorTarget;
_unit setPos _playerPos;
_unit setDir (_unit getDir GRAD_quiz_tractorSpawn);

// _unit spawn {
// 	while { !(missionNamespace getVariable ["GRAD_quiz_yeetStarted", false]) } do {
// 		_this setVelocity [0,0,0];
// 	}
// };

{
	// Current result is saved in variable _x
	_x hideObjectGlobal false;
} forEach _walls;

sleep 2;

private _tractorPos = getPos GRAD_quiz_tractorSpawn;
_tractorPos set [2, -3];
// private _tractorArr = [[0,0,20], _tractorPos getDir _unit, "C_Tractor_01_F", civilian] call BIS_fnc_spawnVehicle;
private _tractor = createVehicle ["C_Tractor_01_F", _tractorPos, [], 0, "CAN_COLLIDE"];
_tractor setDir (_tractorPos getDir _unit);
private _group = createVehicleCrew _tractor;
private _crew = driver _tractor;
_tractorArr = [_tractor, _crew, _group];

{
	// Current result is saved in variable _x
	[_x, false] remoteExec ["allowDamage", _x];
	_x enableSimulationGlobal false;
} forEach [_crew, _tractor];

[{ 
	_args params ["_tractorArr", "_tractorPos"];
	_tractorArr params ["_tractor", "_crew", "_group"];

	_tractor setPosATL _tractorPos;
	_tractorPos set [2, (_tractorPos#2) + 0.04];	

	if (((getPosATL _tractor)#2) >= 0.1) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

 }, 0, [_tractorArr, _tractorPos]] call CBA_fnc_addPerFrameHandler;

waitUntil { ((getPosATL _tractor)#2) >= 0 };

{
	// Current result is saved in variable _x
	_x enableSimulationGlobal true;
} forEach [_crew, _tractor];

sleep 3;
_tractor engineOn true;
sleep 4;

// missionNamespace setVariable ["GRAD_quiz_yeetStarted", true, true];

_tractor setVelocity ((getPos _tractor) vectorFromTo (getPos _unit) vectorMultiply 150);
{
	// Current result is saved in variable _x
	_x hideObjectGlobal true;
} forEach _walls;

private _timeout = serverTime + 20;
waitUntil { (((getPosASL _tractor)#2) < 5) || !(alive _tractor) || (serverTime > _timeout)};

{
	deleteVehicle _x;
} forEach [_crew, _tractor];

[_unit] call GRAD_GrandPrix_fnc_quizAfterExit;