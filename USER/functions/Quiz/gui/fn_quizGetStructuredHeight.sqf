#include "idcmacros.hpp"
params [["_question", "", [""]], ["_width", 0, [0]]];

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";

// hide vinette
(_display displayCtrl 1202) ctrlSetText "";

// find text width
private _ctrlQuestion = _display ctrlCreate ["ctrlStructuredText", -1];
_ctrlQuestion ctrlSetPosition [safeZoneX + safeZoneW, safeZoneY + safeZoneH, _width, safezoneH * 5];
_ctrlQuestion ctrlCommit 0;
_ctrlQuestion ctrlSetStructuredText (parseText _question);
private _textHeight = ctrlTextHeight  _ctrlQuestion;

_display closeDisplay 0;

_textHeight;