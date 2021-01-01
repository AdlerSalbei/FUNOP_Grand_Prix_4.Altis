private _results = missionNamespace getVariable ["grad_grandPrix_race_results", []];
missionNamespace setVariable ["grad_grandPrix_race_results", [], true];

private _structured = ["<t align='center' color='#D18D1F' size='2'>Zusammenfassung:</t>", ""]; 
_structured pushBack "<t align='right' font='EtelkaMonospacePro'>-------------------------</t>"; 

{
	_x params ["_player", "_time"];

	private _formatedTime = [_time] call grad_grandPrix_fnc_formatTime;
	_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>%1</t><t align='right' font='EtelkaMonospacePro'>%2</t>", name _player, _formatedTime];  
}forEach _results;

hintSilent parseText (_structured joinString "<br />");