// AI cigs live test report: for each unit of the live row, lists the packs it carries and checks that they all
// come from what getCigItems allows. A unit without packs is reported, but doesn't fail: the probability may be below 100%.

if (!isServer) exitWith { [] remoteExec ["cigs_test_fnc_reportFactions", 2] };

private _isPack = { getNumber (configFile >> "CfgMagazines" >> _x >> "cigs_isPack") isEqualTo 1 };
private _failed = 0;
private _empty = 0;
private _units = ( missionNamespace getVariable ["cigs_test_liveUnits", []] ) select { alive _x };

{
    private _unit = _x;
    private _carried = ( magazineCargo uniformContainer _unit ) select _isPack;
    private _allowed = [_unit] call cigs_ai_fnc_getCigItems;
    private _foreign = _carried select { !(_x in _allowed) };
    private _result = switch (true) do {
        case ( _carried isEqualTo [] ): { _empty = _empty + 1; "NONE" };
        case ( _foreign isNotEqualTo [] ): { _failed = _failed + 1; "FAIL" };
        default { "PASS" };
    };
    private _line = format ["%1  %2 (%3): %4%5", _result, _unit getVariable ["cigs_test_faction", faction _unit], typeOf _unit, _carried arrayIntersect _carried, ["", "  - not allowed: " + str _foreign] select (_foreign isNotEqualTo [])];
    diag_log text ("[cigs][test] " + _line);
    _line remoteExec ["systemChat", 0];
} forEach _units;

private _summary = format ["AI cigs live test: %1 units, %2 failed, %3 without packs", count _units, _failed, _empty];
diag_log text ("[cigs][test] " + _summary);
_summary remoteExec ["hint", 0];
