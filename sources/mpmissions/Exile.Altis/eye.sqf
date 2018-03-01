/*
EYE 1.0
Author: Zapat
Shows all units on map in a relatively system friendly way.

Dot: infantry
Rectangle: ground vehicles
Triangle: air vehicles

Blue: west
Red: east
Green: Independent
Black: civilian OR damaged in movement thus left vehicle

Orange: player
Yellow: player's team

*/

//you can turn on and off the EYE by the following Global Variable 
EYE_run = true;
player sideChat "EYE is running";
EYE_targets_obj = [];
EYE_markers_str = [];

//data handler
[] spawn 
{
    while {EYE_run} do
    {
        sleep 2;
        EYE_targets_obj = position player nearEntities [["LandVehicle","Air","CAManBase"], 20000];
        EYE_targets_str = [];
        {
            EYE_targets_str set [count EYE_targets_str, format["%1",_x]];
        }foreach EYE_targets_obj;
        _deleted = EYE_markers_str - EYE_targets_str;
        {
            deleteMarker _x;
            EYE_markers_str = EYE_markers_str - [_x];
        }foreach _deleted;
    };
    player sideChat "EYE thread 1 finished" ;
};

//visualiser
[] spawn
{
    while {EYE_run} do
    {
        sleep 0.5;
        {
            if (!isNull _x) then
            {
                _marker = format["%1",_x];
                //create marker
                if (getMarkerType _marker == "") then
                {
                    _m = createMarkerLocal[_marker,position _x];
                    _m setMarkerShape "ICON";
                    if (_x isKindof "CAManBase") then {_m setMarkerTypeLocal "hd_dot";};
                    if (_x isKindof "LandVehicle") then {_m setMarkerTypeLocal "mil_box";};                    
                    if (_x isKindof "Air") then {_m setMarkerTypeLocal "mil_triangle";};
                    if (side _x == east) then {_m setMarkerColor "ColorOPFOR";};
                    if (side _x == west) then {_m setMarkerColor "ColorBLUFOR";};
					if (side _x == Independent) then {_m setMarkerColor "ColorIndependent";};
           //if (side _x == Civilian) then {_m setMarkerColor "ColorCivilian";};
                    if (_x in units group player) then {_m setMarkerColor "ColorYellow";};
                    if (_x == player) then {_m setMarkerColor "ColorOrange";};
                    EYE_markers_str set [count EYE_markers_str, _marker];
                }
                //update marker
                else
                {
                    _marker setMarkerPosLocal position _x;
                    if (getMarkerColor _marker != "ColorBlack" && (!alive _x || !canMove _x) ) then {_marker setMarkerColor "ColorBlack"};
                };
            };
        }foreach EYE_targets_obj;
    };


    {
        deleteMarkerLocal _x;
    }foreach EYE_markers_str;
    player sideChat "EYE thread 2 finished" ;
};
