// Antistasi template presets: the packs per Antistasi faction template, see fn_getConfigPresets.
//
// Antistasi spawns generic unit classes of the FIA factions (a3a_unit_west, a3a_unit_east, a3a_unit_reb*, a3a_unit_civ),
// so the unit class and faction presets don't apply to its units. Their faction is the template loaded for their role
// (Occupants, Invaders, Rebels, Civilians), and the presets go onto that template class:
//
// - cigs_packs_<tier>[]   packs for one tier of the template's units: militia, military, sf, police, other.
//                         The tier comes from the unit's Antistasi loadout. Replaces cigs_packs[] for that tier.
// - cigs_packs[]          packs for every unit of the template without a tier preset.
// - cigs_lighters[]       lighters for every unit of the template.
//
// A template without these properties leaves its units to the terrain and default presets.
// Classnames that aren't loaded are dropped, so a template can list packs of optional brands.
// The templates inherit from each other: a preset on a parent reaches its child templates (e.g. the climate variants),
// so every class here must be declared with its real parent from Antistasi's Templates.hpp.
// The groups of templates and the brands per group: docs/research/antistasi-template-groups.md
//
// Example:
// class A3A {
//     class Templates {
//         class Vanilla_Base;
//         class Vanilla_NATO_Arid : Vanilla_Base {
//             cigs_packs[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
//             cigs_packs_militia[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack) };
//         };
//     };
// };
//
// Mods that add their own Antistasi templates can add these properties to their template classes, no dependency needed.

class A3A {
    class Templates {
    };
};
