/*
 * Author: DerZade
 * Ends the game of a given station.
 *
 * Arguments:
 * 0: Station object <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_station] call grad_grandPrix_fnc_gottesFinger_end;
 *
 * Public: No
 */
#include "script_component.hpp"
#include "macros.hpp"

params [["_station", objNull, [objNull]]];

if (isNull _station) exitWith { throw "_station must not be null"; };

private _running = _station getVariable [QGVAR(running), false];
private _group = _station getVariable [QGVAR(group), grpNull];
private _timer = _station getVariable [QGVAR(timer), ""];
private _distances = _station getVariable [QGVAR(guessedDistances), []];

private _textRows = ["<t align='center' color='#8F1167' size='2'>Zusammenfassung</t>", ""];

_textRows pushBack format ["<t align='left' color='#777777' size='0.9'>Zeit</t><t align='right' font='EtelkaMonospacePro'>%1</t>", [_stoppedTime] call grad_grandPrix_fnc_formatTime];
private _punkte = 0;
{
	private _punktzahl = (100 - (round _x -1)) max 0; 
	_textRows pushBack format ["<t align='left' color='#777777' size='0.9'>%1</t><t align='right' font='EtelkaMonospacePro'>+ %2</t>", _x toFixed 2, _punktzahl];
	_punkte = _punkte + _punktzahl;
} forEach _distances;

_textRows pushBack "<t align='right' font='EtelkaMonospacePro'>---------------</t>";
_textRows pushBack format ["<t align='right' font='EtelkaMonospacePro'>%1</t>", _punkte];

[_station, (_textRows joinString "<br />")] call FUNC_CUSTOM(hintGroup);

[QGVAR(handler), "onEachFrame"] remoteExec ["BIS_fnc_removeStackedEventHandler", _group];

[_group, _punkte, "gottesFinger"] call grad_grandPrix_fnc_addPoints;

_station setVariable [QGVAR(group), nil, true];
_station setVariable [QGVAR(running), nil, true];