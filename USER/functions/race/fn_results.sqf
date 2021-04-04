params ["_results", "_points"];

private _structured = ["<t align='center' color='#D18D1F' size='2'>Zusammenfassung:</t>", ""]; 
_structured pushBack "<t align='right' font='EtelkaMonospacePro'>-------------------------</t>"; 

{
	_x params ["_player", "_time"];

	private _formatedTime = [_time] call grad_grandPrix_fnc_formatTime;
	if (_player isEqualType objNull) then {
		_player = name _player;
	};
	_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>%1</t><t align='right' font='EtelkaMonospacePro'>%2</t>", _player, _formatedTime];  
}forEach _results;
_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>Points:</t><t align='right' font='EtelkaMonospacePro'>%1</t>", _points]; 
hintSilent parseText (_structured joinString "<br />");