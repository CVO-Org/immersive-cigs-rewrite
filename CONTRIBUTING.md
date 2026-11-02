# Contributing

Contributions are welcome - bug reports, ideas, translations and pull requests.

## Issues
Use the issue templates (Bug Report / Feature Request). For bugs, the mod version, steps to reproduce and the RPT log help the most.

## Pull requests
1. Fork the repository and create a branch from `main`.
2. Keep a PR focused on one change.
3. Title: `Scope - Type: Short description`, imperative, in English (`Weather - New: Add gradual wind transition`) - it becomes the changelog entry.
4. Labels: at least one `pr/*` label is required, it sorts the PR into the changelog:
   `pr/new`, `pr/improvement`, `pr/fix`, `pr/settings`, `pr/translation`, `pr/docs`, `pr/maintenance`, `pr/cleanup`, `pr/breaking` (in addition to a main label), `pr/ignore`.
   If you can't set labels, the maintainer will add them.
5. Fill in the PR template, including how you tested the change.

## Development setup
- Install [HEMTT](https://hemtt.dev): `winget install BrettMayson.HEMTT`
- `hemtt check` - lint and validate
- `hemtt launch` - build and start Arma 3 with the test mission
- New addons: `tools\new-addon.bat`

## Code style
- 4 spaces, no tabs, CRLF line endings (see `.editorconfig`).
- Follow the style of the surrounding code: ACE-style function headers, CBA / project macros (`GVAR`, `FUNC`, `LSTRING`, ...), aligned columns for repetitive lines.
- All user-facing text goes into `stringtable.xml`.

## Translations
Add or update entries in the addon's `stringtable.xml` and label the PR with `pr/translation`.
