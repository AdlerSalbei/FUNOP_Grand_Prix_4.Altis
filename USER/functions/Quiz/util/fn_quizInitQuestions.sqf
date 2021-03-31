params ["_station", "_group"];

private _allQuestions = [
	["Wie groß ist Altis? Fehlermarge: 10%", 1, [270.5, 0.9*270.5, 1.1*270.5], ["NUMBER"], "km²"],
	["Wie viele Flugplätze gibt es auf Altis?", 2, [6], [4,5,6,7], ""],
	["Wie viel DLC gibt es für Arma 3?", 3, [13, 12, 13], ["NUMBER"], ""],
	["Wie heißt die Hauptstadt auf Tanoa?", 4, ["georgetown"], ["STRING"], ""],
	["Artillerist D. Rulrich hat in seiner Panzerhaubitze 2000, 50 Schuss 155mm Granaten dabei. Wenn er davon 2/5 verschießt, wie viel Mumpeln bleiben ihm dann übrig?", 5, [30], [10,20,30,40], ""],
	["Was ist die minimale Zughöhe eines steuerbaren Fallschirms unter ACE3, ohne bei der Landung verletzt zu werden? Fehlermarge: 20%", 6, [68, 0.8*68, 1.2*68], ["NUMBER"], "m"],
	["Wie heißt die Karte, auf der ihr euch gerade befindet?", 7, ["kingdomofregero"], ["STRING"], ""],
	["Wie viele (öffentliche) Repositories, stehen auf der Github-Seite von Gruppe Adler zur Verfügung? Fehlermarge: 15%", 8, [233, floor(0.85*233), ceil(1.15*233)], ["NUMBER"], ""],
	["Wenn ein Feind 'bekämpft' ist, dann wurde er...", 9, ["beschossen"], ["getötet", "neutralisiert", "festgesetzt","beschossen"], ""]
	// ["eigentlicheFrage", Zahl, ["richtige Antwort(en)"], ["Art der Frage: Antwort als String, Zahl oder MultipleChoice"], "optionale Einheiten der Lösung (z.B. Meter)"]
];

private _closeInstructors = [];

