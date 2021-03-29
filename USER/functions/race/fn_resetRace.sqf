[trigger_resetBoats] call grad_grandPrix_fnc_clearZone;

{
	
    private _veh = createVehicle ["C_Scooter_Transport_01_F", _x, [], 0, "CAN_COLLIDE"];
	_veh setPos _x;
	_veh setDir 188.497;
}forEach [
	[5744,8908,0],
	[5748,8908,0],
	[5752,8908,0],
	[5756,8908,0],
	[5760,8908,0]
];