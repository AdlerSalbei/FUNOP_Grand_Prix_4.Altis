params ["_trigger"];

private _racers = allPlayers inAreaArray _trigger;

["grad_grandPrix_race_triggerCountdown", [], _racers] call CBA_fnc_targetEvent;

[{
	[{
		player inArea GRAD_GrandPrix_race_WaterbombArea
	},
	{
		[] spawn {
			playSound "Alarm_blufor";
			cutText ["<t color='#ff0000' size='6'>WASSERBOMBEN-ALARM!!!</t><br/>", "PLAIN", 2, true, true];
			sleep 5.5;
			0 cutFadeOut 0.5;
			sleep 0.5;
			while { player inArea GRAD_GrandPrix_race_WaterbombArea } do {
				_time = 1.6;
				_spawnPos = player getRelPos [(vectorMagnitude velocity player) * _time + (selectRandom [-0.2, 0.3, 0.2, 0]), selectRandom [0, 0.8, 359.2]];
				_spawnPos set [2, 9.81 * (_time^2) * 0.41];

				// _ball = createVehicle ["Land_Balloon_01_water_F", _spawnPos, [], 0, "CAN_COLLIDE"];
				_ball = "Land_Balloon_01_water_F" createVehicleLocal _spawnPos;
				_ball setPosASL _spawnPos;
				[{((getPosASL _this)#2) < -0.1},{_this setDamage 1;}, _ball, 30] call CBA_fnc_WaitUntilAndExecute;
				sleep 0.5;
			};
		};
	}, [], 600] call CBA_fnc_waitUntilAndExecute;	
}] remoteExec ["call", _racers];