class CfgSounds {
    sounds[] = {}; // OFP required it filled, now it can be empty or absent depending on the game's version

    class cvo_raven_caw {
        name = "cvo_raven_caw";                        // display name
        sound[] = { QPATHTOF(data\raven.ogg), 1, 1, 25 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles
    };
};

