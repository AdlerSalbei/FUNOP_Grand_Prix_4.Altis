["Terminate"] call BIS_fnc_EGSpectator;

if (([missionConfigFile >> "missionSettings","waveRespawnEnabled",0] call BIS_fnc_returnConfigEntry) == 1) then {
    [] call grad_waverespawn_fnc_onPlayerRespawn;
};

if ((side player) isEqualTo sideLogic) exitWith {};

player setUnitLoadout [[],[],[],["U_C_IDAP_Man_TeeShorts_F",[]],[],[],"","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];