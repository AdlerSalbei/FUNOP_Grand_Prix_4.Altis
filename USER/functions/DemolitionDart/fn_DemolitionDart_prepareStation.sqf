params ["_station", "_group"];

if !(isServer) exitWith { _this remoteExecCall ["GRAD_GrandPrix_fnc_DemolitionDart_prepareStation", 2]; };
if !(canSuspend) exitWith { _this spawn GRAD_GrandPrix_fnc_DemolitionDart_prepareStation; };

_station setVariable ["stationIsRunning", true, true];
missionNamespace setVariable ["GRAD_DemolitionDart_spectatorCount", 0, true];
missionNamespace setVariable ["GRAD_DemolitionDart_driverCount", 0, true];
missionNamespace setVariable ["GRAD_DemolitionDart_playerCount", count (units _group), true];
missionNamespace setVariable ["GRAD_DemolitionDart_groupPlaying", _group, true];
missionNamespace setVariable ["GRAD_DemolitionDart_allDistances", [], true];


[_station, {
    params ["_station"];
    private _action = [
        "Choose_Spectator",
        "Beobachter",
        "",
        { [player] spawn GRAD_GrandPrix_fnc_DemolitionDart_assignSpectator; },
        { !(player getVariable ["GRAD_DemolitionDart_roleChosen", false]) && ((missionNamespace getVariable ["GRAD_DemolitionDart_spectatorCount", 0]) <= ((missionNamespace getVariable ["GRAD_DemolitionDart_playerCount", count (units (missionNamespace getVariable ["GRAD_DemolitionDart_groupPlaying", grpNull]))]) - 1)) && ((missionNamespace getVariable ["GRAD_DemolitionDart_driverCount", 0]) >= 1) }
    ] call ace_interact_menu_fnc_createAction;
    [_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    private _action2 = [
        "Choose_Driver",
        "Fahrer",
        "",
        { [player] spawn GRAD_GrandPrix_fnc_DemolitionDart_assignDriver; },
        { !(player getVariable ["GRAD_DemolitionDart_roleChosen", false]) && ((missionNamespace getVariable ["GRAD_DemolitionDart_driverCount", 0]) <= ((missionNamespace getVariable ["GRAD_DemolitionDart_playerCount", count (units (missionNamespace getVariable ["GRAD_DemolitionDart_groupPlaying", grpNull]))]) - 1)) && ((missionNamespace getVariable ["GRAD_DemolitionDart_driverCount", 0]) < 3) }
    ] call ace_interact_menu_fnc_createAction;
    [_station, 0, ["ACE_MainActions"], _action2] call ace_interact_menu_fnc_addActionToObject;
}] remoteExec ["call", _group];




private _playerCount = count (units _group);
waitUntil { ((missionNamespace getVariable ["GRAD_DemolitionDart_driverCount", 0]) + (missionNamespace getVariable ["GRAD_DemolitionDart_spectatorCount", 0])) isEqualTo _playerCount };

[_station, 0, ["ACE_MainActions", "Choose_Spectator"]] call ace_interact_menu_fnc_removeActionFromObject;
[_station, 0, ["ACE_MainActions", "Choose_Driver"]] call ace_interact_menu_fnc_removeActionFromObject;

[_station, _group] call GRAD_GrandPrix_fnc_DemolitionDart_startStation;