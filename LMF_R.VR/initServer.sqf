// INIT SERVER/////////////////////////////////////////////////////////////////////////////////////
/*
	- Executed only on server when mission is started.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////

    //Death Screams
["CAManBase", "killed", {
    params ["_unit", ["_killer", objNull]];
    //if !(local _unit) exitWith {};
    // if (isPlayer _unit || !(local _unit)) exitWith {};

    [_unit] spawn {
        params[["_unit", objNull]];

        if (isNull _unit) exitWith {};
        if (_unit != vehicle _unit) exitWith {};
        if (side _unit == civilian) exitWith{};
        // scream 2 out of 3 times
        //if((floor random 4) == 0) exitWith {};

        //sleep random 2;
        private _proxy = "building" createVehicle position _unit;
        _proxy attachTo [_unit, [0, 0, 0.5], "Head"];

        // if( !(_unit getVariable["ACE_isUnconscious",false]) ) then {

        private _behaviour = behaviour _unit;
        private _snd = selectRandom [
            "\z\ace\addons\fire\sounds\scream13.ogg",
            "\z\ace\addons\fire\sounds\scream12.ogg",
            "\z\ace\addons\fire\sounds\scream10.ogg",
            "\z\ace\addons\fire\sounds\scream8.ogg",
            "\z\ace\addons\fire\sounds\scream6.ogg",
            "\z\ace\addons\fire\sounds\scream3.ogg"
        ];

        // play sound on all machines
        [_snd, _proxy, false, getPosASL _proxy, 10, 1.1, 75] remoteExec ["playSound3D"];
        playSound3d [_snd, _proxy, false, getPosASL _proxy, 10, 1.1, 75];
        sleep 10;
        detach _proxy;
        deleteVehicle _proxy;
        //hint "fark"
    };
}] call CBA_fnc_addClassEventHandler;

//blood pools on unit death
["CAManBase", "killed", {
    params ["_unit"];
    if !(isNull objectParent _unit) exitWith {};
    [{
        params ["_unit"];
        if (((getPosATL _unit) select 2) < 1) then {
            private _bloods = [
                "a3\Props_F_Orange\Humanitarian\Garbage\BloodPool_01_Large_F.p3d",
                "a3\Props_F_Orange\Humanitarian\Garbage\BloodPool_01_Medium_F.p3d",
                "a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Large_F.p3d",
                "a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Medium_F.p3d",
                "a3\Props_F_Orange\Humanitarian\Garbage\BloodSpray_01_F.p3d"
            ];
            private _pos = (getPosWorld _unit) vectorAdd [0,0,0.05];
            private _blood = createSimpleObject [selectRandom _bloods, _pos];
            _blood setDir random 360;
            _blood setVectorUp surfaceNormal position _blood;

            // Using ACE's medical_blood module to handle clean up (server only)
            ["ace_medical_blood_bloodDropCreated", [_blood]] call CBA_fnc_localEvent;
        };
    }, [_unit], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addClassEventHandler;