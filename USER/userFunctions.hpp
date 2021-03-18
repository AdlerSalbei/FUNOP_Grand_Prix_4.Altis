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
	/*
	class race
	{
		file = "USER\functions\race";
		class addActions {};
		class resetRace {};
		class results {};
		class startRace {};
		class startTimeRecording {};
		class stopTimeRecording {};
  	};
	class planke
	{
		file = "USER\functions\planke";
		class addJumpEHs {};
		class jumpResults {};
		class plankGroupResult {};
		class portToCarrier {};
	};
	*/
	class points {
		file = "USER\functions\points";
		class addPoints {};
		class addTime {};
		class getGroup {};
		class initGroups {};
		class showResults {};
		class showStages {};
	};

	class Kunstflug {
		file = "USER\functions\Kunstflug";
		class initKunstflugStation {};
		class startKunstflugCourse {};
		class manageKunstflugTargets {};
		class manageKunstflugEnd {};
		class manageKunstflugGates {};
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
};