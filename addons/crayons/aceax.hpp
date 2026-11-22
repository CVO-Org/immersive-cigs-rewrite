// ACE Arsenal Extended (AAE) compat: groups all crayons into one arsenal entry with a color selector.
// Plain config data only - without AAE these classes are unused, so no dependency is needed.

class XtdGearModels {
    class GVAR(crayonBase) {
        label = CSTRING(crayon);
        author = ECSTRING(main,author);
        options[] = { "color" };

        class color {
            label = CSTRING(aceax_color);
            values[] = { "black", "blue", "brown", "gray", "green", "orange", "pink", "purple", "red", "white", "yellow" };

            class black  { label = CSTRING(aceax_color_black);  image = "#(rgb,8,8,3)color(0.1,0.1,0.1,1)"; };
            class blue   { label = CSTRING(aceax_color_blue);   image = "#(rgb,8,8,3)color(0.15,0.3,0.75,1)"; };
            class brown  { label = CSTRING(aceax_color_brown);  image = "#(rgb,8,8,3)color(0.45,0.28,0.15,1)"; };
            class gray   { label = CSTRING(aceax_color_gray);   image = "#(rgb,8,8,3)color(0.5,0.5,0.5,1)"; };
            class green  { label = CSTRING(aceax_color_green);  image = "#(rgb,8,8,3)color(0.15,0.55,0.2,1)"; };
            class orange { label = CSTRING(aceax_color_orange); image = "#(rgb,8,8,3)color(0.95,0.5,0.1,1)"; };
            class pink   { label = CSTRING(aceax_color_pink);   image = "#(rgb,8,8,3)color(0.95,0.5,0.7,1)"; };
            class purple { label = CSTRING(aceax_color_purple); image = "#(rgb,8,8,3)color(0.5,0.25,0.65,1)"; };
            class red    { label = CSTRING(aceax_color_red);    image = "#(rgb,8,8,3)color(0.8,0.12,0.12,1)"; };
            class white  { label = CSTRING(aceax_color_white);  image = "#(rgb,8,8,3)color(0.95,0.95,0.95,1)"; };
            class yellow { label = CSTRING(aceax_color_yellow); image = "#(rgb,8,8,3)color(0.95,0.85,0.15,1)"; };
        };
    };

    // facewear
    class CfgGlasses {
        class GVAR(crayon): GVAR(crayonBase) {};
    };

    // nvg slot
    class CfgWeapons {
        class GVAR(crayon): GVAR(crayonBase) {};
    };
};

#define CRAYON_INFO(var)    class GVAR(DOUBLES(crayon,var))    { model = QGVAR(crayon); color = QUOTE(var); };
#define CRAYON_INFO_NV(var) class GVAR(TRIPLES(crayon,var,nv)) { model = QGVAR(crayon); color = QUOTE(var); };

class XtdGearInfos {
    class CfgGlasses {
        CRAYON_INFO(black)
        CRAYON_INFO(blue)
        CRAYON_INFO(brown)
        CRAYON_INFO(gray)
        CRAYON_INFO(green)
        CRAYON_INFO(orange)
        CRAYON_INFO(pink)
        CRAYON_INFO(purple)
        CRAYON_INFO(red)
        CRAYON_INFO(white)
        CRAYON_INFO(yellow)
    };

    class CfgWeapons {
        CRAYON_INFO_NV(black)
        CRAYON_INFO_NV(blue)
        CRAYON_INFO_NV(brown)
        CRAYON_INFO_NV(gray)
        CRAYON_INFO_NV(green)
        CRAYON_INFO_NV(orange)
        CRAYON_INFO_NV(pink)
        CRAYON_INFO_NV(purple)
        CRAYON_INFO_NV(red)
        CRAYON_INFO_NV(white)
        CRAYON_INFO_NV(yellow)
    };
};
