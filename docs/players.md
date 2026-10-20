# Players

[Back to the documentation overview](README.md)

## How to smoke

1. Have a **cigarette pack** and **matches or a lighter** in your inventory.
2. **Take a cigarette from the pack.** It goes into your facewear slot. If that slot is taken, it goes into the NVG slot, and only if both are taken into your inventory. You can convert it between facewear and NVG item yourself (see below).
3. **Light it up.** You need matches or a lighter in your inventory.
4. **Put it out** whenever you want, or smoke it until it's gone.

No lighter? Light your cigarette at a burning campfire, from someone else's burning one, or light the next one from your own: take a new cigarette while smoking (it goes into your other slot) and use *Light the next one from this cigarette*.

Lollipops and crayons work the same way, except you *suck* them instead of lighting them.

## Where to find the actions

You can use every action in two ways:

- **Inventory:** left-click the item in your inventory (CBA context menu).
- **ACE Interaction Menu** (with ACE loaded): self-interaction → *Equipment*.

| Action | Inventory: left-click on | ACE |
| ------ | ------------------------ | --- |
| Take from pack | the pack | Self → Equipment |
| Light up your cigarette | the cigarette in the facewear/NVG slot | Self → Equipment |
| Put cigarette out | the burning cigarette | Self → Equipment |
| Start / stop sucking | the lollipop or crayon in the facewear/NVG slot | Self → Equipment |
| Eat | the cigarette, lollipop or crayon in the facewear/NVG slot | - |
| Convert to NVG / facewear item | a cigarette, lollipop or crayon - worn or in your inventory. It goes into the matching slot if that's free (from your inventory only if you don't already wear one in the other slot). Not while smoking or sucking. | - |
| Light up *their* cigarette | - | Interact with another unit → Head (needs a lighter) |
| Light up their cigarette with yours | - | While smoking: interact with another unit → Head |
| Light your cigarette from theirs | - | Interact with a smoking unit → Head |
| Light up at the fire | - | Interact with a burning campfire/fireplace |
| Light the next one from this cigarette | the unlit cigarette in your other slot, while smoking | Self → Equipment |
| Pay respect to the fallen | - | While smoking: interact with a dead or unconscious unit → Head |

Using a lighter or matches holsters your weapon first, unless the server has turned that off.

## Features

### Synchronised in multiplayer
When you light up or take a drag, players nearby hear it and see the smoke.

### Glow in the dark
Taking a drag creates a faint light, visible at night. Lighters and matches light up a bit more. NVG users nearby may not thank you.

### Puff-based cigarettes
A cigarette doesn't burn for a fixed time. Each one has a budget of puffs, and every drag uses up a random amount of it. How long and how often you draw is up to your own settings (see below).

### Flavours
Lollipops and some cigarettes come in flavours, which you are told about after a while. Some rumours say that Baja Blast even changes the colour of the smoke.

### ACE Advanced Fatigue
With ACE Advanced Fatigue enabled, smoking a lot affects your stamina, and heavy smokers start to cough. Coughing can alert nearby enemies.

### Spontaneous combustion
With ACE Fire enabled, lighting up next to fuel sources, smoking while refuelling, or lighting up at a campfire can set you on fire.

### Smoking AI
AI units can carry cigarettes and smoke them on their own. See [Mission Makers](mission-makers.md#cigarettes-on-ai).

### Paying respect
Give a fallen comrade their last cigarette.

### Don't like smoking? Eat them
Yes, you can eat cigarettes. Don't eat a lit one, though, unless you enjoy burns (with ACE Medical).

## Your own settings

You find these under **Options → Addon Options → Immersive Cigs - Player Preferences**. They only affect you.

| Setting | Default | What it does |
| ------- | ------- | ------------ |
| Smoking Intensity | Normal | How long you draw on a cigarette: Less Intensive, Normal, More Intensive or Thomas. |
| Smoking Frequency | Normal | How often you draw: Less Often, Normal, More Often or Thomas. |
| Amount of smoke particles | 100% | How much smoke you see from smokers around you. Lower it if smoke costs you frames. |
| Enable Custom Category Tab in ACE Arsenal | on | Adds an Immersive Cigs tab to the ACE Arsenal. *(ACE only)* |

### Singleplayer
In singleplayer missions you can start with cigarettes and a lighter. These settings are under the same category, sub-category *Singleplayer*:

| Setting | Default | What it does |
| ------- | ------- | ------------ |
| Add Items to Player in SP | off | Turns the two items below on. |
| Start with a Lighter / Type of Lighter | on / first lighter | Which lighter you get. |
| Start with a CigPack / Type of Pack | on / first pack | Which pack you get. |
