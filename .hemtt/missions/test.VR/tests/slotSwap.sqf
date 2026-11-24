// Slot swap test (#295): the player smokes or sucks something in the facewear / NVG slot and then changes that slot.
// Nothing may be deleted or copied: the item swapped in stays in the slot, the one taken out is in the inventory once,
// and nothing lands on the ground. Putting it out and finishing it still remove it from the slot.
//
// The inventory drags are emulated by script (the engine moves the old item into the inventory, so the test adds it there).
// The mod notices through the SlotItemChanged event, or else through the loop's own check within 20-30 s.
// Needs a player. Takes about 2 minutes and changes the player's facewear, NVG and uniform items; they are restored at the end.
// Results go to systemChat, the RPT ("[cigs][test]") and a hint.

if (!hasInterface) exitWith {};
waitUntil { !isNull player && { time > 1 } };
sleep 3;

private _unit = player;
private _results = [];

private _log = {
    params ["_line"];
    diag_log text ("[cigs][test] " + _line);
    systemChat _line;
};

private _check = {
    params ["_name", "_got", "_expected"];
    private _ok = _got isEqualTo _expected;
    _results pushBack [_name, _ok];
    [format ["%1  %2%3", ["FAIL", "PASS"] select _ok, _name, ["  - got " + str _got + ", expected " + str _expected, ""] select _ok]] call _log;
};

private _slot = {
    params ["_type"];
    [hmd _unit, goggles _unit] select (_type isEqualTo "GOGGLES")
};

private _inInventory = {
    params ["_class"];
    { _x isEqualTo _class } count items _unit
};

private _onGround = {
    params ["_class"];
    private _n = 0;
    { _n = _n + ({ _x isEqualTo _class } count (itemCargo _x + weaponCargo _x)) } forEach (_unit nearObjects ["WeaponHolder", 5]);
    _n
};

private _empty = {
    if (goggles _unit isNotEqualTo "") then { removeGoggles _unit };
    if (hmd _unit isNotEqualTo "") then { _unit unlinkItem hmd _unit };
};

// Removes the given items in every burn stage (cigs_morley_cig0 also clears cig1, cig2, ... and the _nv versions):
// a case ends with a later stage than it started with, and a leftover would count in the next case.
private _clear = {
    params ["_classes"];
    call _empty;
    private _stems = (_classes select { _x isNotEqualTo "" }) apply { _x regexReplace ["\d*(_nv)?$", ""] };
    { if ((_x regexReplace ["\d*(_nv)?$", ""]) in _stems) then { _unit removeItem _x } } forEach items _unit;
    { deleteVehicle _x } forEach (_unit nearObjects ["WeaponHolder", 5]);
};

private _equip = {
    params ["_type", "_class"];
    if (_type isEqualTo "GOGGLES") then { _unit addGoggles _class } else { _unit linkItem _class };
};

// Waits until the consume loop has stopped (loopData is cleared by loopStop). Returns the seconds it took, -1 on timeout.
// 70 s: without the event the loop's own check comes after 20-30 s divided by the smoking frequency setting.
private _waitStopped = {
    private _t = time;
    waitUntil { sleep 0.5; isNil { _unit getVariable "cigs_loopData" } || { time - _t > 70 } };
    sleep 2;    // the drop happens in loopStop, give the animation and the weapon holder a moment
    [-1, round (time - _t)] select (isNil { _unit getVariable "cigs_loopData" })
};

