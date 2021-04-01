params ["_results", "_points"];

private _structured = ["<t align='center' color='#D18D1F' size='2'>Zusammenfassung:</t>"]; 
_structured pushBack "<t align='left' font='EtelkaMonospacePro'>Name</t><t align='center' font='EtelkaMonospacePro'>Pull height</t><t align='right' font='EtelkaMonospacePro'>Distance</t>";
_structured pushBack "<t align='right' font='EtelkaMonospacePro'>-------------------------</t>"; 

{
	_x params ["_player", "_pullHeight", "_distance"];

	_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>%1</t><t align='center' font='EtelkaMonospacePro'>%2</t><t align='right' font='EtelkaMonospacePro'>%3</t>", name _player, _pullHeight, _distance];  
}forEach _results;

_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>Points:</t><t align='right' font='EtelkaMonospacePro'>%1</t>", _points]; 

hintSilent parseText (_structured joinString "<br />");