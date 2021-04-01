params ["_station"];

private _action = [
    "teleport_back",
    "Zurück zu den Fahrzeugen",
    "",
    {
			private _pos = [5083.94,5119.72,0] findEmptyPosition [5, 5, typeOf player];
			player setPos _pos;
			
			player setUnitLoadout [[],[],[],["U_C_IDAP_Man_TeeShorts_F",[]],[],[],"","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
	},
    {true}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;