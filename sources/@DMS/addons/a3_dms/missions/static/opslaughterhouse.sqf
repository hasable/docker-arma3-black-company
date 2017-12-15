/*
	"opslaughterhouse" static mission for Altis.
	https://de.wikipedia.org/wiki/Operation_Backfire
	Created by Mythbuster UID 76561198049774329
	Credits to "Mythbuster" for creating the base.
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [5398.72,17900.6,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	[5416.02,17919.8,0],
	[5405.74,17933.8,0],
	[5429.62,17898,0],
	[5413.05,17888.6,0],
	[5398.2,17893.8,0],
	[5355.36,17922.2,0],
	[5365.96,17851.8,0],
	[5402.71,17956.2,0],
	[5390.42,17936.1,0]
];

// Create AI
_AICount = 20 + (round (random 5));


_group =
[
	_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
	_AICount,
	_difficulty,
	"random",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;


_staticGuns =
[
	[
		[5406.6,17934.9,0],
		[5447.73,17942.9,0.146141],
		[5453.77,17947.2,0.233406],
		[5374.58,17934.5,0],
		[5375.9,17941.3,4.82801],
		[5374.93,17908.9,0.0832138],
		[5369.91,17908.8,0.229271],
		[5428.05,17911,0.165657],
		[5430.62,17890.1,0],
		[5400.39,17891.4,0],
		[5365.96,17922.5,0.324318],
		[5461.56,17932.9,0]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;



// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =
[
	[[5406.98,17934.6,0],"I_CargoNet_01_ammo_F"],
	[[5370.94,17904.8,0],"I_CargoNet_01_ammo_F"],
	[[5399.44,17893.7,0],"I_CargoNet_01_ammo_F"],
	[[5431.46,17900.5,0],"I_CargoNet_01_ammo_F"],
	[[5417.72,17891.5,0],"I_CargoNet_01_ammo_F"],
	[[5365.53,17915.3,0],"I_CargoNet_01_ammo_F"],
	[[5365.73,17922.8,7.20081],"I_CargoNet_01_ammo_F"],
	[[5364.92,17894.4,9.04549],"I_CargoNet_01_ammo_F"],
	[[5418.69,17919.7,0],"I_CargoNet_01_ammo_F"],
	[[5430.71,17922,0],"I_CargoNet_01_ammo_F"],
	[[5386.31,17916.1,0],"I_CargoNet_01_ammo_F"],
	[[5449.12,17923,0],"I_CargoNet_01_ammo_F"],
	[[5382.39,17900,0.140236],"I_CargoNet_01_ammo_F"]
];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;


// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;

// Disable smoke on the crates so that the players have to search for them >:D
{
	_x setVariable ["DMS_AllowSmoke", false];
} forEach [_crate0,_crate1];

/*
// Don't think an armed AI vehicle fit the idea behind the mission. You're welcome to uncomment this if you want.
_veh =
[
	[
		[_pos,100,random 360] call DMS_fnc_SelectOffsetPos,
		_pos
	],
	_group,
	"assault",
	_difficulty,
	_side
] call DMS_fnc_SpawnAIVehicle;
*/


// Define mission-spawned AI Units
_missionAIUnits =
[
	_group 		// We only spawned the single group for this mission
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
	[
		_group,			// pass the group
		[
			[
				0,		// Let's limit number of units instead...
				0
			],
			[
				100,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			240,		// About a 4 minute delay between reinforcements.
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			10,			// Reinforcements will only trigger if there's fewer than 10 members left in the group
			0			// 7 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[],
	[[_crate0,[50,100,2]],[_crate1,[3,150,15]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "A slaughterhouse are not only killed animals , Stop the massacre..."];

// Define Mission Win message
_msgWIN = ['#0080ff',"They are our heroes , you could see the gray Exit!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The massacre continues , you are going back and looking for new victims..."];

// Define mission name (for map marker and logging)
_missionName = "Operation Slaughterhouse ©MD";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 20;
_circle setMarkerSize [200,200];


_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_group
		],
		[
			"playerNear",
			[_pos,100]
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	_difficulty,
	[[],[]]
] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));
	
	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;


	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;


	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};


// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;



if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};