#include "CfgPatches.hpp"

class CfgVemfReloadedOverrides
{
    /*
       File: config.cpp
       Description: put all of the settings you always change in here and simply keep this pbo. Then you don't have to redo all your changes to the config.cpp everytime
       Description 2: the only thing you will have to do now is simply check the CHANGELOG.md on GitHub everytime there is an update to check if there are any deprecated settings
       Description 3: instead of changing the config.cpp settings everytime, just add your changes here. Saves a lot of time. Yes you are welcome you lucky bastard
       Note: it is extremely difficult for a coder to explain with text how to do this so I have put a few examples in this file instead
       Note 2: the already present lines below line 10 are just examples so feel free to delete them
    */

	headlessClientSupport = yes;
	headlessClientNames[] = { "HC0" };
    debugMode =3; // Overrides CfgVemfReloaded >> debugMode
    maxGlobalMissions = 5; // Overrides CfgVemfReloaded >> maxGlobalMissions
	sayKilledName = yes; // enable/disable the usage of AI's names instead of just "AI"
	timeOutTime = 20;
	
   	class Exile // Exile specific settings
      {
        aiMode = 2; // 0 = Guerilla | 1 = Regular Police | 2 = Police SF (Special Forces) | 3 = Gendarmerie (needs Apex DLC) | 4 = Apex Bandits (needs Apex DLC)
        aiMoney = 100; // (max) amount of money that AI will have on them
        crateMoney = 5000; // (max) amount of money in the loot crate
    };
    class missionSettings{
        class DynamicLocationInvasion{ // DynamicLocationInvasion (mission) settings
            allowCrateLift = 1; // Allow/disallow the loot crate to be lifted with helicopter
			
			class heliPatrol{
                enabled = no;
            };
			groupCount[] = { 2, 4 }; // In format: {minimum, maximum}; VEMF will pick a random number between min and max. If you want the same amount always, use same numbers for minimum and maximum.
			groupUnits[] = { 5, 10 }; // How much units in each group. Works the same like groupCount
			killPercentage = 90; // How much of total AI has to be killed for mission completion (in percentage)
			spawnCrateFirst = yes; // enable/disable the spawning of loot crate before mission has been completed
			maxInvasions = 3; // Max amount of active uncompleted invasions allowed at the same time
        };
    };
	class aiCleanUp{ // Contains settings for removal of items from each AI that gets eliminated
        removeLaunchers = yes; // enable/disable removal of rocket launchers from AI after they are eliminated
    };
	class aiSkill{
		// Global AI skill settings. They affect each VEMFr unit
		difficulty = "Hardcore"; // Options: "Easy" "Normal" "Veteran" "Hardcore" | Default: Veteran
	};
}; // Do not touch this line

