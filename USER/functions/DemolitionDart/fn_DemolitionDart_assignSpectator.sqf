params ["_player"];

_player setVariable ["GRAD_DemolitionDart_roleChosen", true, true];
_player setVariable ["GRAD_DemolitionDart_selectedRole", "SPECTATOR", true];

private _count = missionNamespace getVariable ["GRAD_DemolitionDart_spectatorCount", 0];
missionNamespace setVariable ["GRAD_DemolitionDart_spectatorCount", _count + 1, true];