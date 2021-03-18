/*
 * Author: DerZade
 * Initialize station
 *
 * Arguments:
 * 0: Station object <OBJECT>
 * 1: Posititons <ARRAY>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [this, [[0,0], [100,100]]] call grad_grandPrix_fnc_gottesFinger_initStation;
 *
 * Public: No
 */

#include "script_component.hpp"

params [["_station", objNull, [objNull]], ["_positions", [], [[]]]];

if (isNull _station) exitWith { throw "_station must not be null"; };
if ((count _positions) isEqualTo 0) exitWith { throw "_positions must at least contain one element"; };

// validate array to contain only arrays of 3 numbers
for "_i" FROM 0 TO ((count _positions) - 1) do {
	private _elem = _positions param [_i, [], [[]], 3];

	for "_j" from 0 to 2 do {
		_elem param [_j, 0, [0]];
	}
};

// store available positions
_station setVariable [QGVAR(availablePositions), _positions];

_station addAction [
	"<t color='#66AA66' size='1.5'>Start</t>",
	{
		params ["_target", "_player"];
		[_target, (group _player)] call FUNC_CUSTOM(start);
	},
	nil,
	1.5,
	true,
	true,
	"",
	QUOTE(!(_target getVariable [ARR_2(QUOTE(QGVAR(running)), false)]))
];

_station addAction [
	"<t color='#d18d1f' size='1.5'>Position raten</t>",
	{
		params ["_target", "_player"];
		[_target, _player] call FUNC_CUSTOM(openDisplay);
	},
	nil,
	1.5,
	true,
	true,
	"",
	QUOTE((_target getVariable [ARR_2(QUOTE(QGVAR(running)), false)]))
];

_station addAction [
	"<t color='#b82525' size='1.5'>Abbrechen</t>",
	{
		_this spawn {
			params ["_target", "_player"];

			private _result = [
				"Bist du dir sicher, dass du abbrechen willst?", 
				"Abbrechen",
				true,
				true,
				(findDisplay 46)
			] call BIS_fnc_guiMessage;

			if (!_result) exitWith {};

			[_target, _player] call FUNC_CUSTOM(cancel);
		}
	},
	nil,
	1.5,
	true,
	true,
	"",
	QUOTE((_target getVariable [ARR_2(QUOTE(QGVAR(running)), false)]) && [] call grad_adminMessages_fnc_isAdminOrZeus)
];
