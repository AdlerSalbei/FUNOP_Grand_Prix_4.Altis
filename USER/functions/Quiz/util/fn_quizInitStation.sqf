params ["_station"];

private _action = [
    "Start_Quiz",
    "Start!",
    "",
    {[_target, (group _player)] call GRAD_GrandPrix_fnc_startQuiz;},
    {!(missionNamespace getVariable ["GRAD_quizStationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;