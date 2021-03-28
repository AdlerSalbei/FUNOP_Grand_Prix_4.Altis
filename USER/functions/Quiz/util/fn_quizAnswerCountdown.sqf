params ["_time"];

if !(canSuspend) exitWith { _this spawn GRAD_GrandPrix_fnc_quizAnswerCountdown; };

while { !(missionNamespace getVariable ["GRAD_quizAnswerLoggedIn", false]) } do {
	hintSilent (str _time);
	_time = _time - 1;
	sleep 1;
};