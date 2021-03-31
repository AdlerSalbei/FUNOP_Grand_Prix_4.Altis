params ["_trigger"];

private _inArea = vehicles inAreaArray _trigger;

{
	deleteVehicle _x;
}forEach _inArea;