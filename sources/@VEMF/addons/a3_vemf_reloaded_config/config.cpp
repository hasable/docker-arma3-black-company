
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


    debugMode = 0; // Overrides CfgVemfReloaded >> debugMode
    maxGlobalMissions = 3; // Overrides CfgVemfReloaded >> maxGlobalMissions

    class Exile // Exile specific settings
        {
            aiMode = 0; // 0 = Guerilla | 1 = Regular Police | 2 = Police SF (Special Forces) | 3 = Gendarmerie (needs Apex DLC) | 4 = Apex Bandits (needs Apex DLC)
            aiMoney = 10; // (max) amount of money that AI will have on them
        };
    class missionSettings{
        class DynamicLocationInvasion{ // DynamicLocationInvasion (mission) settings
            class heliPatrol{
                enabled = no;
            };
            killPercentage = 75; // How much of total AI has to be killed for mission completion (in percentage)
        };
    };
    class aiCleanUp // Contains settings for removal of items from each AI that gets eliminated
    {
        aiDeathRemovalEffect = no; // enable/disable the "death effect" from Virtual Arsenal. Flashes AI and deletes it after being eliminated
        removeHeadGear = no; // enable/disable removal of headgear after AI has been eliminated, obviously
        removeLaunchers = yes; // enable/disable removal of rocket launchers from AI after they are eliminated
    };
    class aiInventory{
        class Guerilla{
            backpacks[] = {
                "B_AssaultPack_khk", "B_AssaultPack_dgtl", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_AssaultPack_cbr",
                "B_AssaultPack_mcamo", "B_TacticalPack_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_blk",
                "B_TacticalPack_oli", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oucamo", "B_FieldPack_cbr",
                "B_FieldPack_blk", "B_Carryall_ocamo", "B_Carryall_oucamo", "B_Carryall_mcamo", "B_Carryall_khk", "B_Carryall_cbr",
                "B_FieldPack_oli", "B_Carryall_oli", "B_Kitbag_Base", "B_Kitbag_cbr", "B_Kitbag_mcamo",
                "B_Kitbag_rgr", "B_Kitbag_sgg", "B_OutdoorPack_Base", "B_OutdoorPack_blk", "B_OutdoorPack_blu", "B_OutdoorPack_tan"
            };
            faceWear[] = { "G_Aviator", "G_Balaclava_blk", "G_Balaclava_oli", "G_Bandanna_aviator", "G_Bandanna_beast", "G_Bandanna_blk", "G_Bandanna_khk", "G_Bandanna_oli", "G_Bandanna_sport", "G_Bandanna_tan" };
            headGear[] = {
                "H_Bandanna_gry", "H_Bandanna_blu", "H_Bandanna_cbr", "H_Bandanna_khk_hs", "H_Bandanna_khk", "H_Bandanna_sgg", "H_Bandanna_sand", "H_Bandanna_camo", "H_Watchcap_blk",
                "H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_khk", "H_Beret_blk", "H_Cap_blk", "H_Cap_grn", "H_Cap_oli", "H_Cap_oli_hs", "H_Cap_tan", "H_Cap_brn_SPECOPS", "H_MilCap_gry",
                "H_MilCap_ocamo", "H_Shemag_olive", "H_Shemag_olive_hs", "H_ShemagOpen_tan", "H_ShemagOpen_khk"
            };
            launchers[] = { "launch_NLAW_F", "launch_RPG32_F" };
            rifles[] = {
                "arifle_Katiba_F", "arifle_Katiba_C_F", "srifle_EBR_F", "arifle_Mk20_plain_F", "arifle_Mk20_F", "arifle_Mk20_GL_plain_F", "arifle_Mk20_GL_F", "LMG_Mk200_F", "arifle_Mk20C_plain_F",
                "arifle_Mk20C_F", "arifle_MX_F", "arifle_MX_Black_F", "arifle_MX_SW_F", "arifle_MX_SW_Black_F", "arifle_MXC_F", "arifle_MXC_Black_F", "arifle_MXM_F", "arifle_MXM_Black_F",
                "srifle_DMR_01_F", "arifle_TRG20_F", "arifle_TRG21_F", "SMG_01_F", "LMG_Zafir_F"
            };
            uniforms[] = {
                "U_BG_Guerrilla_6_1", "U_BG_Guerilla1_1", "U_BG_Guerilla2_2", "U_BG_Guerilla2_1", "U_BG_Guerilla2_3", "U_BG_Guerilla3_1", "U_BG_leader"
            };
            vests[] = {
                "V_PlateCarrier1_rgr", "V_PlateCarrier2_rgr", "V_PlateCarrier3_rgr", "V_PlateCarrierGL_rgr", "V_PlateCarrier1_blk",
                "V_PlateCarrierSpec_rgr", "V_Chestrig_khk", "V_Chestrig_rgr", "V_Chestrig_blk", "V_Chestrig_oli", "V_TacVest_khk",
                "V_TacVest_brn", "V_TacVest_oli", "V_TacVest_blk", "V_TacVest_camo", "V_TacVest_blk_POLICE", "V_TacVestIR_blk", "V_TacVestCamo_khk",
                "V_HarnessO_brn", "V_HarnessOGL_brn", "V_HarnessO_gry", "V_HarnessOGL_gry", "V_HarnessOSpec_brn", "V_HarnessOSpec_gry",
                "V_PlateCarrierIA1_dgtl", "V_PlateCarrierIA2_dgtl", "V_PlateCarrierIAGL_dgtl", "V_PlateCarrierL_CTRG", "V_PlateCarrierH_CTRG", "V_I_G_resistanceLeader_F"
            };
        };
    };
    
}; // Do not touch this line

