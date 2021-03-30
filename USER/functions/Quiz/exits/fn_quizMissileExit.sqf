params ["_unit"];

if !(canSuspend) exitWith { _this spawn GRAD_GrandPrix_fnc_quizMissileExit; };


private _pos = getPos _unit;
// _pos set [2, (_pos#2) + 0.1];
// _unit setPos _pos;
// _unit setVelocity [0,0,45];

// waitUntil { ((velocity _unit) # 2) <= 0 };

// _unit spawn {
//   while { !(missionNamespace getVariable["GRAD_quiz_Exits_bombExploded", false]) } do {
//     _this setVelocity [0,0,0];
//   };
// };

[GRAD_quiz_VLS, _unit, 0, "magazine_Missiles_Cruise_01_x18", 1] call zen_common_fnc_fireArtillery;

sleep 6;
_pos set [2, (_pos#2) + 0.1];
_unit setPos _pos;
[_unit, [0,0, 55]] remoteExec ["setVelocity", _unit];
// _unit setVelocity [0,0,55];

waitUntil { (((getPosASL _unit) # 2) <= 0) || (isTouchingGround _unit)  };

sleep 2;

[_unit] call GRAD_GrandPrix_fnc_quizAfterExit;