params ["_unit"];

if !(canSuspend) exitWith { _this spawn GRAD_GrandPrix_fnc_quizYeeetExit; };

// GRAD_quiz_Freedom hideObjectGlobal false;

{
	_x hideObjectGlobal false;
} forEach ((GRAD_quiz_Freedom getVariable "bis_carrierParts") apply {_x select 0});

_blub = getPos _unit;
_blub set [2, (getPos _unit)#2 + 0.1];
_unit setPos _blub;
[_unit, [0, 0, 15]] remoteExec ["setVelocity", _unit];
// _unit setVelocity [0,0,15];

waitUntil { ((velocity _unit) # 2) <= 0 };

[_unit, [-130, -130, 50]] remoteExec ["setVelocity", _unit];
// _unit setVelocity [-130, -130, 50];

waitUntil { _unit inArea GRAD_quiz_yeeetTrigger || ((_unit getVariable ["ACE_isUnconscious", false])) };

_bomb = createVehicle["SatchelCharge_Remote_Ammo", getPos _unit, [], 0, "CAN_COLLIDE"];
_bomb setDamage 1;

private _timeout = serverTime + 20;
waitUntil { (((getPosASL _unit) # 2) < 0) || (serverTime > _timeout) };

{
	_x hideObjectGlobal true;
} forEach ((GRAD_quiz_Freedom getVariable "bis_carrierParts") apply {_x select 0});


[_unit] call GRAD_GrandPrix_fnc_quizAfterExit;