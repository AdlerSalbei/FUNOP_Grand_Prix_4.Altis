#include "idcmacros.hpp"
params [["_width", 0, [0]], ["_height", 0, [0]], ["_title", "", [""]], "_type", "_correctAnswer"];

private _dialogX = CENTER_X(_width);
private _dialogY = CENTER_Y(_height);

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
uiNamespace setVariable ["GRAD_quizDisplay", _display];
 _display displayAddEventHandler ["unload", {
     uiNamespace setVariable ["GRAD_quizDisplay", nil];
}];

_display setVariable ["GRAD_quizType", _type];
_display setVariable ["GRAD_quizCorrectAnswer", _correctAnswer];

// hide vignette
(_display displayCtrl 1202) ctrlSetText "";

private _ctrlBack = _display ctrlCreate ["ctrlStaticBackground", -1];

_ctrlBack ctrlSetPosition [_dialogX, _dialogY, _width, _height + DIALOG_FOOTER_H];
_ctrlBack ctrlCommit 0.1;

private _ctrlTitle = _display ctrlCreate ["ctrlStaticTitle", -1];
_ctrlTitle ctrlSetPosition [_dialogX, _dialogY - DIALOG_TITLE_H, _width, DIALOG_TITLE_H];
_ctrlTitle ctrlCommit 0.1;
_ctrlTitle ctrlSetText _title;

private _ctrlFooter = _display ctrlCreate ["ctrlStaticFooter", -1];
_ctrlFooter ctrlSetPosition [_dialogX, _dialogY + _height, _width, DIALOG_FOOTER_H];
_ctrlFooter ctrlCommit 0.1;

private _ctrlBtnOk = _display ctrlCreate ["ctrlButtonOK", -1];
_ctrlBtnOk ctrlSetPosition [
    _dialogX + _width - 29 * GRID_W,
    _dialogY + _height + DIALOG_BUTTON_SPACING * GRID_H,
    14 * GRID_W,
    DIALOG_FOOTER_H - DIALOG_BUTTON_SPACING * 2 * GRID_H
];
_ctrlBtnOk ctrlCommit 0.1;

_ctrlBtnOk ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];
	
    private _display = ctrlParent _ctrl;
    private _type = _display getVariable ["GRAD_quizType", ""];
    private _correctAnswer = _display getVariable ["GRAD_quizCorrectAnswer", ""];
    private _answerGiven = "";

    switch (_type#0) do {
        case "NUMBER": {
            private _editCtrl = _display getVariable ["GRAD_quizEditCtrl", objNull];
            _answerGiven = parseNumber (ctrlText _editCtrl);
            missionNamespace setVariable ["GRAD_quizAnswerCorrect", _answerGiven >= (_correctAnswer#1) && _answerGiven <= (_correctAnswer#2), true];
        };
        case "STRING": {
            private _editCtrl = _display getVariable ["GRAD_quizEditCtrl", objNull];
            _answerGiven = ctrlText _editCtrl;
            // systemChat _answerGiven;
            missionNamespace setVariable ["GRAD_quizAnswerCorrect", (toLower _answerGiven) in _correctAnswer, true];
        };
        case "MULTIPLE_CHOICE": {
            private _choicesCtrl = _display getVariable ["GRAD_quizChoicesCtrl", objNull];
            _answerGiven = (_choicesCtrl getVariable ["GRAD_quizChoices", []]) select (lbCurSel _choicesCtrl);
            missionNamespace setVariable ["GRAD_quizAnswerCorrect", _answerGiven isEqualTo (str (_correctAnswer#0)), true];
        };
    };
    missionNamespace setVariable ["GRAD_quizAnswerGiven", _answerGiven, true];
    missionNamespace setVariable ["GRAD_quizAnsweredBy", player, true];
    missionNamespace setVariable ["GRAD_quizAnswerLoggedIn", true, true];
	_display closeDisplay 1;
}];

private _ctrlBtnCancel = _display ctrlCreate ["ctrlButtonCancel", -1];
_ctrlBtnCancel ctrlSetPosition [
    _dialogX + _width - 14.5 * GRID_W,
    _dialogY + _height + DIALOG_BUTTON_SPACING * GRID_H,
    14 * GRID_W,
    DIALOG_FOOTER_H - DIALOG_BUTTON_SPACING * 2 * GRID_H
];
_ctrlBtnCancel ctrlCommit 0.1;

_ctrlBtnCancel ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];
	private _display = ctrlParent _ctrl;
	_display closeDisplay 2;
}];

private _ctrlContent = _display ctrlCreate ["ctrlControlsGroupNoScrollbars", IDC_DIALOG_CONTENT];
_ctrlContent ctrlSetPosition [_dialogX, _dialogY, _width, _height];
_ctrlContent ctrlCommit 0.1;

copyToClipboard str _display;

_display;