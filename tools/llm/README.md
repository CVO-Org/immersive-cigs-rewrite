# LLM instructions

Instructions for an AI coding assistant (Claude Code, Codex, Cursor, Copilot and the like) to add a new brand to Immersive Cigs: a cigarette pack, a cigar box or a lollipop-style pack. They tell the assistant which addon to copy, what to rename, how to turn artwork into the texture, and how to render the inventory icons with the scripts in [`tools/gear_icons/`](../gear_icons/README.md).

They are written for an assistant that can read and edit files and run commands in a clone of this repository. A chat-only assistant can follow them too, but you then run the commands yourself.

## What's here

| File | What it is |
| --- | --- |
| [`skills/immersive-cigs-brand/SKILL.md`](skills/immersive-cigs-brand/SKILL.md) | The workflow, step by step, with the traps. Start here. |
| [`references/item-types.md`](skills/immersive-cigs-brand/references/item-types.md) | Which addon to copy for a cigarette, filterless cigarette, cigar, lollipop or variety pack, and what each one differs in. |
| [`references/texture.md`](skills/immersive-cigs-brand/references/texture.md) | The texture's UV layout and how to build it from pictures with `texture_compose.py`. |
| [`references/checklist.md`](skills/immersive-cigs-brand/references/checklist.md) | What to check before calling it done. |
| [`skills/immersive-cigs-cigar/SKILL.md`](skills/immersive-cigs-cigar/SKILL.md) | The same for a cigar brand: copying Papa Schultz, the cigar texture, the box, the icons. |
| [`references/cigar-layout.md`](skills/immersive-cigs-cigar/references/cigar-layout.md) | The cigar's and the box's UV layout, and how to build the cigar texture with `texture_compose.py cigar`. |
| [`references/checklist.md`](skills/immersive-cigs-cigar/references/checklist.md) | The cigar checklist. |

The skills follow the [Agent Skills](https://agentskills.io) format: a folder with a `SKILL.md` whose front matter says when to use it. Other assistants can read it as plain Markdown.

## Using it

You need [HEMTT](https://hemtt.dev) and Python 3 with Pillow (`pip install pillow`), as for the icon scripts. The cigar icons also need numpy (`pip install numpy`).

**Claude Code:** copy the skill folders into the repository's `.claude/skills/` (or your own `~/.claude/skills/`). Claude picks the right one when you ask for a new brand.

```powershell
New-Item -ItemType Directory -Force .claude/skills
Copy-Item -Recurse tools/llm/skills/* .claude/skills/
```

**Other assistants:** point them at the skill in your first message, or add a line to your `AGENTS.md` / rules file:

```text
To add a cigarette or lollipop brand, follow tools/llm/skills/immersive-cigs-brand/SKILL.md.
To add a cigar brand, follow tools/llm/skills/immersive-cigs-cigar/SKILL.md.
```

Then ask for what you want and hand over your artwork, for example:

```text
Add a cigarette brand "Red Fox" (folder red_fox), 20 cigarettes, filter, author "Jane".
The pack pictures are in C:\art\redfox\ (front.png, back.png, side.png, top.png) and the paper logo is fox.png.
```

The assistant asks for whatever is missing: the names, the numbers, the artwork, and whether the brand goes into this repository or into your own mod (then the [extension template](https://github.com/OverlordZorn/immersion-cigs-extension-template) is the start).

## What it can't do

- Paint artwork. The assistant places and fits the pictures you give it. Without pictures it can make a plain placeholder pack, and it says so.
- Look at the brand in game. It checks the configs with `hemtt check` and the icons and textures from rendered previews; you launch the game (`hemtt launch`) and look.
- Build a cigar box texture from pictures. The box model is too detailed for a builder; the assistant pastes your pictures into the areas `cigar_icons.py layout` shows, and you check the result.
- Render lollipop icons. `gear_icons.py` does cigarette brands and `cigar_icons.py` cigars; for a lollipop the assistant keeps the template's icons.

## Keeping it up to date

The skills point at `docs/` and `tools/gear_icons/README.md` for the details instead of repeating them. When the workflow changes (a new template addon, a new script, a new config property), update those pages and check that the steps in both `SKILL.md` files still hold.
