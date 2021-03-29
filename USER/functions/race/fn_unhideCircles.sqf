private _array1 = [
	heli_helper_1_01, 
	heli_helper_1_02, 
	heli_helper_1_03, 
	heli_helper_1_04, 
	heli_helper_1_05, 
	heli_helper_1_06, 
	heli_helper_1_07, 
	heli_helper_1_08, 
	heli_helper_1_09, 
	heli_helper_1_10, 
	heli_helper_1_11, 
	heli_helper_1_12, 
	heli_helper_1_13, 
	heli_helper_1_14, 
	heli_helper_1_15, 
	heli_helper_1_16, 
	heli_helper_1_17, 
	heli_helper_1_18, 
	heli_helper_1_19, 
	heli_helper_1_20, 
	heli_helper_1_21, 
	heli_helper_1_22, 
	heli_helper_1_23, 
	heli_helper_1_24, 
	heli_helper_1_25, 
	heli_helper_1_26, 
	heli_helper_1_27, 
	heli_helper_1_28
]; 
private _array2 = [
	heli_helper_2_01, 
	heli_helper_2_02, 
	heli_helper_2_03, 
	heli_helper_2_04, 
	heli_helper_2_05, 
	heli_helper_2_06, 
	heli_helper_2_07, 
	heli_helper_2_08, 
	heli_helper_2_09, 
	heli_helper_2_10, 
	heli_helper_2_11, 
	heli_helper_2_12, 
	heli_helper_2_13, 
	heli_helper_2_14, 
	heli_helper_2_15, 
	heli_helper_2_16, 
	heli_helper_2_17, 
	heli_helper_2_18, 
	heli_helper_2_19, 
	heli_helper_2_20, 
	heli_helper_2_21, 
	heli_helper_2_22, 
	heli_helper_2_23, 
	heli_helper_2_24, 
	heli_helper_2_25, 
	heli_helper_2_26, 
	heli_helper_2_27, 
	heli_helper_2_28
]; 
private _array3 = [
	heli_helper_3_01, 
	heli_helper_3_02, 
	heli_helper_3_03, 
	heli_helper_3_04, 
	heli_helper_3_05, 
	heli_helper_3_06, 
	heli_helper_3_07, 
	heli_helper_3_08, 
	heli_helper_3_09, 
	heli_helper_3_10, 
	heli_helper_3_11, 
	heli_helper_3_12, 
	heli_helper_3_13, 
	heli_helper_3_14, 
	heli_helper_3_15, 
	heli_helper_3_16, 
	heli_helper_3_17, 
	heli_helper_3_18, 
	heli_helper_3_19, 
	heli_helper_3_20, 
	heli_helper_3_21, 
	heli_helper_3_22, 
	heli_helper_3_23, 
	heli_helper_3_24, 
	heli_helper_1_25, 
	heli_helper_1_26, 
	heli_helper_1_27, 
	heli_helper_1_28 
]; 
private _array4 = [ 
	heli_helper_4_01, 
	heli_helper_4_02, 
	heli_helper_4_03, 
	heli_helper_4_04, 
	heli_helper_4_05, 
	heli_helper_4_06, 
	heli_helper_4_07, 
	heli_helper_4_08, 
	heli_helper_4_09, 
	heli_helper_4_10, 
	heli_helper_4_11, 
	heli_helper_4_12, 
	heli_helper_4_13, 
	heli_helper_4_14, 
	heli_helper_4_15, 
	heli_helper_4_16, 
	heli_helper_4_17, 
	heli_helper_4_18, 
	heli_helper_4_19, 
	heli_helper_4_20, 
	heli_helper_4_21, 
	heli_helper_4_22, 
	heli_helper_4_23, 
	heli_helper_4_24, 
	heli_helper_2_25, 
	heli_helper_2_26, 
	heli_helper_2_27, 
	heli_helper_2_28
]; 
private _array5 = [
	heli_helper_5_01, 
	heli_helper_5_02, 
	heli_helper_5_03, 
	heli_helper_5_04, 
	heli_helper_5_05, 
	heli_helper_5_06, 
	heli_helper_5_07, 
	heli_helper_5_08, 
	heli_helper_5_09, 
	heli_helper_5_10, 
	heli_helper_5_11, 
	heli_helper_5_12, 
	heli_helper_5_13, 
	heli_helper_5_14, 
	heli_helper_5_15, 
	heli_helper_5_16, 
	heli_helper_5_17, 
	heli_helper_5_18, 
	heli_helper_5_19, 
	heli_helper_5_20, 
	heli_helper_5_21, 
	heli_helper_5_22, 
	heli_helper_5_23, 
	heli_helper_5_24, 
	heli_helper_1_25, 
	heli_helper_1_26, 
	heli_helper_1_27, 
	heli_helper_1_28 
]; 

params ["_vehicle"];
[{
	playMusic "ghostRider";
}, [], 10] call CBA_fnc_waitAndExecute;
private _num = ((_vehicle getVariable "grad_gradPrix4_planePathNum") -1);
private _array = [_array1, _array2, _array3, _array4, _array5] select _num;

{
	private _trigger = createTrigger ["EmptyDetector", _x, false];
	_trigger setTriggerArea [18, 18, getDir _x, true, 18];
	_trigger setPosASL (getPosASL _x);
	_trigger setTriggerActivation ["VEHICLE", "PRESENT", false];
	_trigger triggerAttachVehicle [_vehicle];
	_trigger setTriggerStatements ["this", "", ""];
	_trigger setTriggerInterval 0;
	_x hideObjectGlobal false;
	[{
		params ["_trigger", "_vehicle"];
		triggerActivated _trigger || !(alive _vehicle)
	},{
		params ["_trigger", "_vehicle", "_number", "_arrayNum", "_obj"];

		if !(alive _vehicle) exitWith { deleteVehicle _trigger; _obj hideObjectGlobal true;};
		[format['Tor %1 von %2 wurde passiert!', _number, _arrayNum]] remoteExec ['hintSilent', player];
		_obj hideObjectGlobal true;
	},[_trigger, _vehicle, _forEachIndex + 1, count _array, _x]] call CBA_fnc_waitUntilAndExecute;	
} forEach _array;

