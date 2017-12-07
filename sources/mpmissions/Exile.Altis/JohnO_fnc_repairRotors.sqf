/**
 * ExileClient_object_vehicle_repair
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_vehicle","_equippedMagazines","_wheels","_brokenWheels","_randomWheel","_repairable","_wheelToRepair"];
_vehicle = _this select 0;
/*if (ExileClientPlayerIsInCombat) exitWith
{
	["RepairFailedWarning", ["You are in combat!"]] call ExileClient_gui_notification_event_addNotification;
};*/
if (vehicle player isEqualTo _vehicle) exitWith 
{
	["RepairFailedWarning", ["Are you serious?"]] call ExileClient_gui_notification_event_addNotification;
};

_rotors = ["HitHrotor","HitVRotor"];
_broken = [];
{
	if ((_vehicle getHitPointDamage _x) > 0) then
	{	
		_damage = _vehicle getHitPointDamage _x;
		_broken = _broken + [[_damage,_x]]; 
	};
} forEach _rotors;

_broken sort false;

_rotorToRepair = (_broken select 0) select 1;

if (_broken isEqualTo []) exitWith
{
	["RepairFailedWarning", ["The rotors do not need repair"]] call ExileClient_gui_notification_event_addNotification;
};
if (!local _vehicle) then
{
	["RepairFailedWarning", ["Please get in as driver/pilot first."]] call ExileClient_gui_notification_event_addNotification;
}
else 
{
	_equippedMagazines = magazines player;

	if (!("Exile_Item_Foolbox" in _equippedMagazines)) then
	{
		["RepairFailedWarning", ["You need a toolbox"]] call ExileClient_gui_notification_event_addNotification;
		sleep 0.5;
		};
	if (!("Exile_Item_Wrench" in _equippedMagazines)) then
	{
		["RepairFailedWarning", ["You need a wrench"]] call ExileClient_gui_notification_event_addNotification;
		sleep 0.5;
	};
	if (!("Exile_Item_MetalScrews" in _equippedMagazines)) then
	{
		["RepairFailedWarning", ["You need metal screws"]] call ExileClient_gui_notification_event_addNotification;
		sleep 0.5;
	};
	if (!("Exile_Item_MetalPole" in _equippedMagazines)) then
	{
		["RepairFailedWarning", ["You need a metal pole"]] call ExileClient_gui_notification_event_addNotification;
		sleep 0.5;
	};
	if (!("Exile_Item_MetalWire" in _equippedMagazines)) then
	{
		["RepairFailedWarning", ["You need some metal wire"]] call ExileClient_gui_notification_event_addNotification;
		sleep 0.5;
	};

	if (("Exile_Item_Foolbox" in _equippedMagazines) && ("Exile_Item_Wrench" in _equippedMagazines) &&
		("Exile_Item_MetalScrews" in _equippedMagazines) && ("Exile_Item_MetalPole" in _equippedMagazines) &&
		("Exile_Item_MetalWire" in _equippedMagazines)) then {
			player playMove "AinvPknlMstpSnonWnonDr_medic3";
			sleep 10;
			_vehicle setHitPointDamage [_rotorToRepair,0];
			player removeItem "Exile_Item_MetalScrews";
			player removeItem "Exile_Item_MetalPole";
			player removeItem "Exile_Item_MetalWire";
			["Success",["You have repaired a rotor"]] call ExileClient_gui_notification_event_addNotification;
	};
};
true