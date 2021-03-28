params ["_ctrlEdit"];

_ctrlEdit ctrlAddEventHandler ["KeyDown", {
    params ["_control", "_key", "_shift", "_ctrl", "_alt"];

    private _allowedChars = toArray "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZüöäÜÖÄ";
    private _value = toArray (ctrlText _control);
    private _index = 0;
    while {_index < count _value} do {
        private _keep = true;
        private _char = _value select _index;

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