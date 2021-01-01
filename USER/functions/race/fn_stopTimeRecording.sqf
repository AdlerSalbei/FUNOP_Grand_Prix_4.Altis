params ["_vehicle"];

private _unit = driver _vehicle;
private _id = _unit getVariable ["grad_grandPrix_race_timerID", -1];
if (_id isEqualTo -1) exitWith {};
_unit setVariable ["grad_grandPrix_race_timerID", -1];

private _time = [_id] call grad_grandPrix_fnc_stopTimer;

private _results = missionNamespace getVariable ["grad_grandPrix_race_results", []];
_results pushBackUnique [_unit, _time];
missionNamespace setVariable ["grad_grandPrix_race_results", _results, true];

//Todo: Show time to racer
private _formatedTime = [_time] call grad_grandPrix_fnc_formatTime;
hintSilent parseText format ["<t align='left' font='EtelkaMonospacePro'>%1</t><t align='right' font='EtelkaMonospacePro'>%2</t>", name _unit, _formatedTime]; 

["grad_grandPrix_race_driversDown", [_unit]] call CBA_fnc_serverEvent;

5 fadeMusic 0;

[{
	playMusic "";
	1 fadeMusic 1;
}, [], 6] call CBA_fnc_waitAndExecute;