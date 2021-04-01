// ["Initialize"] call BIS_fnc_dynamicGroups;

missionNamespace setVariable ["GRAD_KunstflugGates", [GRAD_Kunstflug_Gate_1, GRAD_Kunstflug_Gate_2, GRAD_Kunstflug_Gate_3, GRAD_Kunstflug_Gate_4, GRAD_Kunstflug_Gate_5, GRAD_Kunstflug_Gate_6, GRAD_Kunstflug_Gate_7, GRAD_Kunstflug_Gate_8, GRAD_Kunstflug_Gate_9, GRAD_Kunstflug_Gate_10, GRAD_Kunstflug_Gate_11, GRAD_Kunstflug_Gate_12, GRAD_Kunstflug_Gate_13, GRAD_Kunstflug_Gate_14, GRAD_Kunstflug_Gate_15, GRAD_Kunstflug_Gate_16, GRAD_Kunstflug_Gate_17, GRAD_Kunstflug_Gate_18, GRAD_Kunstflug_Gate_19, GRAD_Kunstflug_Gate_20, GRAD_Kunstflug_Gate_21, GRAD_Kunstflug_Gate_22, GRAD_Kunstflug_Gate_23, GRAD_Kunstflug_Gate_24, GRAD_Kunstflug_Gate_25], true];
missionNamespace setVariable ["GRAD_KunstflugTargets", [GRAD_Kunstflug_Target_1, GRAD_Kunstflug_Target_2, GRAD_Kunstflug_Target_3, GRAD_Kunstflug_Target_4, GRAD_Kunstflug_Target_5, GRAD_Kunstflug_Target_6, GRAD_Kunstflug_Target_7, GRAD_Kunstflug_Target_8, GRAD_Kunstflug_Target_9, GRAD_Kunstflug_Target_10, GRAD_Kunstflug_Target_11, GRAD_Kunstflug_Target_12, GRAD_Kunstflug_Target_13, GRAD_Kunstflug_Target_14, GRAD_Kunstflug_Target_15, GRAD_Kunstflug_Target_16, GRAD_Kunstflug_Target_17, GRAD_Kunstflug_Target_18, GRAD_Kunstflug_Target_19, GRAD_Kunstflug_Target_20, GRAD_Kunstflug_Target_21, GRAD_Kunstflug_Target_22, GRAD_Kunstflug_Target_23, GRAD_Kunstflug_Target_24, GRAD_Kunstflug_Target_25, GRAD_Kunstflug_Target_26, GRAD_Kunstflug_Target_27, GRAD_Kunstflug_Target_28, GRAD_Kunstflug_Target_29, GRAD_Kunstflug_Target_30, GRAD_Kunstflug_Target_31, GRAD_Kunstflug_Target_32, GRAD_Kunstflug_Target_33, GRAD_Kunstflug_Target_34, GRAD_Kunstflug_Target_35, GRAD_Kunstflug_Target_36, GRAD_Kunstflug_Target_37, GRAD_Kunstflug_Target_38, GRAD_Kunstflug_Target_39, GRAD_Kunstflug_Target_40, GRAD_Kunstflug_Target_41, GRAD_Kunstflug_Target_42, GRAD_Kunstflug_Target_43, GRAD_Kunstflug_Target_44, GRAD_Kunstflug_Target_45, GRAD_Kunstflug_Target_46, GRAD_Kunstflug_Target_47, GRAD_Kunstflug_Target_48, GRAD_Kunstflug_Target_49, GRAD_Kunstflug_Target_50], true];
{
	_x hideObjectGlobal true;
} forEach ((GRAD_quiz_Freedom getVariable "bis_carrierParts") apply {_x select 0});

missionNamespace setVariable ["GRAD_quiz_allContestantPositionMarkers", [GRAD_quiz_position_1, GRAD_quiz_position_2, GRAD_quiz_position_3, GRAD_quiz_position_4, GRAD_quiz_position_5], true];

east setFriend [west, 1];
west setFriend [east, 1];

Grad_grandPrix_race_drivers = [];
Grad_grandPrix_plank_jumpers = [];

