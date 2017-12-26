// Igiload
[] execVM "IgiLoad\IgiLoadInit.sqf";

if hasInterface then
{
	[] ExecVM "VEMFr_client\sqf\initClient.sqf"; // Client-side part of VEMFr
};
