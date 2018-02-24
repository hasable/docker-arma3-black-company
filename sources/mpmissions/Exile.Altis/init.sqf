// VEMF
// Put this somewhere in your own init.sqf outside of any other brackets and if statements
if hasInterface then
{
	[] ExecVM "VEMFr_client\sqf\initClient.sqf"; // Client-side part of VEMFr
	systemChat ">>>>> VEMF OK";
};

//Revive
[] execVM "Custom\EnigmaRevive\init.sqf";
if hasInterface then
{
	systemChat ">>>>> ENIGMA OK";
};


// Igiload
[] execVM "IgiLoad\IgiLoadInit.sqf";
if hasInterface then
{
	systemChat ">>>>> IGILOAD OK";
};


#include "A3XAI_Client\A3XAI_initclient.sqf";
if hasInterface then
{
	systemChat ">>>>> A3XAI OK";
};
