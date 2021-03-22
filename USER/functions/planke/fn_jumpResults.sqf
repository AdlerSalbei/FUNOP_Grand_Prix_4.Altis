params ["_unit"];

private _distance = _unit distance2D jumpPoint;
private _pullHight = _unit getVariable ["Grad_grandPrix_plank_pullhight", -1];

private _results = missionNamespace getVariable ["grad_grandPrix_plank_results", []];
_results pushBackUnique [_unit, _pullHight, _distance];
missionNamespace setVariable ["grad_grandPrix_plank_results", _results, true];

private _structured = ["<t align='left' color='#D18D1F' size='2'>Pull hight:</t><t align='right' color='#D18D1F' size='2'>Distance:</t>", ""]; 
_structured pushBack "<t align='center'>------------------------------------</t>"; 
_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>%1</t><t align='right' font='EtelkaMonospacePro'>%2</t>", _pullHight, _distance]; 

hintSilent parseText (_structured joinString "<br />");

5 fadeMusic 0;

[{
	playMusic "";
	1 fadeMusic 1;
}, [], 6] call CBA_fnc_waitAndExecute;