// One case: equip _item in _type's slot, start consuming, do _action, check the outcome.
private _case = {
    params ["_name", "_consume", "_type", "_item", "_action", ["_swapTo", ""]];

    [[_item, _swapTo]] call _clear;
    [_type, _item] call _equip;
    if (_consume isEqualTo "SMOKE") then { [_unit] call cigs_core_fnc_smoking_start } else { [_unit] call cigs_core_fnc_sucking_start };
    sleep 4;
    if ( isNil { _unit getVariable "cigs_loopData" } ) exitWith {
        _results pushBack [_name, false];
        [format ["FAIL  %1  - didn't start %2", _name, _consume]] call _log;
    };

    // the item burns on to the next stage (another class) while it's smoked, so act on and check what's in the slot now
    _item = [_type] call _slot;

    switch (_action) do {
        case "swap": {
            // the engine puts the old item into the inventory and the new one into the slot
            _unit addItem _item;
            [_type, _swapTo] call _equip;
        };
        case "out": {
            if (_type isEqualTo "GOGGLES") then { removeGoggles _unit } else { _unit unlinkItem _item };
            _unit addItem _item;
        };
        case "stop": {
            _unit setVariable ["cigs_isConsuming", false, true];    // what the put out / stop action does
        };
        case "finish": {
            private _data = _unit getVariable "cigs_loopData";
            _data set ["curConsumes", (_data get "totalConsumes") + 1];
            _unit setVariable ["cigs_isConsuming", false, true];
        };
    };

    private _took = call _waitStopped;
    if (_took < 0) exitWith {
        _results pushBack [_name, false];
        [format ["FAIL  %1  - the loop didn't stop within 70 s (slot: %2)", _name, [_type] call _slot]] call _log;
        // stop it, so the next case can start
        _unit setVariable ["cigs_isConsuming", false, true];
        call _waitStopped;
    };

    private _slotNow = [_type] call _slot;
    private _inv = [_item] call _inInventory;
    private _ground = [_item] call _onGround;
    switch (_action) do {
        case "swap":   { [_name, [_slotNow, _inv, _ground], [_swapTo, 1, 0]] call _check };
        case "out":    { [_name, [_slotNow, _inv, _ground], ["", 1, 0]] call _check };
        // put out: gone from the slot, not in the inventory, at most one on the ground (dropped or vanished at random)
        case "stop":   { [_name, [_slotNow, _inv, _ground <= 1], ["", 0, true]] call _check };
        case "finish": { [_name, [_slotNow, _inv, _ground], ["", 0, 0]] call _check };
    };
};


// ---------------------------------------------------------------- setup
private _savedGoggles = goggles _unit;
private _savedHmd = hmd _unit;
private _addedUniform = false;
if (uniform _unit isEqualTo "") then { _unit forceAddUniform "U_B_CombatUniform_mcam"; _addedUniform = true };
_unit setVariable ["cigs_isConsuming", false, true];

private _cig    = "cigs_morley_cig0";
private _cigNv  = "cigs_morley_cig0_nv";
private _cigar  = "cigs_cigars_cigar0";
private _cigarNv = "cigs_cigars_cigar0_nv";
private _crayon = "cigs_crayons_crayon_black";

["---- Slot swap tests (#295), about 2 minutes ----"] call _log;

// ---------------------------------------------------------------- swaps: the item swapped in must stay, no copy of the cigarette
["swap: cigar into the facewear slot",    "SMOKE", "GOGGLES", _cig,    "swap", _cigar]   call _case;
["swap: cigar into the NVG slot",         "SMOKE", "HMD",     _cigNv,  "swap", _cigarNv] call _case;
["swap: cigar over a crayon (facewear)",  "SUCK",  "GOGGLES", _crayon, "swap", _cigar]   call _case;

// ---------------------------------------------------------------- dragged out: the copy came at random, so three times each
for "_i" from 1 to 3 do {
    [format ["out: cigarette out of the facewear slot #%1", _i], "SMOKE", "GOGGLES", _cig,   "out"] call _case;
};
["out: cigarette out of the NVG slot",    "SMOKE", "HMD",     _cigNv,  "out"] call _case;

// ---------------------------------------------------------------- normal ends still remove the item
["stop: put out (facewear)",              "SMOKE", "GOGGLES", _cig,    "stop"]   call _case;
["stop: put out (NVG)",                   "SMOKE", "HMD",     _cigNv,  "stop"]   call _case;
["finish: crayon finished (facewear)",    "SUCK",  "GOGGLES", _crayon, "finish"] call _case;


// ---------------------------------------------------------------- restore
[[_cig, _cigNv, _cigar, _cigarNv, _crayon]] call _clear;
if (_savedGoggles isNotEqualTo "") then { _unit addGoggles _savedGoggles };
if (_savedHmd isNotEqualTo "") then { _unit linkItem _savedHmd };
if (_addedUniform) then { removeUniform _unit };

private _failed = _results select { !(_x # 1) };
private _summary = format ["Slot swap tests: %1 passed, %2 failed", count _results - count _failed, count _failed];
[_summary] call _log;
if ( _failed isNotEqualTo [] ) then { ["Failed: " + (( _failed apply { _x # 0 }) joinString ", ")] call _log; };
hint _summary;
