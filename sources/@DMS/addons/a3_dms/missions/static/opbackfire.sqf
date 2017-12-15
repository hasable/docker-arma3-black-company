/*
	"opbackfire" static mission for Altis.
	https://de.wikipedia.org/wiki/Operation_Backfire
	Created by Mythbuster UID 76561198049774329
	Credits to "Mythbuster" for creating the base.
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [6505.35,12341,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	[6531.65,12273.5,0],
	[6551.58,12243.4,0],
	[6512.37,12227.6,0],
	[6524.31,12241.2,0],
	[6472.9,12183.4,0],
	[6544.16,12355,0],
	[6490.12,12368.1,0],
	[6483.87,12355.3,0],
	[6467.94,12278.6,0],
	[6450.41,12228.5,0]
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
		[6561.19,12257.3,3.11903],
		[6568.69,12289,0],
		[6575.48,12313.1,0],
		[6481,12303.6,5.30852],
		[6490.66,12352.2,0.510727],
		[6499.49,12387.6,10.3484],
		[6533.22,12371.5,0],
		[6481.45,12380.2,5.88309],
		[6466.78,12283.2,2.60257],
		[6362.93,12237.2,0],
		[6361.42,12229.4,0],
		[6360.46,12227,2.85271],
		[6388.08,12185.2,8.73163],
		[6402.91,12102.5,0],
		[6387.53,12116.3,0],
		[6396.58,12092.1,0],
		[6379.88,12135,4.46088],
		[6452.96,12161.6,0],
		[6455.27,12172.6,0.854919],
		[6463.73,12183.4,0.144836],
		[6475.11,12177,0],
		[6440.9,12216,0],
		[6566.65,12235.7,0],
		[6511.47,12393.5,4.15758],
		[6577.85,12394.1,0],
		[6552.89,12392.4,0],
		[6562.01,12391.5,0]
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
	[[6546.22,12245.4,0],"I_CargoNet_01_ammo_F"],
	[[6376.25,12226.2,0],"I_CargoNet_01_ammo_F"],
	[[6541.63,12369.8,0],"I_CargoNet_01_ammo_F"],
	[[6584.79,12388.4,0],"I_CargoNet_01_ammo_F"],
	[[6547.72,12391.4,0],"I_CargoNet_01_ammo_F"]
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
_msgStart = ['#FFFF00', "A large supply of A4-rocket was launched for testing in the mountains! They were seen, bearing several boxes..."];

// Define Mission Win message
_msgWIN = ['#0080ff',"Congratulations The A4 rocket test was prevented!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The A4-rockets were ignited..."];

// Define mission name (for map marker and logging)
_missionName = "Operation Backfire ©MD";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 20;
_circle setMarkerSize [400,400];


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