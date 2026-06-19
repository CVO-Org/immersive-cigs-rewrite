#include "..\script_component.hpp"

/*
* Author: Zorn
* Returns the Effect Array based on the PPE Effect Type.
* Intensity of 0 Returns the "actual" default array.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [ "_effectName", ["_intensity", 0, [0]] ];

switch (_effectName) do {
    case "RadialBlur": {
        [
            [
                linearConversion [ 0, 1.0, _intensity,   0, 0.10, true ], // blurX
                linearConversion [ 0, 1.0, _intensity,   0, 0.10, true ], // blurY // Doesnt do shit?
                linearConversion [ 0, 1.0, _intensity, 0.5, 0.10, true ], // ClearCenterX
                linearConversion [ 0, 1.0, _intensity, 0.5, 0.10, true ]  // ClearCenterY
            ],
            [ 0, 0, 0.5, 0.5 ]
        ]
    };
    case "ChromAberration": {
        [
            [
                linearConversion [ 0, 1, _intensity, 0,  0.25, true ], // Strength X
                linearConversion [ 0, 1, _intensity, 0, -0.25, true ], // Strength Y
                true    // Aspect Ratio  (?)
            ],
            [ 0, 0, true ]
        ]
    };
    case "WetDistortion": {
        [
            [
                linearConversion [ 0, 0.5, _intensity, 0.00,  1.00, true ], // Blur
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.20, true ], // Strength Top
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.20, true ], // Strength Bottom
                linearConversion [ 0, 0.5, _intensity, 0.00,  1.00, true ], // Speed x1
                linearConversion [ 0, 0.5, _intensity, 0.00, -1.00, true ], // Speed x2
                linearConversion [ 0, 0.5, _intensity, 0.00,  1.00, true ], // Speed y1
                linearConversion [ 0, 0.5, _intensity, 0.00, -1.00, true ], // Speed y2
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.05, true ], // Wave Ampl. x1
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.01, true ], // Wave Ampl. x2
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.05, true ], // Wave Ampl. y1
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.01, true ], // Wave Ampl. y2
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.10, true ], // Phase Shift Value 1
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.10, true ], // Phase Shift Value 2
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.20, true ], // Phase Shift Value 3
                linearConversion [ 0, 0.5, _intensity, 0.00,  0.20, true ]  // Phase Shift Value 4
            ],
            [ 0, 0, 0, 0, 0, 0, 0, 0.05, 0.01, 0.05, 0.01, 0.1, 0.1, 0.2, 0.2 ]
        ]
    };
    case "ColorInversion": {
        [
            selectRandom [
                [       linearConversion [ 0.25, 1, _intensity, 0, 0.50, true ], 0, 0   ],
                [ 0,    linearConversion [ 0.25, 1, _intensity, 0, 0.50, true ], 0      ],
                [ 0, 0, linearConversion [ 0.25, 1, _intensity, 0, 0.50, true ]         ]
            ],
            [ 0, 0, 0 ]
        ]
    };
    default { [] };
} select (_intensity isEqualTo 0) // return
