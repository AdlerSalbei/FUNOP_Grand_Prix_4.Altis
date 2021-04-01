if (didJIP) then {
    [ace_player] remoteExec ["grad_common_fnc_addJipToZeus",2,false];
};

// ["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups;
grad_template_ratingEH = ace_player addEventHandler ["HandleRating",{0}];

["grad_grandPrix_plank_result", {
    [_this] call grad_grandPrix_fnc_plankGroupResult;
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_race_triggerCountdown", {
    playSound "raceCountdown";
    ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\3.paa'/>",0,0,1,0] spawn BIS_fnc_dynamicText;

    [{

        ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\2.paa'/>",0,0,1,0] spawn BIS_fnc_dynamicText;

        [{

            ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\1.paa'/>",0,0,1,0] spawn BIS_fnc_dynamicText;

            [{
                ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\go.paa'/>",0,0,1,0] spawn BIS_fnc_dynamicText;
            }, [], 1] call CBA_fnc_waitAndExecute;
        }, [], 1] call CBA_fnc_waitAndExecute;
    }, [], 1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_race_result", {
    [_this] call grad_grandPrix_fnc_results;
}] call CBA_fnc_addEventHandler;
[{
    private _info = uiNamespace getVariable "grad_grandPrix_transferGroupInfo";
    if !(isNil "_info") then {
        ["grad_grandPrix_setGroup", [ace_player, _info]] call CBA_fnc_serverEvent;
    };
}, []] call CBA_fnc_execNextFrame;

ace_player allowDamage false;

ace_player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
    ace_player allowDamage false;
    [_vehicle, false] remoteExec ["allowDamage", _vehicle];
}];

ace_player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

    ace_player allowDamage false;
}];





// result interaction
private _condition = {
    player inArea GRAD_GrandPrix_finishArea
};
private _statement = {
    [] spawn GRAD_grandPrix_fnc_showResult;
};
private _action = ["show_results","Grand Prix Ergebnisse anzeigen","",_statement,_condition] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;