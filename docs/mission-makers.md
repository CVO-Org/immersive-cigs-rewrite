# Mission Makers

[Back to the documentation overview](README.md)

- [Cigarettes on AI](#cigarettes-on-ai)
- [Dynamic AI smoking](#dynamic-ai-smoking)
- [Unit attributes in 3DEN](#unit-attributes-in-3den)
- [Zeus modules](#zeus-modules)
- [Legacy classnames in mission loadouts](#legacy-classnames-in-mission-loadouts)
- Scripting: see the [Scripting API](api.md)

## Cigarettes on AI

AI units can get cigarette packs (plus matches or a lighter) added to their uniform. This covers units placed in the editor and units spawned later by Zeus or scripts. Players never get items this way.

For every new AI unit, the server checks in this order:

1. **Is AI Cigs enabled for the unit's side?** (CBA setting, see [Server Admins](server-admins.md#immersive-cigs---ai))
2. **Is the unit blocked?** See [*Block Ai Cigs*](#unit-attributes-in-3den).
3. **Does the unit already carry a pack** (and *Check Unit for compatible Items* is on)? Then it gets nothing new and only joins [dynamic smoking](#dynamic-ai-smoking).
4. **Is AI Cigs enabled, and does the probability roll pass?** (CBA settings *Enable* and *Probability*, default 33%)
5. **Does its side have any packs?** A side without packs gets nothing.
6. After the *Delay* (default 5 s), the unit gets 1-3 random packs from its side's list, plus enough matches or a lighter.

### Which packs a side gets

The packs per side come from the first of these that exists:

| Priority | Source | Set by |
| -------- | ------ | ------ |
| 1 | `cigs_aiCigs_api` | a script, see [Scripting API](api.md#ai-cigs-packs-per-side) |
| 2 | *Configure AI Cigs* module | you, in 3DEN |
| 3 | Default presets | the mod (and other mods), see below |

The first one that exists is used for **all** sides. If you place the module, sides you leave empty in it get nothing. They do not fall back to the defaults.

### The *Configure AI Cigs* module

**3DEN:** *Systems (F5) → Modules → Immersive Cigs - AI → Configure AI Cigs*

Place one in the mission and open its attributes. Each side (WEST, EAST, GUER, CIV) has a list with a checkbox for every pack that is loaded:

- **Ticked** packs can be handed out to AI of that side. Each pack an AI gets is picked at random from the ticked ones.
- **Nothing ticked:** that side gets no packs at all.
- **Select all / Deselect all** change the whole list of that side.
- A newly placed module starts with the [default packs](#default-packs) of each side ticked.
- Packs from mods that aren't loaded in the editor stay saved, even though you can't see them in the list.

Missions made with older versions, where the module had text fields with classnames, open with those packs already ticked.

### Default packs

Without a module (and without the script variable), these defaults are used:

| Side | Packs |
| ---- | ----- |
| WEST | Morley, Crayons |
| EAST | Apollo Soyuz, Kosmos |
| GUER | Mtn Dew Baja Blast, Black Devil |
| CIV | Morley, Lollipops, NIL, Apollo Soyuz, Kosmos, Mtn Dew Baja Blast, Black Devil, Crayons |

With **S.O.G. Prairie Fire** loaded, every side gets Savage cigarettes instead.

The defaults are presets in config, so other mods can add their own. See [Modders](modders.md#default-pack-presets). To check what's active in your setup, run `[] call cigs_ai_fnc_getDefaultPacks` in the debug console.

## Dynamic AI smoking

AI units with cigarettes (handed out by AI Cigs, or already in their loadout) smoke them on their own, roughly every *Average Time between Cigs* (default 15 min). They put the cigarette in their facewear or NVG slot first. See the [CBA settings](server-admins.md#immersive-cigs---ai) for slot handling.

A unit only lights up when it:
- is on foot (not in a vehicle),
- is not in combat mode (behaviour *Careless*, *Safe* or *Aware*),
- is conscious and its simulation is enabled,
- still has a pack left.

## Unit attributes in 3DEN

Open a unit's attributes in 3DEN. The category **Immersive Cigs: API** has three checkboxes:

| Attribute | What it does |
| --------- | ------------ |
| Block Animations | The unit plays no Immersive Cigs animations. Useful for decorative units with their own animation loop. |
| Block Dynamic Smoking | The unit never smokes on its own. |
| Block Ai Cigs | The unit gets no cigarettes from AI Cigs, and isn't added to dynamic smoking. |

The same switches exist as unit variables for scripts, see [Scripting API](api.md#unit-variables).

## Zeus modules

With [ZEN](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631) loaded, Zeus gets two modules under **Immersive Cigs**. Place them on an AI unit.

### Unit Start Smoking

Makes an AI unit light up right away.

| Option | Choices |
| ------ | ------- |
| Type Cigarette Brand | **Based on Side** (picked from the side's packs, see [Which packs a side gets](#which-packs-a-side-gets)), **Random** (any loaded pack), or a specific pack |
| Type Lighter | **Random**, or a specific lighter |
| Preferred Slot | Goggles/Facewear, Nightvision or Random: the slot that gets freed up if both are taken |
| Automate Smoking | Adds the unit to dynamic smoking, so it keeps smoking afterwards. |

If *Based on Side* finds no packs for the unit's side, the unit gets a NIL pack.

### Unit Stop Smoking

The unit puts out its cigarette, or stops sucking.

## Legacy classnames in mission loadouts

If your mission defines ACE default loadouts with classnames from the original mod (e.g. `murshun_cigs_cigpack`), you can update them once. Run this in the 3DEN debug console:

```sqf
[] call cigs_legacy_fnc_update_defaultLoadouts;
```

Then save the mission. The new classnames are now stored in the mission. Server admins can also do this automatically at mission start, see [Legacy classnames](server-admins.md#legacy-classnames).
