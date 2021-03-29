0 fadeMusic 3;
[{
	playMusic "";
	1 fadeMusic 0.5;
	[{
		playMusic "nineThou";
	}, [], 1] call CBA_fnc_waitAndExecute;
}, [], 3] call CBA_fnc_waitAndExecute;