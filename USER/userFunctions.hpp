/*
*   Hier können eigene Funktionen eingebunden werden.
*   Ist in CfgFunctions included.
*/


class grad_grandPrix
{
	tag = "grad_grandPrix";
	class gottesFinger
	{
		file = "USER\functions\gottesFinger";
		class gottesFinger_cancel {};
		class gottesFinger_end {};
		class gottesFinger_guess {};
		class gottesFinger_hintGroup {};
		class gottesFinger_initStation {};
		class gottesFinger_openDisplay {};
		class gottesFinger_prepNextPosition {};
		class gottesFinger_start {};
  	};
	class race
	{
		file = "USER\functions\race";
		class addActions {};
		class addActionToRestoreCars {};
		class addActionToRestorePlanes {};
		class clearZone {};
		class playCarMusic {};
		class resetRace {};
		class results {};
		class startRace {};
		class startTimeRecording {};
		class stopTimeRecording {};
		class unhideCircles {};
  	};
	class planke
	{
		file = "USER\functions\planke";
		class addJumpEHs {};
		class jumpResults {};
		class plankGroupResult {};
		class portToCarrier {};
	};
	class points {
		file = "USER\functions\points";
		class addPoints {};
		class addTime {};
		class getGroup {};
		class initGroups {};
		class showResult {};
	};

	class Kunstflug {
		file = "USER\functions\Kunstflug";
		class initKunstflugStation {};
		class startKunstflugCourse {};
		class manageKunstflugTargets {};
		class manageKunstflugEnd {};
		class manageKunstflugGates {};
		class stopKunstflugCourse {};
	}

	class DemolitionDart {
		file = "USER\functions\DemolitionDart";
		class DemolitionDart_initStation {};
		class DemolitionDart_prepareStation {};
		class DemolitionDart_startStation {};
		class DemolitionDart_endStation {};
		class DemolitionDart_assignSpectator {};
		class DemolitionDart_assignDriver {};
	};

	class exits {
		file = "USER\functions\Quiz\exits";
		class quizManageExits {};
		class quizAfterExit {};
		class quizYeeetExit {};
		class quizMissileExit {};
		class quizFallingPillarExit {};
		class quizZSUExit {};
		class quizTractorExit {};
	};

	class gui {
		file = "USER\functions\Quiz\gui";
		class quizCreateEditQuestionDisplay {};
		class quizCreateChoiceQuestionDisplay {};
		class quizCreateBaseDisplay {};
		class quizGetStructuredHeight {};
		class quizHandleNumberInput {};
		class quizHandleStringInput {};
	};

	class util {
		file = "USER\functions\Quiz\util";
		class quizInitStation {};
		class startQuiz {};
		class quizInitQuestions {};
		class quizAnswerCountdown {};
		class endQuiz {};
	};		
};