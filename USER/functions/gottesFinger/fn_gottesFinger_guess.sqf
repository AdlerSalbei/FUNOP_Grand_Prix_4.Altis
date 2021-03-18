/*
 * Author: DerZade
 * This is called when the display is submitted 
 *
 * Arguments:
 * 0: Station object <OBJECT>
 * 1: Guess positon (2d position) <ARRAY>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_station, [30,30]] call grad_grandPrix_fnc_gottesFinger_guess;
 *
 * Public: No
 */

#include "script_component.hpp"

params [["_station", objNull, [objNull]], ["_guessedPos", [], [], 2]];

if (isNull _station) exitWith { throw "_station must not be null"; };

if !(isServer) exitWith {
	_this remoteExecCall [QFUNC_CUSTOM(guess), 2];
};

private _pos = _station getVariable [QGVAR(currentPosition), [0,0]];
private _guessDistance = _pos distance2d _guessedPos;

private _textRows = [];

if (_guessDistance > 50) then {
	_textRows pushBack "<t align='center' color='#b82525' size='2'>EPIC FAIL</t>";
} else {
	_textRows pushBack "<t align='center' color='#66AA66' size='2'>Gut geraten!</t>";
};
_textRows pushBack "";
_textRows pushBack format ["<t align='center'>Distanz: %1m</t>", _guessDistance toFixed 2];

// notify caller of distance
[_station, (_textRows joinString "<br />")] call FUNC_CUSTOM(hintGroup);

// update overall distance
private _distances = _station getVariable [QGVAR(guessedDistances), []];
_distances pushBack _guessDistance;
_station setVariable [QGVAR(guessedDistances), _distances, true];

// prep new target
[_station, remoteExecutedOwner] call FUNC_CUSTOM(prepNextPosition);
