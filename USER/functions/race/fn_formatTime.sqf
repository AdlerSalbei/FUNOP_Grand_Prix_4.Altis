/*
 * Author: DerZade
 * Format milliseconds into a readble string
 *
 * Arguments:
 * 0: Time in seconds (with decimal for milliseconds) <NUMBER>
 *
 * Return Value:
 * Formatted string <STRING>
 *
 * Example:
 * private _time = [30] call grad_grandPrix_fnc_formatTime;
 *
 * Public: No
 */

params [["_seconds", 0, [0]]];

private _str = [_seconds, "HH:MM:SS.MS"] call BIS_fnc_secondsToString;

_str;