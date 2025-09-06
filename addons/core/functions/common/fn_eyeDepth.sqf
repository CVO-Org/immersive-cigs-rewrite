#include "../../script_component.hpp"

/*
  Name: TFAR_fnc_eyeDepth
  License: https://github.com/michail-nikolaev/task-force-arma-3-radio?tab=License-1-ov-file

  Author: Garth de Wet (L-H)
    returns the eyepos of a unit

  Arguments:
    unit <OBJECT>

  Return Value:
    Position ASLW <ARRAY>

  Example:
    player call TFAR_fnc_eyeDepth;

  Public: Yes
*/

((eyePos _this) select 2) + ((getPosASLW _this) select 2) - ((getPosASL _this) select 2)
