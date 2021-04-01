private _display = (findDisplay 46) createDisplay "RscDisplayEmpty"; 
 
private _edit = _display ctrlCreate ['RscEdit', -1];
private _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
private _ctrlBackground = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];

_edit ctrlSetPosition [0.3, 0.3, pixelGrid * pixelW * 50, pixelGrid * pixelH * 20];
_edit ctrlSetBackgroundColor [0, 0, 0, 0.7]; 
_edit ctrlCommit 0; 


// private _edit = (_display displayCtrl 1337);

_edit ctrlAddEventHandler ["KeyDown", {
    params ["_control", "_key", "_shift", "_ctrl", "_alt"];

    private _allowedChars = toArray "0123456789.";
    private _value = toArray (ctrlText _control);
    private _index = 0;
    while {_index < count _value} do {
        private _char = _value select _index;

        if ((_char isEqualTo 44) || (_char isEqualTo 46)) then {			
			private _pointIndex = _value find _char;
			if (_pointIndex < _index && _pointIndex > -1) then {
				_value set [_index, 60];
				_char = 60;			
			} else {
				_value set [_index, 46];
				_char = 46;
				_control setVariable ["GRAD_quiz_decimalPointPlaced", true];				
			};
        };


        if (_allowedChars find _char > -1) then {
            _index = _index + 1;
        } else {
            _value deleteAt _index;
        }
    };

    _control ctrlSetText (toString _value);
}];