params ["_station", "_group", "_allQuestions", "_closeInstructors"];

{
	// Current result is saved in variable _x
	private _pos = [[632.63,5098.47,0.00986481], 5] call BIS_fnc_randomPosTrigger;
	_x setPos _pos;
	[_x, false] remoteExec ["allowDamage", _x];
} forEach (units _group);

// private _allPodiums = [GRAD_quiz_answerPodium_1, GRAD_quiz_answerPodium_2, GRAD_quiz_answerPodium_3, GRAD_quiz_answerPodium_4, GRAD_quiz_answerPodium_5];
// {
// 	[_x, 0, []] call ace_interact_menu_fnc_removeActionFromObject;
// } forEach _allPodiums;

private _correctAnswers = missionNamespace getVariable ["GRAD_quizCorrectAnswers", 0];
private _pointsPerQuestion = 1000 / (count _allQuestions);
private _points = ceil (_pointsPerQuestion * _correctAnswers);
[_group, _points, "Quiz"] call grad_grandPrix_fnc_addPoints;

private _result = format[
	"Ihr habt %1 von %2 Fragen richtig beantwortet. Bei %3 Punkten pro Frage, macht das %4 Punkte!",
	_correctAnswers,
	count _allQuestions,
	_pointsPerQuestion,
	_points
];
[_result] remoteExec ["hint", (units _group) + _closeInstructors];

missionNamespace setVariable ["GRAD_quizCorrectAnswers", 0, true];
missionNamespace setVariable ["GRAD_quizStationIsRunning", false, true];