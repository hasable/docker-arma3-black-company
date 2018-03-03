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


    debugMode =3; // Overrides CfgVemfReloaded >> debugMode
    maxGlobalMissions = 3; // Overrides CfgVemfReloaded >> maxGlobalMissions
	sayKilledName = no; // enable/disable the usage of AI's names instead of just "AI"
	timeOutTime = 20;
	
   	class Exile // Exile specific settings
      {
        aiMode = 0; // 0 = Guerilla | 1 = Regular Police | 2 = Police SF (Special Forces) | 3 = Gendarmerie (needs Apex DLC) | 4 = Apex Bandits (needs Apex DLC)
        aiMoney = 10; // (max) amount of money that AI will have on them
        crateMoney = 2000; // (max) amount of money in the loot crate
    };
    class missionSettings{
        class DynamicLocationInvasion{ // DynamicLocationInvasion (mission) settings
            allowCrateLift = 1; // Allow/disallow the loot crate to be lifted with helicopter
			      class heliPatrol{
                enabled = no;
            };
            killPercentage = 65; // How much of total AI has to be killed for mission completion (in percentage)
        };
    };
	  class aiCleanUp{ // Contains settings for removal of items from each AI that gets eliminated
        removeLaunchers = yes; // enable/disable removal of rocket launchers from AI after they are eliminated
    };
}; // Do not touch this line

