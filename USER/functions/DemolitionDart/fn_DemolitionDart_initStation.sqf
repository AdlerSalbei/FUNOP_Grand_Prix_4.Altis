params ["_station"];

private _action = [
    "Start_DemolitionDart",
    "Start!",
    "",
    {[_target, (group _player)] spawn GRAD_GrandPrix_fnc_DemolitionDart_prepareStation;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;