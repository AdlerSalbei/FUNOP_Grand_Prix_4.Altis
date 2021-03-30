params ["_unit"];

if !(canSuspend) exitWith { _this spawn GRAD_GrandPrix_fnc_quizBrrrtExit; };

private _unitPos = getPos _unit;
_unitPos set [2, (_unitPos#2) + 0.1];
_unit setPos _unitPos;
[_unit, [0,0, 16]] remoteExec ["setVelocity", _unit];
// _unit setVelocity [0,0, 16];

waitUntil { ((velocity _unit)#2) <= 0 };

[_unit] spawn {
	params ["_unit"];
	while { !(_unit getVariable ["ACE_isUnconscious", false]) } do {
		_unit setVelocity [0,0,0];
	};
};

private _pos = getPosATL GRAD_quiz_ZSUspawn;
private _zsu = createVehicle ["rhs_zsu234_aa", _pos, [], 0, "CAN_COLLIDE"];
private _crew = createVehicleCrew _zsu;
_zsu setDir (_zsu getDir _unit);
private _muzzle = (_zsu weaponsTurret [0])#0;

_pos = getPos _zsu; 
_pos set [2, (_pos#2) + 0.1];
_zsu setPos _pos;
private _vector = (vectorNormalized((getPos _zsu) vectorFromTo (getPos _unit))) vectorMultiply 12;
_zsu setVelocity [_vector#0, _vector#1, 41];

waitUntil { (abs((velocity _zsu)#0) <= 1) || (abs((velocity _zsu)#1) <= 1) };

_zsu reveal [_unit, 4];
(gunner _zsu) lookAt _unit;

sleep 3.5;

private _timeout = serverTime + 20;
while { !(_unit getVariable ["ACE_isUnconscious", false]) && (serverTime < _timeout) } do {
	[_zsu, _muzzle] call BIS_fnc_fire;
	sleep 0.1;
};

sleep 2;

_zsu setVelocity [(-(_vector#0)) * 1.3, (-(_vector#1)) * 1.3, 13];

waitUntil { ((getPosASL _zsu) # 2) < 50 };
{
	deleteVehicle _x;
} forEach ((units _crew) + [_zsu]);

[_unit] call GRAD_GrandPrix_fnc_quizAfterExit;