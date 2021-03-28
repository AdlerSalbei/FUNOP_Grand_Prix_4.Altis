#define CODE_COMMA 44
#define CODE_POINT 46
#define DISALLOWED_CHAR 60

params ["_ctrlEdit"];

_ctrlEdit ctrlAddEventHandler ["KeyDown", {
    params ["_control", "_key", "_shift", "_ctrl", "_alt"];

    private _allowedChars = toArray "0123456789.";
    private _value = toArray (ctrlText _control);
    private _index = 0;
    while {_index < count _value} do {
        private _keep = true;
        private _char = _value select _index;

        // auto replace "," with "."
        if (_char isEqualTo CODE_COMMA) then {
            _value set [_index, CODE_POINT];
            _char = CODE_POINT;
        };

        if (_char isEqualTo CODE_POINT) then {
			private _pointIndex = _value find CODE_POINT;
            if (_pointIndex < _index || _index isEqualTo 0) then {
                _keep = false;
            };
        };

        if ((_allowedChars find _char) isEqualTo -1) then {
            _keep = false;
        };

        if (_keep) then {
            _index = _index + 1;
        } else {
            _value deleteAt _index;
        }
    };

    _control ctrlSetText (toString _value);
}];