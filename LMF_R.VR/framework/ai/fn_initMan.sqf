// INIT AI MAN ////////////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Apply unit specific code to AI soldiers.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Unit <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_ai_fnc_initMan;
	*
	* Return Value:
	* <BOOL> true if settings were applied else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _unit || {!local _unit}) exitWith {false};

#include "..\..\settings\cfg_AI.sqf"


// CHECK WHO GETS WHAT GEAR ///////////////////////////////////////////////////////////////////////
private _type = typeOf _unit;
private _allTypesAA = [_Autorifleman, _Crew, _Grenadier, _MMG_Gunner, _Marksman, _AA_Gunner, _MAT_Gunner, _Officer, _Pilot, _Rifleman, _Rifleman_AT, _Squad_Leader, _Static_Gunner, _Static_Assistant];


// APPLY EVENT HANDLERS ///////////////////////////////////////////////////////////////////////////
//IS ACTUALLY DONE VIA AN EVENT IN XEH_POSTINIT TO AVOID ISSUES WITH LOCALITY CHANGE
["lmf_ai_listener", [_unit, _type == _Autorifleman || {_type == _MMG_Gunner}]] call CBA_fnc_localEvent;


// APPLY SKILL ////////////////////////////////////////////////////////////////////////////////////
private _skill_untrained = skill _unit * selectRandom [0.01,0.03,0.05,0.10,0.15];
private _skill_regular = skill _unit * selectRandom [0.35,0.45,0.50,0.55,0.60];
private _skill_elite = skill _unit * selectRandom [0.85,0.90,0.95,1.05,1.10];
if (_var_enemySkill == 0) then {_unit setSkill _skill_untrained;};
if (_var_enemySkill == 1) then {_unit setSkill _skill_regular;};
if (_var_enemySkill == 2) then {_unit setSkill _skill_elite;};
_unit setSkill ["spotDistance", 1];
_unit setSkill ["spotTime", 1];

// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//GIVE NVG
if (_var_enemyNVG) then {
	_unit linkItem "NVGoggles_OPFOR";
};

//EXIT IF NO CUSTOM GEAR
if !(_var_enemyGear) exitwith {true};
if (_allTypesAA findif {_type == _x} == -1) exitWith {true};

//REMOVE OLD STUFF
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

//REASSIGN NVG
if (_var_enemyNVG) then {
	_unit linkItem "NVGoggles_OPFOR";
};

//CHOOSE CLOTHING
private _s_Uniform = selectRandom _Uniform;
private _s_Vest = selectRandom _Vest;
private _s_Backpack = selectRandom _Backpack_Light;
private _s_Headgear = selectRandom _Headgear;
private _s_Goggles = selectRandom _Goggles;

if (_type == _MMG_Gunner || {_type == _MAT_Gunner || {_type == _AA_Gunner}}) then {
	_s_Backpack = selectRandom _Backpack_Heavy;
};

if (_type == _Pilot) then {
	_s_Uniform = selectRandom _Heli_Uniform;
	_s_Vest = selectRandom _Heli_Vest;
	_s_Headgear = selectRandom _Heli_Headgear;
	_s_Backpack = "B_parachute";
};

if (_type == _Crew) then {
	_s_Uniform = selectRandom _Crew_Uniform;
	_s_Vest = selectRandom _Crew_Vest;
	_s_Headgear = selectRandom _Crew_Headgear;
};

if (_type == _Static_Gunner) then {
	_s_Backpack = selectRandom _Backpack_Static;
};

if (_type == _Static_Assistant) then {
	_s_Backpack = selectRandom _Backpack_Static_Pod;
};

//ADD CLOTHING
_unit forceAddUniform _s_Uniform;
_unit addVest _s_Vest;
_unit addHeadgear _s_Headgear;
_unit addBackpack _s_Backpack; clearAllItemsFromBackpack _unit;
if (10 > random 100) then {_unit addGoggles _s_Goggles};


// WEAPONS ////////////////////////////////////////////////////////////////////////////////////////
//RIFL
if (_type == _Rifleman || {_type == _Static_Gunner || {_type == _Static_Assistant}}) then {
	if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
	[_unit, selectRandom _Rifle, 12, _Rifle_Ammo] call BIS_fnc_addWeapon;
};

//AR
if (_type == _Autorifleman) then {
	if (_LMG_Ammo select 0 == "") then {_LMG_Ammo = 0;} else {_LMG_Ammo = selectRandom _LMG_Ammo};
	[_unit, selectRandom _LMG, 10, _LMG_Ammo] call BIS_fnc_addWeapon;
};

