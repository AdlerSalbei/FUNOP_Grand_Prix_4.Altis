/*
 * Author: DerZade
 * Stop a timer.
 *
 * Arguments:
 * 0: Timer ID <STRING>
 *
 * Return Value:
 * Time in seconds (with decimal for milliseconds)
 *
 * Example:
 * private _time = [_id] call grad_grandPrix_fnc_stopTimer;
 *
 * Public: No
 */

params [["_id", "", [""]]];

if ((count _id) isEqualTo 0) exitWith { throw "_id must be longer than 0 chars"; };

private _time = [time, serverTime] select isMultiplayer;

// get start time
private _startTime = [
	missionNamespace getVariable ["grad_grandPrix_timers", []],  // array
	_id,  // key
	0  // default value
] call BIS_fnc_getFromPairs;

[[_id], {
	params ["_id"];

	private _timers = missionNamespace getVariable ["grad_grandPrix_timers", []];
	_timers = [_timers, _id] call BIS_fnc_removeFromPairs;
	grad_grandPrix_timers = _timers;

	publicVariable "grad_grandPrix_timers";
}] remoteExecCall ["call", 2];

(_time - _startTime);