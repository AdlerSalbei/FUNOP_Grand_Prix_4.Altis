/*
 * Author: DerZade
 * Start a timer.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * Timer ID <STRING>
 *
 * Example:
 * private _id = [] call grad_grandPrix_fnc_startTimer;
 *
 * Public: No
 */

private _localId = missionNamespace getVariable ["grad_grandPrix_timerId", 0];
private _globalId = format ["%1_%2", clientOwner, _localId];

grad_grandPrix_timerId = (_localId + 1);

[[_globalId], {
	params ["_id"];

	private _timers = missionNamespace getVariable ["grad_grandPrix_timers", []];
	_timers = [
		_timers,
		_id,
		[time, serverTime] select isMultiplayer
	] call BIS_fnc_setToPairs;
	grad_grandPrix_timers = _timers;

	publicVariable "grad_grandPrix_timers";
}] remoteExecCall ["call", 2];

// return value
_globalId;