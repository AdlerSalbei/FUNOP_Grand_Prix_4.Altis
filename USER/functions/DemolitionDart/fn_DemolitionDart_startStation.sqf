params ["_station", "_group"];

if !(isServer) exitWith { _this remoteExecCall ["GRAD_GrandPrix_fnc_DemolitionDart_startStation", 2]; };
if !(canSuspend) exitWith { _this spawn GRAD_GrandPrix_fnc_DemolitionDart_startStation; };

private _allInstructors = [];
{
	_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
} forEach allCurators;
private _nearestInstructor = objNull;
private _distance = _station distance (_allInstructors#0);
{
	if ((_station distance _x) < _distance) then {
		_distance = _station distance _x;
		_nearestInstructor = _x;
	}	
} forEach _allInstructors;

private _allOverwatchPositions = [GRAD_DemolitionDart_Overwatch_1, GRAD_DemolitionDart_Overwatch_2, GRAD_DemolitionDart_Overwatch_3, GRAD_DemolitionDart_Overwatch_4];
private _allDrivers = [];
{
	switch (_x getVariable ["GRAD_DemolitionDart_selectedRole", "DRIVER"]) do {
		case "SPECTATOR": {
			private _pos = selectRandom _allOverwatchPositions;
			_allOverwatchPositions deleteAt (_allOverwatchPositions find _pos);
			_x setPosASL (getPosASL _pos);
		};
		case "DRIVER": {
			_allDrivers pushBackUnique _x;
		};
	};	
} forEach (units _group);


// private _area = [[8441.8,1278.93,9.52086], 25, 25, 0, true, 10];

for [{_i=1;}, {_i<=5}, {_i=_i+1;}] do {

	private _vehicle = createVehicle ["GRAD_TurboWaterTruck", getPos GRAD_DemolitionDart_vehicleSpawn, [], 0, "NONE"];
	_vehicle setDir (getDir GRAD_DemolitionDart_vehicleSpawn);
	clearBackpackCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearWeaponCargoGlobal _vehicle;

	sleep 0.2;

	{
		private _pos = (_vehicle getRelPos [8, 0]) findEmptyPosition [0, 4, typeOf _x];
		[_x, [0,0,0]] remoteExec ["setVelocity", _x];
		_x setPos _pos;
		[_x, (_x getDir _vehicle)] remoteExec ["setDir", _x];
		[_x, false] remoteExec ["allowDamage", _x];
	} foreach _allDrivers;

	waitUntil { (_vehicle inArea GRAD_DemolitionDart_Trigger) || !(alive _vehicle) };

	if !(alive _vehicle) then {
		private _distance = [_vehicle distance2D GRAD_DemolitionDart_Target, 2] call BIS_fnc_cutDecimals;
		[format["Versuch %1 beendet. Distanz zum Ziel: %2m", _i, _distance]] remoteExec ["hint", (units _group) + [_nearestInstructor]];
		{
			moveOut (_x#0);
		} forEach (fullCrew _vehicle);
		sleep 0.2;
		deleteVehicle _vehicle;
		continue;
	};

	[_vehicle, {
		_this setFuel 0;
		_this engineOn false;
		_this allowDamage true;
	}] remoteExec ["call", owner _vehicle];

	waitUntil { (isTouchingGround _vehicle) || (((getPos _vehicle)#2) < 0.8) };

	private _distance = [_vehicle distance2D GRAD_DemolitionDart_Target, 2] call BIS_fnc_cutDecimals;
	private _allDistances = missionNamespace getVariable ["GRAD_DemolitionDart_allDistances", []];
	_allDistances pushBack _distance;
	missionNamespace setVariable ["GRAD_DemolitionDart_allDistances", _allDistances, true];


	[format["Versuch %1 beendet. Distanz zum Ziel: %2m", _i, _distance]] remoteExec ["hint", (units _group) + [_nearestInstructor]];

	waitUntil { ((((velocity _vehicle)#0) < 1) && (((velocity _vehicle)#1) < 1)) || !(alive _vehicle) };

	{
		moveOut (_x#0);
	} forEach (fullCrew _vehicle);

	sleep 0.5;

	deleteVehicle _vehicle;

};

[_station, _group] call GRAD_GrandPrix_fnc_DemolitionDart_endStation;