if !(isServer) exitWith {_this remoteExecCall ["grad_grandPrix_fnc_addTime", 2];};

params ["_group", "_time", "_bestTime", "_maxPoints", "_stage", ["_worstTime", -1]];

private _points = (round((_bestTime/_time) * _maxPoints)) min _maxPoints;


// private _points = -1;

// if (_time <= _bestTime) then {
// 	_points = _maxPoints;
// } else {
// 	private _timeToPointsMultiplikator = _maxPoints/_bestTime;
// 	if (_worstTime isEqualTo -1) then {
// 		if (_bestTime*2 >= _time) exitWith {
// 			_points = 0;
// 		};
// 	} else {
// 		_timeToPointsMultiplikator = _maxPoints/(_worstTime - _bestTime);

// 		if (_worstTime>= _time) exitWith {
// 			_points = 0;
// 		};
// 	};

// 	if (_points isEqualTo -1) then {
// 		_points = (_time - _bestTime) * _timeToPointsMultiplikator;
// 	};
// };

// _points = round _points;

[_group, _points, _stage] call grad_grandPrix_fnc_addPoints;

_points