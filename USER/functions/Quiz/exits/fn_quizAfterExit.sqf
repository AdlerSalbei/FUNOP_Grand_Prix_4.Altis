params ["_unit"];

{[player] call ace_medical_treatment_fnc_fullHealLocal;} remoteExec ["bis_fnc_call", _unit];
_unit setVelocity [0,0,0];
_unit setPosATL (getPosATL GRAD_quiz_tribunePosition);
_unit setDir ((getDir GRAD_quiz_tribune) + 180);
[{_this switchMove "amovpercmstpsnonwnondnon";}, _unit, 0.1] call CBA_fnc_waitAndExecute;
[_unit, false] remoteExec ["allowDamage", _unit];
missionNamespace setVariable ["GRAD_quizExitDone", true, true];