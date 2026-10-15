let content = "#define _DEV_VERSION_ 1\n";

// Write the dev/stable flag to debug_mode.hpp
HEMTT_RFS.join("addons")
    .join("main")
    .join("debug_mode.hpp")
    .create_file()
    .write(content);