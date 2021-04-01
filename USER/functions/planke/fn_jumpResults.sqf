params ["_unit"];

private _distance = _unit distance2D jumpPoint;
private _pullHeight = _unit getVariable ["Grad_grandPrix_plank_pullHeight", -1];

private _structured = ["<t align='left' color='#D18D1F' size='2'>Pull hight:</t><t align='right' color='#D18D1F' size='2'>Distance:</t>", ""]; 
_structured pushBack "<t align='center'>------------------------------------</t>"; 
_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>%1</t><t align='right' font='EtelkaMonospacePro'>%2</t>", _pullHeight, _distance]; 

hintSilent parseText (_structured joinString "<br />");

5 fadeMusic 0;

[{
	playMusic "";
	1 fadeMusic 1;
}, [], 6] call CBA_fnc_waitAndExecute;

["grad_grandPrix_plank_jumpersDown", [_unit, _pullHeight, _distance]] call CBA_fnc_serverEvent;