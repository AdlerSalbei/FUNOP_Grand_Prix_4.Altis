/*
 * Author: DerZade
 * Open guess-display on local machine 
 *
 * Arguments:
 * 0: Station object <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_station] call grad_grandPrix_fnc_gottesFinger_openDisplay;
 *
 * Public: No
 */

#include "script_component.hpp"

#define DIALOG_W (0.5 * safeZoneW)
#define DIALOG_H (0.5 * safezoneH)
#define CENTER_X(w) (safezoneX + (safezoneW - w) / 2)
#define CENTER_Y(h) (safezoneY + (safezoneH - h) / 2)
#define GRID_W (pixelW * pixelGrid)
#define GRID_H (pixelH * pixelGrid)

params [["_station", objNull, [objNull]]];

if (isNull _station) exitWith { throw "_station must not be null"; };

// create display
private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";
_display setVariable [QGVAR(station), _station];

private _mapCtrl = _display ctrlCreate ["RscMapControl", -1];
_mapCtrl ctrlSetPosition [CENTER_X(DIALOG_W), CENTER_Y(DIALOG_W), DIALOG_W, 0];
_mapCtrl ctrlSetPosition [CENTER_X(DIALOG_W), CENTER_Y(DIALOG_W), DIALOG_W, DIALOG_H];
_mapCtrl ctrlCommit 0;

private _btnCtrl = _display ctrlCreate ["ctrlButtonOK", -1];
_btnCtrl ctrlSetPosition [CENTER_X(DIALOG_W) + DIALOG_W - 14 * GRID_W, CENTER_Y(DIALOG_W) + DIALOG_H + 0.2 * GRID_H];
_btnCtrl ctrlSetPositionW (14 * GRID_W);
_btnCtrl ctrlSetPositionH (2.5 * GRID_H);
_btnCtrl ctrlCommit 0;

private _textCtrl = _display ctrlCreate ["ctrlStaticTitle", -1];
_textCtrl ctrlSetText "Bitte Position auf der Karte per Doppelklick markieren.";
_textCtrl ctrlSetPosition [CENTER_X(DIALOG_W), CENTER_Y(DIALOG_W) - 2.7 * GRID_H, DIALOG_W, 2.5 * GRID_H];
_textCtrl ctrlCommit 0;

_mapCtrl ctrlAddEventHandler ["MouseButtonDblClick", {
	params ["_ctrl","_btn"];

	if !(_btn isEqualTo 0) exitWith {};

	private _display = ctrlParent _ctrl;
	private _pos = _ctrl ctrlMapScreenToWorld getMousePosition;

	_display setVariable [QGVAR(pos), _pos];
}];

_mapCtrl ctrlAddEventHandler ["Draw", {
	params ["_ctrl"];
	private _display = ctrlParent _ctrl;

	private _pos = _display getVariable [QGVAR(pos), []];

	if (_pos isEqualTo []) exitWith {};

	_ctrl drawIcon 
	[
		"a3\ui_f\data\map\markers\military\destroy_ca.paa",
		[0.82, 0.553, 0.122, 1],
		_pos,
		24,
		24,
		45,
		"",
		0,
		0,
		"TahomaB",
		"right"
	];
}];


_btnCtrl ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];
	private _display = ctrlParent _ctrl;

	private _pos = _display getVariable [QGVAR(pos), []];
	private _station = _display getVariable [QGVAR(station), objNull];

	if (_pos isEqualTo []) exitWith {
		playSound "addItemFailed";
		hint "Bitte Position auf der Karte per Doppelklick markieren.";
	};

	playSound "addItemOK";
	_display closeDisplay 1;
	[_station, _pos] call FUNC_CUSTOM(guess);
}];