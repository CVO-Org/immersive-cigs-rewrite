#define SOUND(name,volume,pitch,distance)\
class PVAR(name) {\
    sound[] = {QPATHTOF(data\sounds\name##.ogg), volume, pitch, distance};\
    titles[] = {};\
}

class CfgSounds {
    sounds[] = {};

    class PVAR(matches_01) {
        sound[] = {QPATHTOF(data\sounds\matches_01.ogg), 4, 1, 30};
        titles[] = {};

        t_start = 1.9;
        t_peak = 2.7;
        t_duration = 4.5;


    };
    class PVAR(matches_02) {
        sound[] = {QPATHTOF(data\sounds\matches_02.ogg), 4, 1, 30};
        titles[] = {};

        t_start = 0.4;
        t_peak = 1.7;
        t_duration = 3.5;


    };

    class PVAR(lighter_01) {
        sound[] = {QPATHTOF(data\sounds\lighter_01.ogg), 4, 1, 30};
        titles[] = {};

        t_start = 1.4;
        t_peak = 1.6;
        t_duration = 3.5;
    };

    class PVAR(lighter_02) {
        sound[] = {QPATHTOF(data\sounds\lighter_02.ogg), 4, 1, 30};
        titles[] = {};

        t_start = 1;
        t_peak = 1.5;
        t_duration = 3.5;
    };


    class PVAR(smoke_3) {
        sound[] = {QPATHTOF(data\sounds\smoke_3.ogg), 3, 1, 10};
        titles[] = {};

        t_start = 0.0;
        t_peak = 1.2;
        t_duration = 3.0;
    };

    class PVAR(smoke_4) {
        sound[] = {QPATHTOF(data\sounds\smoke_4.ogg), 3, 1, 10};
        titles[] = {};

        t_start = 0.0;
        t_peak = 1.2;
        t_duration = 3.0;
    };




    SOUND(unwrap_01,4,1,30);

    SOUND(eat_01,4,1,30);
    SOUND(eat_02,4,1,30);
    SOUND(eat_03,4,1,30);
    SOUND(eat_04,4,1,30);
    SOUND(eat_05,4,1,30);
    SOUND(eat_06,4,1,30);
    SOUND(eat_07,4,1,30);

    SOUND(eat_bread_1,4,1,30);
    SOUND(eat_bread_2,4,1,30);
    SOUND(eat_bread_3,4,1,30);
    SOUND(eat_bread_4,4,1,30);
    SOUND(eat_bread_5,4,1,30);

    SOUND(verpuffung_00,4,1,100);
    SOUND(verpuffung_01,4,1,100);
    SOUND(verpuffung_02,4,1,100);
    SOUND(verpuffung_03,4,1,100);
    SOUND(verpuffung_04,4,1,100);

    // DayZ Mod LDP (ADPL-SA)
    SOUND(cough_0,4,1,75);
    SOUND(cough_1,4,1,75);
    SOUND(cough_2,4,1,75);
};
