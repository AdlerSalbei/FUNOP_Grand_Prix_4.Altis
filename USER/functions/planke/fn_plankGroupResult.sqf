private _results = missionNamespace getVariable ["grad_grandPrix_plank_results", []];

private _structured = ["<t align='center' color='#D18D1F' size='2'>Zusammenfassung:</t>"]; 
_structured pushBack "<t align='left' font='EtelkaMonospacePro'>Name</t><t align='center' font='EtelkaMonospacePro'>Pull hight</t><t align='right' font='EtelkaMonospacePro'>Distance</t>";
_structured pushBack "<t align='right' font='EtelkaMonospacePro'>-------------------------</t>"; 

{
	_x params ["_player", "_pullHight", "_distance"];

	_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>%1</t><t align='center' font='EtelkaMonospacePro'>%2</t><t align='right' font='EtelkaMonospacePro'>%3</t>", name _player, _pullHight, _distance];  
}forEach _results;

hintSilent parseText (_structured joinString "<br />");