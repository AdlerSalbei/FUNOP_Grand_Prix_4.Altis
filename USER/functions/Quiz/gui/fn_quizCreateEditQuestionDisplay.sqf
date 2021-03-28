#include "idcmacros.hpp"

#define DIALOG_W (45 * GRID_W)
#define EDIT_H (3 * GRID_H)
#define MARGIN_H (0.5 * GRID_H)
#define MARGIN_W (0.5 * GRID_W)

params [["_question", "", [""]], ["_questionNumber", 0, [0]], ["_questionType", ""], ["_unit", "", [""]], "_answer", ["_editW", (14 * GRID_W), [0]]];

_question = str composeText["<t size='1.2' valign='middle' align='center'>", _question, "</t>"];

private _textHeight = [_question, DIALOG_W - MARGIN_W * 2] call GRAD_GrandPrix_fnc_quizGetStructuredHeight;
private _height = _textHeight + MARGIN_H * 3  + EDIT_H;

private _display = [DIALOG_W, _height, "Frage " + str _questionNumber + ":", [_questionType], _answer] call GRAD_GrandPrix_fnc_quizCreateBaseDisplay;
private _mainGrp = _display displayCtrl IDC_DIALOG_CONTENT;

private _questionCtrl = _display ctrlCreate ["ctrlStructuredText", -1, _mainGrp];
_questionCtrl ctrlSetPosition [MARGIN_W, MARGIN_H, DIALOG_W - MARGIN_W * 2, _textHeight];
_questionCtrl ctrlSetStructuredText (parseText _question);
_questionCtrl ctrlCommit 0.1;

private _editY = _textHeight + MARGIN_H * 2;
private _editX = (DIALOG_W - _editW) / 2;
if (count _unit > 0) then {
    _unitCtrl = _display ctrlCreate ["ctrlStatic", -1, _mainGrp];
    _unitCtrl ctrlSetPosition [0,0, DIALOG_W, EDIT_H];
    _unitCtrl ctrlCommit 0.1;
    _unitCtrl ctrlSetText _unit;

    private _w = ctrlTextWidth _unitCtrl;

    _editX = _editX - _w / 2;

    _unitCtrl ctrlSetPosition [_editX + _editW, _editY, _w, EDIT_H];
    _unitCtrl ctrlCommit 0.1;
};

private _editCtrl = objNull;
if (_unit isEqualTo "") then {
	_editCtrl = _display ctrlCreate ["jules_ctrlEdit_middle", 420, _mainGrp];
} else {
	_editCtrl = _display ctrlCreate ["jules_ctrlEdit_right", 420, _mainGrp];
};
_display setVariable ["GRAD_quizEditCtrl", _editCtrl];
_editCtrl ctrlSetPosition [_editX, _editY, _editW, EDIT_H];
_editCtrl ctrlCommit 0.1;
ctrlSetFocus _editCtrl;

switch (_questionType) do {
	case "NUMBER": { [_editCtrl] call GRAD_GrandPrix_fnc_quizHandleNumberInput; };
	case "STRING": { [_editCtrl] call GRAD_GrandPrix_fnc_quizHandleStringInput; };
};