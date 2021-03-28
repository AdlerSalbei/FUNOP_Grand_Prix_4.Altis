params ["_unit"];

if !(canSuspend) exitWith { _this spawn GRAD_GrandPrix_fnc_quizFallingPillarExit; };

private _allPositions = [getPos GRAD_quiz_position_1, getPos GRAD_quiz_position_2, getPos GRAD_quiz_position_3, getPos GRAD_quiz_position_4, getPos GRAD_quiz_position_5];

private _unitPos = _allPositions # 0;
{
	if ((_unit distance2D _x) < (_unit distance2D _unitPos)) then {
		_unitPos = _x;
	};
} forEach _allPositions;

_unitPos set [2, (_unitPos#2) + 250];

private _pillar = createVehicle ["Land_AncientPillar_F", _unitPos, [], 0, "CAN_COLLIDE"];
_pillar setVelocity [0, 0, -80];

waitUntil { isTouchingGround _pillar || ((getPosATL _pillar)#2) < 1 };

sleep 8;

deleteVehicle _pillar;

[_unit] call GRAD_GrandPrix_fnc_quizAfterExit;