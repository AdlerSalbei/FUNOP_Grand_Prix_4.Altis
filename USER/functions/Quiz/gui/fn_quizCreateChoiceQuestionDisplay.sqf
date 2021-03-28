#include "idcmacros.hpp"

#define DIALOG_W (45 * GRID_W)
#define EDIT_H (30 * GRID_H)
#define MARGIN_H (0.5 * GRID_H)
#define MARGIN_W (0.5 * GRID_W)

params [["_question", "", [""]], ["_questionNumber", 0, [0]], ["_answerChoices", ""], ["_unit", "", [""]], "_answer", ["_editH", (22 * GRID_W), [0]]];

_question = str composeText["<t size='1.2' valign='middle' align='center'>", _question, "</t>"];

private _textHeight = [_question, DIALOG_W - MARGIN_W * 2] call GRAD_GrandPrix_fnc_quizGetStructuredHeight;
// private _height = _textHeight + MARGIN_H * 3  + EDIT_H;

private _choiceY = _textHeight + MARGIN_H * 2;

private _display = [DIALOG_W, EDIT_H, "Frage " + str _questionNumber + ":", ["MULTIPLE_CHOICE"], _answer] call GRAD_GrandPrix_fnc_quizCreateBaseDisplay;
private _mainGrp = _display displayCtrl IDC_DIALOG_CONTENT;

private _questionCtrl = _display ctrlCreate ["ctrlStructuredText", -1, _mainGrp];
_questionCtrl ctrlSetPosition [MARGIN_W, MARGIN_H, DIALOG_W - MARGIN_W * 2, _textHeight];
_questionCtrl ctrlSetStructuredText (parseText _question);
_questionCtrl ctrlCommit 0.1;

private _choicesCtrl = _display ctrlCreate ["MultipleChoiceCtrl", -1, _mainGrp];
_display setVariable ["GRAD_quizChoicesCtrl", _choicesCtrl];
private _allChoices = [];
{
	_choicesCtrl lbSetText [_foreachIndex, str _x];
	_allChoices pushBackUnique (str _x);
} forEach _answerChoices;
_choicesCtrl setVariable ["GRAD_quizChoices", _allChoices];
// _choicesCtrl ctrlAddEventHandler ["ToolBoxSelChanged", {
// 	params ["_control", "_selectIndex"];

// 	systemChat str _selectIndex;
// }];
_choicesCtrl ctrlSetPosition [MARGIN_W, _choiceY, DIALOG_W - 2 * MARGIN_W, EDIT_H - (_choiceY + MARGIN_W)];
_choicesCtrl ctrlSetBackgroundColor [0, 0, 0, 0.3];
_choicesCtrl ctrlCommit 0.1;