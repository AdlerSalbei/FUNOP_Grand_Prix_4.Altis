/*
 * Author: DerZade
 * Show a hint to group currently at given station
 *
 * Arguments:
 * 0: Station object <OBJECT>
 * 1: Message (can be structured text) <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_station, "yo"] call grad_grandPrix_fnc_gottesFinger_hintGroup;
 *
 * Public: No
 */

#include "script_component.hpp"

params [["_station", objNull, [objNull]], ["_message", "", [""]]];

if (isNull _station) exitWith { throw "_station must not be null"; };
if ((count _message) isEqualTo 0) exitWith { throw "_message must not be null"; };

private _group = _station getVariable [QGVAR(group), grpNull];

if (isNull _group) exitWith {};

(parseText _message) remoteExec ["hintSilent", _group];