{
	_x params ["_question", "_number", "_answer", "_type", "_unit"];

	private _activeContestants = missionNamespace getVariable ["GRAD_quizActiveContestants", []];
	if (count _activeContestants < 1) exitWith {  };

	missionNamespace setVariable ["GRAD_quizAnswerCorrect", false, true];
	missionNamespace setVariable ["GRAD_quizQuestionActive", _number, true];
	missionNamespace setVariable ["GRAD_quizExitDone", false, true];
	missionNamespace setVariable ["GRAD_quizUserDisplays", [], true];
	missionNamespace setVariable ["GRAD_quizAnsweredBy", objNull, true];

	private _moderator = missionNamespace getVariable ["GRAD_quizModerator", objNull];

	private _occupiedPodiums = missionNamespace getVariable ["GRAD_quizOccupiedPodiums", []];
	private _numberStr = str _number;

	{
		if ((_x distance2d _station) <= 150) then {
			_closeInstructors pushBackUnique (getAssignedCuratorUnit _x);
		}
	} forEach allCurators;

	[[_numberStr, _station], {
		params ["_numberStr", "_station"];
		private _action = [
			"Start_Question_" + _numberStr,
			"Start Question " + _numberStr,
			"",
			{
				params ["_target", "_player", "_params"];
				_params params ["_numberStr"];
				missionNamespace setVariable ["GRAD_quizQuestion" + _numberStr + "Active", true, true];
			},
			{
				params ["_target", "_player", "_params"];
				_params params ["_numberStr"];			
				!(missionNamespace getVariable ["GRAD_quizQuestion" + _numberStr + "Active", false])
			},
			{},
			[_numberStr]
		] call ace_interact_menu_fnc_createAction;
		[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	}] remoteExec ["call", _closeInstructors];

	waitUntil { missionNamespace getVariable ["GRAD_quizQuestion" + _numberStr + "Active", false] };

	{
		private _podium = _x;
		[[_question, _number, _type, _unit, _numberStr, _answer, _podium], {
			params ["_question", "_number", "_type", "_unit", "_numberStr", "_answer", "_podium"];
			private _action = [
				"Question_" + _numberStr,
				"Frage " + _numberStr,
				"",
				{
					params ["_target", "_player", "_params"];
					_params params ["_question", "_number", "_type", "_unit", "_numberStr", "_answer"];
					if (count _type isEqualTo 1) then {
						[_question, _number, _type#0, _unit, _answer] spawn GRAD_GrandPrix_fnc_quizCreateEditQuestionDisplay;
					} else {
						[_question, _number, _type, _unit, _answer] spawn GRAD_GrandPrix_fnc_quizCreateChoiceQuestionDisplay;
					};
				},
				{
					params ["_target", "_player", "_params"];
					_params params ["_question", "_number", "_type", "_unit", "_numberStr"];
					(missionNamespace getVariable ["GRAD_quizQuestionActive", -1] isEqualTo _number)
				},
				{},
				[_question, _number, _type, _unit, _numberStr, _answer]
			] call ace_interact_menu_fnc_createAction;
			[_podium, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
		}] remoteExec ["call", _activeContestants];
	} forEach _occupiedPodiums;

	[[_station, _numberStr], {
		params ["_station", "_numberStr"];
		[_station, 0, ["ACE_MainActions", "Start_Question_" + _numberStr]] call ace_interact_menu_fnc_removeActionFromObject;
	}] remoteExec ["call", 0];

	private _timeToAnswer = serverTime + 90;
	[90] remoteExec ["GRAD_GrandPrix_fnc_quizAnswerCountdown", _activeContestants + _closeInstructors];

	waitUntil { (missionNamespace getVariable ["GRAD_quizAnswerLoggedIn", false]) || (serverTime > _timeToAnswer) };
	missionNamespace setVariable ["GRAD_quizAnswerLoggedIn", true, true];
	[{
		private _display = uiNamespace getVariable ["GRAD_quizDisplay", displayNull];
    	if (isNull _display) exitWith {};
   		_display closeDisplay 0;
	}] remoteExec ["call", _activeContestants];

	[[_occupiedPodiums, _numberStr], {
		params ["_occupiedPodiums", "_numberStr"];
		{
			[_x, 0, ["Question_" + _numberStr]] call ace_interact_menu_fnc_removeActionFromObject;
		} forEach _occupiedPodiums;
	}] remoteExec ["call", _activeContestants];

	"" remoteExec ["hintSilent", _activeContestants + _closeInstructors];
	
	private _answeredBy = missionNamespace getVariable ["GRAD_quizAnsweredBy", objNull];
	if !(isNull _answeredBy) then {
		[format["%1 hat '%2%3' als Antwort eingeloggt!", name _answeredBy, missionNamespace getVariable ["GRAD_quizAnswerGiven", ""], _unit]] remoteExec ["hint", _activeContestants + _closeInstructors];
	};

	private _answerCorrect = missionNamespace getVariable ["GRAD_quizAnswerCorrect", false];
	missionNamespace setVariable ["GRAD_quizQuestionActive", -1, true];
	sleep (random [1, 6, 10]);
	if (_answerCorrect) then {

		if (isNil "MISSION_ROOT") then { 
			if(isDedicated) then { 
				MISSION_ROOT = "mpmissions\__CUR_MP." + worldName + "\"; 
			} else { 
				MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15]; 
			}; 
		}; 
		
		playSound3D [MISSION_ROOT + "USER\sounds\correct.wav", _station, false, getPosASL _station, 5, 1, 100];		

		private _correctAnswers = missionNamespace getVariable ["GRAD_quizCorrectAnswers", 0];
		_correctAnswers = _correctAnswers + 1;
		missionNamespace setVariable ["GRAD_quizCorrectAnswers", _correctAnswers, true];
		missionNamespace setVariable ["GRAD_quizExitDone", true, true];
	} else {
		private _unfortunateContestant = selectRandom _activeContestants;
		_activeContestants deleteAt (_activeContestants find _unfortunateContestant);
		missionNamespace setVariable ["GRAD_quizActiveContestants", _activeContestants, true];
		missionNamespace setVariable ["GRAD_quizUnfortunateContestant", _unfortunateContestant, true];

		private _nearestPodium = nearestObject [_unfortunateContestant, "Land_InfoStand_V1_F"];
		_occupiedPodiums deleteAt (_occupiedPodiums find _nearestPodium);
		missionNamespace setVariable ["GRAD_quizOccupiedPodiums", _occupiedPodiums, true];
		
		{
			[_x, false] remoteExec ["allowDamage", _x];
		} forEach _activeContestants;
		[_unfortunateContestant, true] remoteExec ["allowDamage", _unfortunateContestant];

		[_unfortunateContestant] spawn GRAD_GrandPrix_fnc_quizManageExits;
	};

	"" remoteExec ["hintSilent", (units _group) + _closeInstructors];
	waitUntil { missionNamespace getVariable ["GRAD_quizExitDone", false] };
	missionNamespace setVariable ["GRAD_quizAnswerLoggedIn", false, true];
	missionNamespace setVariable ["GRAD_quizQuestion" + _numberStr + "Active", false, true];
} forEach _allQuestions;

sleep 2;
private _moderator = missionNamespace getVariable ["GRAD_quizModerator", objNull];
[_station, _group, _allQuestions, _closeInstructors] call GRAD_GrandPrix_fnc_endQuiz;
