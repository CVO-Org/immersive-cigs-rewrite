# Readme for Mission and Mod Makers

## Public API Events
| Event Key                | Parameters                                      | Locality | Type   | Description            |
| ------------------------ | ----------------------------------------------- | -------- | ------ | ---------------------- |
| `cigs_api_takeFromPack`  | _unit, _class_cigpack, _item_glasses, _item_hmd | Local    | Listen | Sucking Loop           |
| `cigs_api_useLighter`    | _unit, _className, _type                        | Local    | Listen | Using a Lighter        |
| `cigs_api_eatCig`        | _unit, _item, _slot                             | Local    | Listen | Eating a Cigarette     |
| `cigs_api_startsSmoking` | _unit, _item, _slot                             | Local    | Listen | Starts Smoking         |
| `cigs_api_smoking`       | _unit, _currentTime, _currentItem, _itemType    | Local    | Listen | Smoking Loop           |
| `cigs_api_stopsSmoking`  | _unit, _currentTime, _currentItem, _itemType    | Local    | Listen | Stops Smoking          |
| `cigs_api_startsSucking` | _unit, _item, _slot                             | Local    | Listen | Starts Sucking         |
| `cigs_api_sucking`       | _unit, _currentTime, _currentItem, _itemType    | Local    | Listen | Sucking Loop           |
| `cigs_api_stopsSucking`  | _unit, _currentTime, _currentItem, _itemType    | Local    | Listen | Stops Sucking          |
| `cigs_api_respectPayed`  | _player, _target                                | Local    | Listen | Respect has beed given |

As of v3.0.7, API Event Keys have been renamed from `cigs_core_api` to `cigs_api`. 

## Unit Variable APIs
The following APIs can be used by `_unit setVariable [_apiKey, _value, true];`.
Make sure to broadcast the variable as the checks will be on the individual clients.

| ApiKey                     | Values | Desc                                                 |
| -------------------------- | ------ | ---------------------------------------------------- |
| `cigs_api_blockAnimations` | true   | Will block all cigs related animations on said unit. |


## Useful Functions
- `[_unit] call cigs_core_fnc_smoking_start;` - Lets a Unit - AI or Players - Start Smoking - Requires Smokeable Item in Glasses or HMD Slot
- `["PACKAGES"] call cigs_core_fnc_getAllItems;` - To retrieve all Packages classnames
- `["LIGHTERS"] call cigs_core_fnc_getAllItems;` - To retrieve all Lighters classnames
- `["ALL"] call cigs_core_fnc_getAllItems;` - To retrieve Both

<!-- - `[_unit, "cigs_baja_blast_cigpack"] call cigs_ai_fnc_startConsuming;` to give ai cigarettes and make them consume. --->
