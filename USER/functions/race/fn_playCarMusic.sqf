3 fadeMusic 0;
[{
	playMusic "";
	0.5 fadeMusic 1;
	[{
		playMusic "nineThou";
		[{
			playMusic "decadence";
		}, [], 240] call CBA_fnc_waitAndExecute;
	}, [], 1] call CBA_fnc_waitAndExecute;
}, [], 3] call CBA_fnc_waitAndExecute;