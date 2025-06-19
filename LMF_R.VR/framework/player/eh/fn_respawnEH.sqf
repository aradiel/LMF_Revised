// PLAYER RESPAWN EH //////////////////////////////////////////////////////////////////////////////
/*
	* Author: Alex2k, G4rrus
	* EH that handles what happens if the player gets respawned.
	*
	* Arguments:
	* 0: <NONE>
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _doOnRespawn = {
	//FORCE PRONE ON BODYBAG RESPAWN
	if(var_useBodyBags) then {player playAction "PlayerProne";}
	
	//BLACK FADE
	cutText  ["", "BLACK FADED", 10, true];

	//MOVE OUT OF ACE SPECTATOR
	[false] call ace_spectator_fnc_setSpectator;

	//PLAYER GEAR
	if (!isNil "old_loadout" && var_bodybagKeepInventory) then {player setUnitLoadout old_loadout; [player] call lmf_loadout_fnc_addWeapons}
	else {
		if (var_playerGear) then {
			if !(var_keepRole) then {
				[player] call lmf_loadout_fnc_rifleman;
			} else {
				[player] call lmf_player_fnc_initPlayerGear;
			};
		};
	};

	//CHANNEL SETUP
	0 enableChannel false;
	1 enableChannel true;
	2 enableChannel false;
	3 enableChannel true;
	4 enableChannel false;
	5 enableChannel false;

	//FADE IN SET THE CHANNEL BACK TO GROUP AND SET THE CAMOCOEF BACK ASWELL AND SET RADIO CHANNEL
	[] spawn {
		sleep 5;
		setCurrentChannel 3;
		[{player setUnitTrait ["camouflageCoef",var_camoCoef];}, [], 5] call CBA_fnc_waitAndExecute;
		[] spawn lmf_loadout_fnc_acreChannelPreset;
		cutText  ["", "BLACK IN", 5, true];
	};
};


// APPLY //////////////////////////////////////////////////////////////////////////////////////////
if !(var_useJRM) then {
	[] spawn _doOnRespawn;
} else {
	sleep 2;
	[{!ace_spectator_isSet},_doOnRespawn, []] call CBA_fnc_waitUntilAndExecute;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////