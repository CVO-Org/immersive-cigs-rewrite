// Read the contents of README.md
let readme = HEMTT_VFS.join("README.md")
    .open_file()
    .read();
// Replace the placeholder version with the actual version
readme.replace("{version}",
    HEMTT.project()
    .version()
    .to_string_short()
);
// Write the new contents over the old contents
HEMTT_VFS.join("README.md")
    .create_file()
    .write(readme);
// Done
print("README.md version set to " + HEMTT.project().version().to_string_short());
