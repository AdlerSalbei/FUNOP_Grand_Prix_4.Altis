{
	_x params ["_vehicle", "_pos"];

	_vehicle setPos _pos;
	_vehicle setDir 20;
	_vehicle setFuel 1;

}forEach [
	[raceVehicle_1, [5567.58,3938.14,0]], 
	[raceVehicle_2, [5571.33,3936.79,0]],
	[raceVehicle_3, [5565.81,3932.09,0]],
	[raceVehicle_4, [5569.28,3930.75,0]],
	[raceVehicle_5, [5563.94,3926.14,0]],
	[raceVehicle_6, [5566.94,3925.04,0]]	
];