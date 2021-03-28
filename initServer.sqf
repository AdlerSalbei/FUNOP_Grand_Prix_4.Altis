// ["Initialize"] call BIS_fnc_dynamicGroups;

missionNamespace setVariable ["GRAD_KunstflugGates", [GRAD_Kunstflug_Gate_1, GRAD_Kunstflug_Gate_2, GRAD_Kunstflug_Gate_3, GRAD_Kunstflug_Gate_4, GRAD_Kunstflug_Gate_5, GRAD_Kunstflug_Gate_6, GRAD_Kunstflug_Gate_7, GRAD_Kunstflug_Gate_8, GRAD_Kunstflug_Gate_9, GRAD_Kunstflug_Gate_10, GRAD_Kunstflug_Gate_11, GRAD_Kunstflug_Gate_12, GRAD_Kunstflug_Gate_13, GRAD_Kunstflug_Gate_14, GRAD_Kunstflug_Gate_15, GRAD_Kunstflug_Gate_16, GRAD_Kunstflug_Gate_17, GRAD_Kunstflug_Gate_18, GRAD_Kunstflug_Gate_19, GRAD_Kunstflug_Gate_20, GRAD_Kunstflug_Gate_21, GRAD_Kunstflug_Gate_22, GRAD_Kunstflug_Gate_23, GRAD_Kunstflug_Gate_24, GRAD_Kunstflug_Gate_25], true];
missionNamespace setVariable ["GRAD_KunstflugTargets", [GRAD_Kunstflug_Target_1, GRAD_Kunstflug_Target_2, GRAD_Kunstflug_Target_3, GRAD_Kunstflug_Target_4, GRAD_Kunstflug_Target_5, GRAD_Kunstflug_Target_6, GRAD_Kunstflug_Target_7, GRAD_Kunstflug_Target_8, GRAD_Kunstflug_Target_9, GRAD_Kunstflug_Target_10, GRAD_Kunstflug_Target_11, GRAD_Kunstflug_Target_12, GRAD_Kunstflug_Target_13, GRAD_Kunstflug_Target_14, GRAD_Kunstflug_Target_15, GRAD_Kunstflug_Target_16, GRAD_Kunstflug_Target_17, GRAD_Kunstflug_Target_18, GRAD_Kunstflug_Target_19, GRAD_Kunstflug_Target_20, GRAD_Kunstflug_Target_21, GRAD_Kunstflug_Target_22, GRAD_Kunstflug_Target_23, GRAD_Kunstflug_Target_24, GRAD_Kunstflug_Target_25, GRAD_Kunstflug_Target_26, GRAD_Kunstflug_Target_27, GRAD_Kunstflug_Target_28, GRAD_Kunstflug_Target_29, GRAD_Kunstflug_Target_30, GRAD_Kunstflug_Target_31, GRAD_Kunstflug_Target_32, GRAD_Kunstflug_Target_33, GRAD_Kunstflug_Target_34, GRAD_Kunstflug_Target_35, GRAD_Kunstflug_Target_36, GRAD_Kunstflug_Target_37, GRAD_Kunstflug_Target_38, GRAD_Kunstflug_Target_39, GRAD_Kunstflug_Target_40, GRAD_Kunstflug_Target_41, GRAD_Kunstflug_Target_42, GRAD_Kunstflug_Target_43, GRAD_Kunstflug_Target_44, GRAD_Kunstflug_Target_45, GRAD_Kunstflug_Target_46, GRAD_Kunstflug_Target_47, GRAD_Kunstflug_Target_48, GRAD_Kunstflug_Target_49, GRAD_Kunstflug_Target_50], true];
<<<<<<< HEAD
{
	_x hideObjectGlobal true;
} forEach ((GRAD_quiz_Freedom getVariable "bis_carrierParts") apply {_x select 0});

missionNamespace setVariable ["GRAD_quiz_allContestantPositionMarkers", [GRAD_quiz_position_1, GRAD_quiz_position_2, GRAD_quiz_position_3, GRAD_quiz_position_4, GRAD_quiz_position_5], true];

east setFriend [west, 1];
west setFriend [east, 1];
=======

for "_i" from 1 to 5 do {
	private _name = format ["array%1", _i];
	private _array = [missionConfigFile >> "CfgFlightPaths" >> _name, "ARRAY", []] call CBA_fnc_getConfigEntry;

	{
		_x hideObjectGlobal true;
	}forEach _array;
};
>>>>>>> main

["grad_grandPrix_race_result", {
    params ["_player", "_info"];
    private _groupInfo = missionNamespace getVariable ["grad_grandPrix_groupInfo", []];

    _info params ["_ID", "_oldGroupMembers"];

	private _groupID = -1;
	private _break = false;

    {
        _x params ["_oldID", "_newID", "_originalMembers"];

		if (_oldID isEqualTo _ID) then {
			_groupID = _newID;
		} else {
			if (_player in _originalMembers) then {
				_groupID = _newID;
			};
		};

		if (_break) exitWith {};
    }forEach _groupInfo;

	if !(_break) exitWith {
		private _group = createGroup west;
		[_player] join _group;
		_groupInfo pushBack ["_ID", (groupID _group), _oldGroupMembers];
		missionNamespace setVariable ["grad_grandPrix_groupInfo", _groupInfo];
	};

	[_player] join _groupID;
<<<<<<< HEAD
}] call CBA_fnc_addEventHandler;
=======
}] call CBA_fnc_addEventHandler;


    
>>>>>>> main
