// GIVE CORRECT PRIMARY WEAPON TO PLAYER WITH NO EXTRA MAGS //////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Give weapon according to number.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Unit <OBJECT>
	* 1: Weapon <NUMBER> Which number corresponds with which weapon can be seen in cfg_Player
	*
	* Example:
	* [player, 3] call lmf_loadout_fnc_givePrimary;
	*
	* Return Value:
	* <BOOL> true if settings were applied else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull,[objNull]],["_weapon",3,[123]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _unit || {!local _unit}) exitWith {false};

#include "..\..\..\settings\cfg_Player.sqf"


// APPLY CORRECT WEAPON ///////////////////////////////////////////////////////////////////////////
private _amount = 5;

switch (_weapon) do {
	case 1: {
		if (_SMG_Ammo select 0 == "") then {_SMG_Ammo = 0;} else {_SMG_Ammo = selectRandom _SMG_Ammo};
		[_unit, selectRandom _SMG, 1, _SMG_Ammo] call BIS_fnc_addWeapon;
		_unit addPrimaryWeaponItem (selectRandom _SMG_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _SMG_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _SMG_Optic);
		_unit addPrimaryWeaponItem (selectRandom _SMG_Bipod);
	};
	case 2: {
		if (_Carbine_Ammo select 0 == "") then {_Carbine_Ammo = 0;} else {_Carbine_Ammo = selectRandom _Carbine_Ammo};
		[_unit, selectRandom _Carbine, 1, _Carbine_Ammo] call BIS_fnc_addWeapon;
		for "_i" from 1 to _Carbine_Ammo_T_Amount do {_unit addItem (selectRandom _Carbine_Ammo_T);};
		_unit addPrimaryWeaponItem (selectRandom _Carbine_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _Carbine_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _Carbine_Optic);
		_unit addPrimaryWeaponItem (selectRandom _Carbine_Bipod);
	};
	case 3: {
		if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
		[_unit, selectRandom _Rifle, 1, _Rifle_Ammo] call BIS_fnc_addWeapon;
		for "_i" from 1 to _Rifle_Ammo_T_Amount do {_unit addItem (selectRandom _Rifle_Ammo_T);};
		_unit addPrimaryWeaponItem (selectRandom _Rifle_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_Optic);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_Bipod);
	};
	case 4: {
		if (_Rifle_GL_Ammo select 0 == "") then {_Rifle_GL_Ammo = 0;} else {_Rifle_GL_Ammo = selectRandom _Rifle_GL_Ammo};
		[_unit, selectRandom _Rifle_GL, 1, _Rifle_GL_Ammo] call BIS_fnc_addWeapon;
		/*for "_i" from 1 to _Rifle_GL_Ammo_T_Amount do {_unit addItem (selectRandom _Rifle_GL_Ammo_T);};
		for "_i" from 1 to _Rifle_GL_UGL1_Amount do {_unit addItem (selectRandom _Rifle_GL_UGL1);};
		for "_i" from 1 to _Rifle_GL_UGL2_Amount do {_unit addItem (selectRandom _Rifle_GL_UGL2);};
		for "_i" from 1 to _Rifle_GL_UGL3_Amount do {_unit addItem (selectRandom _Rifle_GL_UGL3);};
		for "_i" from 1 to _Rifle_GL_UGL4_Amount do {_unit addItem (selectRandom _Rifle_GL_UGL4);};*/
		_unit addPrimaryWeaponItem (selectRandom _Rifle_GL_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_GL_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_GL_Optic);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_GL_Bipod);
	};
	case 5: {
		if (_DMR_Ammo select 0 == "") then {_DMR_Ammo = 0;} else {_DMR_Ammo = selectRandom _DMR_Ammo};
		[_unit, selectRandom _DMR, 1, _DMR_Ammo] call BIS_fnc_addWeapon;
		_unit addPrimaryWeaponItem (selectRandom _DMR_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _DMR_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _DMR_Optic);
		_unit addPrimaryWeaponItem (selectRandom _DMR_Bipod);
	};
	case 6: {
		if (_LMG_Ammo select 0 == "") then {_LMG_Ammo = 0;} else {_LMG_Ammo = selectRandom _LMG_Ammo; _amount = 3;};
		[_unit, selectRandom _LMG, 1, _LMG_Ammo] call BIS_fnc_addWeapon;
		for "_i" from 1 to _LMG_Ammo_T_Amount do {_unit addItem (selectRandom _LMG_Ammo_T);};
		_unit addPrimaryWeaponItem (selectRandom _LMG_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _LMG_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _LMG_Optic);
		_unit addPrimaryWeaponItem (selectRandom _LMG_Bipod);
	};
	case 7: {
		if (_MMG_Ammo select 0 == "") then {_MMG_Ammo = 0;} else {_MMG_Ammo = selectRandom _MMG_Ammo};
		[_unit, selectRandom _MMG, 1, _MMG_Ammo] call BIS_fnc_addWeapon;
		_unit addPrimaryWeaponItem (selectRandom _MMG_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _MMG_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _MMG_Optic);
		_unit addPrimaryWeaponItem (selectRandom _MMG_Bipod);
	};
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true