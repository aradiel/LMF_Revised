// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus, Aradiel
	* Apply Weapons Loadout.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Unit <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_loadout_fnc_addWeapons;
	*
	* Return Value:
	* <BOOL> true if settings were applied, else false
*/

// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _unit || {!local _unit}) exitWith {false};

#include "..\..\..\settings\cfg_Player.sqf"

// APPLY NEW ROLE SPECIFIC WEAPON ////////////////////////////////////////////////////////////////
_primary = primaryWeapon _unit;
_unit removeWeapon _primary;



private _role = typeOf _unit;


// CALL LOADOUT /////////////////////////////////////////////////////////////////////////
if (_role isEqualTo _PlatoonLeader) exitWith {[_unit,_Gun_PltL] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _PlatoonSgt) exitWith {[_unit,_Gun_PltSgt] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _RTO) exitWith {[_unit,_Gun_Rto] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _FAC) exitWith {[_unit,_Gun_Fac] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _SquadLeader) exitWith {[_unit,_Gun_Sql] call lmf_loadout_fnc_givePrimaryNoAmmor};
if (_role isEqualTo _TeamLeader) exitWith {[_unit,_Gun_Tl] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _Rifleman) exitWith {[_unit,_Gun_Rif] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _Grenadier) exitWith {[_unit,_Gun_Gren] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _Autorifleman) exitWith {[_unit,_Gun_Ar] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _Marksman) exitWith {[_unit,_Gun_Mark] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _Medic) exitWith {[_unit,_Gun_Cls] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _AmmoBearer) exitWith {[_unit,_Gun_AB] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _MachineGunner) exitWith {[_unit,_Gun_MMG] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _MgAssistant) exitWith {[_unit,_Gun_MMGA] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _AntiTankGunner) exitWith {[_unit,_Gun_AT] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _AtAssistant) exitWith {[_unit,_Gun_ATA] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _Engineer) exitWith {[_unit,_Gun_Eng] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _Crew) exitWith {[_unit,_Gun_Crew] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _HeloPilot) exitWith {[_unit,_Gun_HP] call lmf_loadout_fnc_givePrimaryNoAmmo};
if (_role isEqualTo _HeloCrew) exitWith {[_unit,_Gun_HC] call lmf_loadout_fnc_givePrimaryNoAmmo};
//PRIMARY
[_unit,_Gun_ATA] call lmf_loadout_fnc_givePrimaryNoAmmo;

//SIDEARM
if (var_pistolAll) then {
	if (_Pistol_Ammo select 0 == "") then {_Pistol_Ammo = 0;} else {_Pistol_Ammo = selectRandom _Pistol_Ammo};
	[_unit, selectRandom _Pistol, 1, _Pistol_Ammo] call BIS_fnc_addWeapon;
	_unit addHandgunItem (selectRandom _Pistol_Attach1);
	_unit addHandgunItem (selectRandom _Pistol_Attach2);
};

true