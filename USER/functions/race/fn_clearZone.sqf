params ["_trigger"];


private _area = triggerArea _trigger;
systemChat format ["%1, %2, %3, %4", _trigger, _area, (getpos _trigger), (getPos _trigger) inAreaArray _area];

private _inArea = (getPos _trigger) inAreaArray _area;

{
	deleteVehicle _x;
}forEach _inArea;