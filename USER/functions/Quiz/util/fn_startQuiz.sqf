params ["_station", "_group"];

if !(isServer) exitWith {
	_this remoteExecCall ["GRAD_GrandPrix_fnc_startQuiz", 2];
};

missionNamespace setVariable ["GRAD_quizStationIsRunning", true, true];
missionNamespace setVariable ["GRAD_quizActiveContestants", units _group, true];
missionNamespace setVariable ["GRAD_quizAnswerLoggedIn", false, true];
missionNamespace setVariable ["GRAD_quizAvailableExits", ["Yeeet", "Missile", "Pillar", "ZSU", "Tractor"], true];
missionNamespace setVariable ["GRAD_quizCorrectAnswers", 0, true];
missionNamespace setVariable ["GRAD_quizModerator", nearestObject [_station, "C_IDAP_Man_AidWorker_07_F"], true];

private _allPositions = [getPos GRAD_quiz_position_1, getPos GRAD_quiz_position_2, getPos GRAD_quiz_position_3, getPos GRAD_quiz_position_4, getPos GRAD_quiz_position_5];
private _allPodiums = [GRAD_quiz_answerPodium_1, GRAD_quiz_answerPodium_2, GRAD_quiz_answerPodium_3, GRAD_quiz_answerPodium_4, GRAD_quiz_answerPodium_5];
private _occupiedPodiums = [];

{
	_x setVelocity [0,0,0];
	_x setPos (_allPositions#_foreachIndex);
	_x setDir (_x getDir GRAD_quiz_podium);
	_occupiedPodiums pushBackUnique (_allPodiums#_foreachIndex);
} forEach (units _group);

missionNamespace setVariable ["GRAD_quizOccupiedPodiums", _occupiedPodiums, true];

[_station, _group] spawn GRAD_GrandPrix_fnc_quizInitQuestions;