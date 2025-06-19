// ON PLAYER RESPAWN //////////////////////////////////////////////////////////////////////////////
/*
	- Executed locally when player respawns in mission.
	  This event script will also fire at the beginning of a mission if respawnOnStart is 0 or 1.
	  This script will not fire at mission start if respawnOnStart equals -1.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////

if(var_useBodyBags) then {
	//Remove BodyBag respawn markers if force respawned
	params ["_newUnit","_oldUnit"];
	removeFromRemainsCollector [_oldUnit];
	_markerName = format ["%1_body",getPlayerUID _newUnit];
	_marker = createMarker [_markerName, position _oldUnit];
	_marker setMarkerType "hd_dot";
	_marker setMarkerText format ["%1's body",name _newUnit];
	_marker setMarkerSize [0.5,0.5];
	_marker setMarkerAlpha 0.3;
	markerTarget = _oldUnit;


	while {!isNull markerTarget} do {
		uisleep 5;
		_marker setMarkerPos getPos markerTarget;
	};

	deleteMarker _marker;
}