//LAT
if (_type == _Rifleman_AT) then {
	if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
	if (_LAT_Ammo select 0 == "") then {_LAT_Ammo = 0;} else {_LAT_Ammo = selectRandom _LAT_Ammo};
	[_unit, selectRandom _Rifle, 12, _Rifle_Ammo] call BIS_fnc_addWeapon;
	[_unit, selectRandom _LAT, 1, _LAT_Ammo] call BIS_fnc_addWeapon;
};

//GL AND SQL
if (_type == _Grenadier || {_type == _Squad_Leader}) then {
	if (_Rifle_GL_Ammo select 0 == "") then {_Rifle_GL_Ammo = 0;} else {_Rifle_GL_Ammo = selectRandom _Rifle_GL_Ammo};
	for "_i" from 1 to 4 do {_unit addItem selectRandom _Rifle_GL_Flare;};
	for "_i" from 1 to 4 do {_unit addItem selectRandom _Rifle_GL_Smoke;};
	[_unit, selectRandom _Rifle_GL, 10, _Rifle_GL_Ammo] call BIS_fnc_addWeapon;
};

//MG
if (_type == _MMG_Gunner) then {
	if (_MMG_Ammo select 0 == "") then {_MMG_Ammo = 0;} else {_MMG_Ammo = selectRandom _MMG_Ammo};
	[_unit, selectRandom _MMG, 10, _MMG_Ammo] call BIS_fnc_addWeapon;

};

//MAT
if (_type == _MAT_Gunner) then {
	if (_MAT_Ammo select 0 == "") then {_MAT_Ammo = 0;} else {_MAT_Ammo = selectRandom _MAT_Ammo};
	[_unit, selectRandom _MAT, 6, _MAT_Ammo] call BIS_fnc_addWeapon;
};

//MARK
if (_type == _Marksman) then {
	if (_DMR_Ammo select 0 == "") then {_DMR_Ammo = 0;} else {_DMR_Ammo = selectRandom _DMR_Ammo};
	[_unit, selectRandom _DMR, 10, _DMR_Ammo] call BIS_fnc_addWeapon;

};

//CREW AND PILOT
if (_type == _Crew || {_type == _Pilot}) then {
	if (_Carbine_Ammo select 0 == "") then {_Carbine_Ammo = 0;} else {_Carbine_Ammo = selectRandom _Carbine_Ammo};
	[_unit, selectRandom _Carbine, 10, _Carbine_Ammo] call BIS_fnc_addWeapon;
};

//AA
if (_type == _AA_Gunner) then {
	if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
	if (_AA_Ammo select 0 == "") then {_AA_Ammo = 0;} else {_AA_Ammo = selectRandom _AA_Ammo};
	[_unit, selectRandom _Rifle, 12, _Rifle_Ammo] call BIS_fnc_addWeapon;
	[_unit, selectRandom _AA, 4, _AA_Ammo] call BIS_fnc_addWeapon;

};

//OFF
if (_type == _Officer) then {
	if (_Pistol_Ammo select 0 == "") then {_Pistol_Ammo = 0;} else {_Pistol_Ammo = selectRandom _Pistol_Ammo};
	[_unit, selectRandom _Pistol, 10, _Pistol_Ammo] call BIS_fnc_addWeapon;
};


// MISC LOOT //////////////////////////////////////////////////////////////////////////////////////
//ADD GRENADES
_unit addItem selectRandom _Grenade;
_unit addItem selectRandom _Grenade_Smoke;

//ADD FAK
for "_i" from 1 to 3 do {_unit addItem "FirstAidKit";};

//WEAPON ATTACH
removeAllPrimaryWeaponItems _unit;
if (_type != _Marksman) then {
	if (30 > random 100) then {_unit addPrimaryWeaponItem selectRandom _Attach;};
	if (50 > random 100) then {_unit addPrimaryWeaponItem selectRandom _Optic;};
} else {
	_unit addPrimaryWeaponItem selectRandom _Optic_L;
};

//GIVE GOODIES
if (_var_enemyGoodies && {30 > random 100}) then {
	for "_i" from 1 to 4 do {_unit addItem "ACE_packingBandage";};
	_unit addItem "ACE_morphine";
	_unit addItem "ACE_bloodIV";
};

//MISC
if (_unit == leader group _unit || {_type == _MAT_Gunner || {_type == _Crew}}) then {_unit addWeapon "Binocular"};

//Identity
[_unit, selectRandom _Faces, selectRandom _Speakers] call BIS_fnc_setIdentity;

//Name
if(_var_enemyGenericNames) then {
	_unit setName[format["%1 %2",_factionName,_type], _factionName, _type];
} else {
	_name = selectRandom _firstNames;
	_surname = selectRandom _lastNames;
	_unit setName[format["%1 %2",_name,_surname], _name, _surname];
}

// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true