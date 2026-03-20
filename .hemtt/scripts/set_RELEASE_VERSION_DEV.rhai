let content = "#define _DEV_VERSION_ 1\n";

// Write the modified contents to script_version.hpp
HEMTT_RFS.join("addons")
    .join("main")
    .join("debug_mode.hpp")
    .create_file()
    .write(content);