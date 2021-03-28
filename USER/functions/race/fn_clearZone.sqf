params ["_trigger"];

private _area = triggerArea _trigger;
private _inArea = (getPos _trigger) inAreaArray _area;

{
	deleteVehicle _x;
}forEach _inArea;