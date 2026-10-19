# Server Admins

[Back to the documentation overview](README.md)

## Installation

Load the mod on the **server and on every client**.

| Mod | Needed? | What it adds |
| --- | ------- | ------------ |
| [CBA_A3](https://steamcommunity.com/sharedfiles/filedetails/?id=450814997) | **Required** | |
| [ACE3](https://steamcommunity.com/sharedfiles/filedetails/?id=463939057) | Optional | ACE interactions, ACE Arsenal tab, Advanced Fatigue integration, spontaneous combustion (ACE Fire) |
| [ZEN](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631) | Optional | Zeus modules *Unit Start Smoking* / *Unit Stop Smoking* |
| S.O.G. Prairie Fire (CDLC) | Optional | Its cigarette pack and zippo become usable, plus the Savage cigarettes |
| [KJW's Imposters](https://steamcommunity.com/sharedfiles/filedetails/?id=2917554904) | Optional | Cigarettes don't raise suspicion |
| [Helmet on Ass](https://steamcommunity.com/sharedfiles/filedetails/?id=3487820370) | Optional | A cigarette in the NVG slot stays in your face when you sling your helmet |

## CBA settings

All settings are under **Options → Addon Options**, in three categories.

**Scope:** *Server* settings are set by the server (or mission) and apply to everyone. *Client* settings are each player's own, see [Players](players.md#your-own-settings).

### Immersive Cigs - Common

| Setting | Default | Scope | What it does |
| ------- | ------- | ----- | ------------ |
| Holster Weapon when using Lighter | on | Server | Players holster their weapon before using a lighter or matches. Avoids broken animations. |
| Chance of Spontaneous Combustion | 10% | Server | Chance to catch fire when lighting up next to fuel, or smoking while refuelling. Needs ACE Fire. 0% turns it off. |
| **ACE Advanced Fatigue** *(only with ACE)* | | | |
| Enable Adv. Fatigue Integration | on | Server | Smoking affects ACE Advanced Fatigue. |
| Fatigue Modifier | 100% | Server | How much smoking affects fatigue. |
| Coughing Modifier | 100% | Server | How likely smokers are to cough. 0% turns coughing off. |
| Fatigue Decrease Delay | 5 min | Server | Delay before the smoking penalty starts to wear off. |
| **Legacy Classnames and Loadouts** | | | See [Legacy classnames](#legacy-classnames). |
| Update Personal Arsenal Loadouts | off | Client | Replaces legacy classnames in a player's saved arsenal loadouts whenever they open the arsenal. |
| Update Missions Arsenal Loadouts | off | Server | Replaces legacy classnames in the mission's ACE default loadouts at mission start. |

### Immersive Cigs - AI

| Setting | Default | Scope | What it does |
| ------- | ------- | ----- | ------------ |
| **01. Dynamic AI Smoking** | | | |
| Enable | on | Server | AI units with cigarettes smoke them on their own. *Needs a mission restart.* |
| Preferred Slot | Goggles | Server | Slot the AI frees up when both facewear and NVG slot are taken. |
| Remove Slot Item | on | Server | When both slots are taken, the AI moves the item in the preferred slot to its inventory. When off, such units don't smoke. |
| Average Time between Cigs | 15 min | Server | Average time before a unit smokes its next cigarette. |
| Check Unit for compatible Items | on | Server | AI that already carry a pack (e.g. from their loadout) are added to dynamic smoking. |
| **02. AI Cigs** | | | |
| Enable | on | Server | AI units get cigarettes. *Needs a mission restart.* |
| Probability | 33% | Server | Chance that an AI unit gets cigarettes. |
| Delay | 5 s | Server | Delay before the items are added, so other mods or scripts can finish setting up the loadout first. |
| **03. AI Cigs - Enable individual Side** | | | |
| Enable for WEST / EAST / GUER / CIV | on | Server | Per side: should AI of this side get cigarettes at all. *Needs a mission restart.* |

Which packs each side gets is not a CBA setting. It comes from the mission's *Configure AI Cigs* module, or from the default presets. See [Mission Makers](mission-makers.md#which-packs-a-side-gets).

> [!NOTE]
> Older versions had one CBA setting per side and pack (*"04. AI Cigs - WEST"* etc.). These were removed. Values still saved in a `cba_settings.sqf` are ignored.

### Immersive Cigs - Player Preferences

Client settings, documented on the [Players](players.md#your-own-settings) page.

## Legacy classnames

The rewrite renamed the classnames of the original mod (e.g. `murshun_cigs_cigpack` → `cigs_morley_cigpack`, see [Classnames](classnames.md#legacy-classnames)). The old classnames still exist but are marked deprecated, so old loadouts keep working.

To update loadouts to the new classnames:

- **Players' saved loadouts:** each player can turn on *Update Personal Arsenal Loadouts*.
- **ACE default loadouts of a mission:** turn on *Update Missions Arsenal Loadouts*, or let the mission maker update the mission once, see [Mission Makers](mission-makers.md#legacy-classnames-in-mission-loadouts).
