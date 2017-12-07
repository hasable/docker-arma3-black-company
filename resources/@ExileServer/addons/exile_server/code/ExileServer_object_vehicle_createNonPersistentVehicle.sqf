/**
 * ExileServer_object_vehicle_createNonPersistentVehicle
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_className", "_position", "_direction", "_usePositionATL", "_vehicleObject"];
_className = _this select 0;
_position = _this select 1;
_direction = _this select 2;
_usePositionATL = _this select 3;
_vehicleObject = [_className, _position, _direction, _usePositionATL] call ExileServer_object_vehicle_carefulCreateVehicle;
_vehicleObject setVariable ["ExileIsPersistent", false];
_vehicleObject addEventHandler ["GetIn", {_this call ExileServer_object_vehicle_event_onGetIn}];
_vehicleObject addMPEventHandler ["MPKilled", { if !(isServer) exitWith {}; _this call ExileServer_object_vehicle_event_onMPKilled;}];
if(_className == "B_Heli_Light_01_armed_F") then //AH-9 Pawnee
{
	_vehicleObject removeWeaponTurret  	   ["missiles_DAR",[-1]];		
	_vehicleObject removeMagazinesTurret   ["24Rnd_missiles",[-1]];
	_vehicleObject addWeaponTurret         ["M134_minigun",[0]];
	_vehicleObject addWeaponTurret         ["M134_minigun",[-1]];
	_vehicleObject addMagazineTurret   	   ["2000Rnd_762x51_Belt",[0]];
	_vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
	_vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
	_vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
	_vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[0]];
	_vehicleObject addMagazineTurret   	   ["2000Rnd_762x51_Belt",[-1]];
	_vehicleObject addMagazineTurret   	   ["2000Rnd_762x51_Belt",[-1]];
	_vehicleObject addMagazineTurret   	   ["2000Rnd_762x51_Belt",[-1]];
	_vehicleObject addMagazineTurret   	   ["2000Rnd_762x51_Belt",[-1]];
	_vehicleObject addMagazineTurret       ["2000Rnd_762x51_Belt",[-1]];
	_vehicleObject addWeaponTurret         ["CMFlareLauncher",[0]];
	_vehicleObject addWeaponTurret         ["CMFlareLauncher",[-1]];
	_vehicleObject addMagazineTurret       ["60Rnd_CMFlare_Chaff_Magazine",[0]];
	_vehicleObject addMagazineTurret   	   ["60Rnd_CMFlare_Chaff_Magazine",[-1]];
};
_vehicleObject call ExileServer_system_simulationMonitor_addVehicle;
_vehicleObject