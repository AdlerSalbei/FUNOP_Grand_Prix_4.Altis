params ["_player"];

_player setVariable ["GRAD_DemolitionDart_roleChosen", true, true];
_player setVariable ["GRAD_DemolitionDart_selectedRole", "DRIVER", true];

private _count = missionNamespace getVariable ["GRAD_DemolitionDart_driverCount", 0];
missionNamespace setVariable ["GRAD_DemolitionDart_driverCount", _count + 1, true];