["grad_grandPrix_race_driversUp", {
	params ["_unit"];

	if (Grad_grandPrix_race_drivers isEqualTo []) then {
		Grad_grandPrix_race_drivers = [group _unit, [_unit]];
	} else {
		Grad_grandPrix_race_drivers params ["_group", "_units"];
		private _index = _units pushBackUnique _unit;

		if (_index isEqualTo -1) then {
			Grad_grandPrix_race_drivers = [_group, _units];
		};
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_race_driversDown", {
	params ["_unit", "_time"];
	if (Grad_grandPrix_race_drivers isEqualTo []) exitWith {};

	Grad_grandPrix_race_drivers params ["_group", "_units"];
	private _times = missionNamespace getVariable ["grad_grandPrix_race_results", []];
	_times pushBack [_unit, _time];
	missionNamespace setVariable ["grad_grandPrix_race_results", _times];

	if (count _units <= 1) then {
		[{
			params ["_group"];
			private _times = missionNamespace getVariable "grad_grandPrix_race_results";
			private _best = _times select 0;
			missionNamespace setVariable ["grad_grandPrix_race_results", []];

			_best params ["_unit", "_time"];

			private _points = [_group, _time, 780, 1000, "Five Planes One Cup"] call grad_grandPrix_fnc_addTime;
			[_times, _points] remoteExec ["grad_grandPrix_fnc_results", _group];
		}, [_group], 10] call CBA_fnc_waitAndExecute;

		Grad_grandPrix_race_drivers = [];
	} else {
		private _index = _units find _unit;

		if !(_index isEqualTo -1) then {
			_units deleteAt _index;
			Grad_grandPrix_race_drivers = [_group, _units];
		};
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_plank_jumpersUp", {
	params ["_unit"];
	
	if (Grad_grandPrix_plank_jumpers isEqualTo []) then {
		Grad_grandPrix_plank_jumpers = [group _unit, [_unit]];
	} else {
		Grad_grandPrix_plank_jumpers params ["_group", "_units"];
		private _index = _units pushBackUnique _unit;

		if (_index isEqualTo -1) then {
			Grad_grandPrix_plank_jumpers = [_group, _units];
		};
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_plank_jumpersDown", {
	params ["_unit", "_height", "_distance"];
	if (Grad_grandPrix_plank_jumpers isEqualTo []) exitWith {};

	Grad_grandPrix_plank_jumpers params ["_group", "_units"];

	private _stats = missionNamespace getVariable ["grad_grandPrix_plank_results", []];
	_stats pushBack [_unit, _height, _distance];
	missionNamespace setVariable ["grad_grandPrix_plank_results", _stats];

	if (count _units <= 1) then {
		[{
			params ["_group"];
			private _stats = missionNamespace getVariable "grad_grandPrix_plank_results";
			missionNamespace setVariable ["grad_grandPrix_plank_results", []];

			private _best = 1000;
			{
				_x params ["_unit", "_pullHeight", "_distance"];
				private _value = floor(_pullHeight + _distance);

				if (_best > _value) then {
					_best = _value;
				};
			}forEach _stats;

			private _points = 1000 - _best;

			[_group, _points, "Planke des Todes"] call grad_grandPrix_fnc_addPoints;
			[_stats, _points] remoteExec ["grad_grandPrix_fnc_plankGroupResult", _group];
		}, [_group], 10] call CBA_fnc_waitAndExecute;

		Grad_grandPrix_plank_jumpers = [];
	} else {
		private _index = _units pushBackUnique _unit;

		if !(_index isEqualTo -1) then {
			_units deleteAt _index;
			Grad_grandPrix_plank_jumpers = [_group, _units];
		};
	};
}] call CBA_fnc_addEventHandler;

missionNamespace setVariable ["GRAD_GrandPrix_allContestantGroups", [GRAD_GrandPrix_Team_Escobar, GRAD_GrandPrix_Team_Capone, GRAD_GrandPrix_Team_Gambino, GRAD_GrandPrix_Team_Taoka, GRAD_GrandPrix_Team_May], true];
missionNamespace setVariable ["GRAD_GrandPrix_allContestantGroupNames", ["Team Escobar", "Team Capone", "Team Gambino", "Team Taoka", "Team May"], true];







private _allRaceGates = [
	heli_helper_1_01, 
	heli_helper_1_02, 
	heli_helper_1_03, 
	heli_helper_1_04, 
	heli_helper_1_05, 
	heli_helper_1_06, 
	heli_helper_1_07, 
	heli_helper_1_08, 
	heli_helper_1_09, 
	heli_helper_1_10, 
	heli_helper_1_11, 
	heli_helper_1_12, 
	heli_helper_1_13, 
	heli_helper_1_14, 
	heli_helper_1_15, 
	heli_helper_1_16, 
	heli_helper_1_17, 
	heli_helper_1_18, 
	heli_helper_1_19, 
	heli_helper_1_20, 
	heli_helper_1_21, 
	heli_helper_1_22, 
	heli_helper_1_23, 
	heli_helper_1_24, 
	heli_helper_1_25, 
	heli_helper_1_26, 
	heli_helper_1_27, 
	heli_helper_1_28,

	heli_helper_2_01, 
	heli_helper_2_02, 
	heli_helper_2_03, 
	heli_helper_2_04, 
	heli_helper_2_05, 
	heli_helper_2_06, 
	heli_helper_2_07, 
	heli_helper_2_08, 
	heli_helper_2_09, 
	heli_helper_2_10, 
	heli_helper_2_11, 
	heli_helper_2_12, 
	heli_helper_2_13, 
	heli_helper_2_14, 
	heli_helper_2_15, 
	heli_helper_2_16, 
	heli_helper_2_17, 
	heli_helper_2_18, 
	heli_helper_2_19, 
	heli_helper_2_20, 
	heli_helper_2_21, 
	heli_helper_2_22, 
	heli_helper_2_23, 
	heli_helper_2_24, 
	heli_helper_2_25, 
	heli_helper_2_26, 
	heli_helper_2_27, 
	heli_helper_2_28,

	heli_helper_3_01, 
	heli_helper_3_02, 
	heli_helper_3_03, 
	heli_helper_3_04, 
	heli_helper_3_05, 
	heli_helper_3_06, 
	heli_helper_3_07, 
	heli_helper_3_08, 
	heli_helper_3_09, 
	heli_helper_3_10, 
	heli_helper_3_11, 
	heli_helper_3_12, 
	heli_helper_3_13, 
	heli_helper_3_14, 
	heli_helper_3_15, 
	heli_helper_3_16, 
	heli_helper_3_17, 
	heli_helper_3_18, 
	heli_helper_3_19, 
	heli_helper_3_20, 
	heli_helper_3_21, 
	heli_helper_3_22, 
	heli_helper_3_23, 
	heli_helper_3_24,

	heli_helper_4_01, 
	heli_helper_4_02, 
	heli_helper_4_03, 
	heli_helper_4_04, 
	heli_helper_4_05, 
	heli_helper_4_06, 
	heli_helper_4_07, 
	heli_helper_4_08, 
	heli_helper_4_09, 
	heli_helper_4_10, 
	heli_helper_4_11, 
	heli_helper_4_12, 
	heli_helper_4_13, 
	heli_helper_4_14, 
	heli_helper_4_15, 
	heli_helper_4_16, 
	heli_helper_4_17, 
	heli_helper_4_18, 
	heli_helper_4_19, 
	heli_helper_4_20, 
	heli_helper_4_21, 
	heli_helper_4_22, 
	heli_helper_4_23, 
	heli_helper_4_24,

	heli_helper_5_01, 
	heli_helper_5_02, 
	heli_helper_5_03, 
	heli_helper_5_04, 
	heli_helper_5_05, 
	heli_helper_5_06, 
	heli_helper_5_07, 
	heli_helper_5_08, 
	heli_helper_5_09, 
	heli_helper_5_10, 
	heli_helper_5_11, 
	heli_helper_5_12, 
	heli_helper_5_13, 
	heli_helper_5_14, 
	heli_helper_5_15, 
	heli_helper_5_16, 
	heli_helper_5_17, 
	heli_helper_5_18, 
	heli_helper_5_19, 
	heli_helper_5_20, 
	heli_helper_5_21, 
	heli_helper_5_22, 
	heli_helper_5_23, 
	heli_helper_5_24
];

missionNamespace setVariable ["GRAD_GrandPrix_allRaceGates", _allRaceGates, true];

setTimeMultiplier 1.5;