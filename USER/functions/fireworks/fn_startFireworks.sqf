
if !(canSuspend) exitWith { _this spawn Grad_grandPrix_fnc_startFireworks; };

private _allFireworkPos = [GRAD_GrandPrix_fireworkPos_1, GRAD_GrandPrix_fireworkPos_2, GRAD_GrandPrix_fireworkPos_3, GRAD_GrandPrix_fireworkPos_4, GRAD_GrandPrix_fireworkPos_5, GRAD_GrandPrix_fireworkPos_6, GRAD_GrandPrix_fireworkPos_7, GRAD_GrandPrix_fireworkPos_8, GRAD_GrandPrix_fireworkPos_9, GRAD_GrandPrix_fireworkPos_10, GRAD_GrandPrix_fireworkPos_11];

private _time = serverTime + 120;
while { serverTime < _time } do {
	private _pos = getPos (selectRandom _allFireworkPos);
	[_pos, 'random', 'random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep ((random 1) + 0.1);
};