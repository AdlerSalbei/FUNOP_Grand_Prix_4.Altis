/*
 * Author: DerZade
 * Cancels the game of a given station.
 *
 * Arguments:
 * 0: Station object <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_station] call grad_grandPrix_fnc_gottesFinger_cancel;
 *
 * Public: No
 */
#include "script_component.hpp"

params [["_station", objNull, [objNull]]];

if (isNull _station) exitWith { throw "_station must not be null"; };

if !(isServer) exitWith {
	_this remoteExecCall [QFUNC_CUSTOM(cancel), 2];
};

private _running = _station getVariable [QGVAR(running), false];
private _group = _station getVariable [QGVAR(group), grpNull];
private _timer = _station getVariable [QGVAR(timer), ""];

if (count _timer > 0) then {
	[_timer] call grad_grandPrix_fnc_stopTimer;
};

_station setVariable [QGVAR(group), nil, true];
_station setVariable [QGVAR(running), nil, true];
_station setVariable [QGVAR(timer), nil, true];