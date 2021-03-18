/*
 * Author: DerZade
 * Start game at given station for given group
 *
 * Arguments:
 * 0: Station object <OBJECT>
 * 1: Group, which wants to play <GROUP>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_station, (group player)] call grad_grandPrix_fnc_gottesFinger_start;
 *
 * Public: No
 */

#include "script_component.hpp"
#include "macros.hpp"

params [["_station", objNull, [objNull]], ["_group", grpNull, [grpNull]]];

if (isNull _station) exitWith { throw "_station must not be null"; };
if (isNull _group) exitWith { throw "_group must not be null"; };

if !(isServer) exitWith {
	_this remoteExecCall [QFUNC_CUSTOM(start), 2];
};

_station setVariable [QGVAR(running), true, true];
_station setVariable [QGVAR(group), _group, true];
_station setVariable [QGVAR(timer), ([] call grad_grandPrix_fnc_startTimer), true];

// set random positions
private _availablePositions = _station getVariable [QGVAR(availablePositions), []];
private _shuffled = _availablePositions call BIS_fnc_arrayShuffle;
private _randomSelectedPositions = _shuffled select [0, (GRAD_GRANDPRIX_GOTTESFINGER_ROUNDS min (count _shuffled))];
_station setVariable [QGVAR(positions), _randomSelectedPositions, true];

// prep first target
[_station, remoteExecutedOwner] call FUNC_CUSTOM(prepNextPosition);

[_station, "<t align='center' color='#66AA66' size='2'>Zeit läuft</t>"] call FUNC_CUSTOM(hintGroup);
