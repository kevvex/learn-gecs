---
name: godot-gecs
description: Use when creating, editing, debugging, or explaining GDScript in this Godot 4.7 project. Consult the sibling godot-master skill for Godot engine and language knowledge, especially when working with GECS.
---

# Godot + GECS project skill

Use this skill for changes in this repository's Godot project and GECS examples.

## Working guidelines

- Check the relevant scene, script, and neighboring example before changing behavior. Prefer the existing pattern in the closest `example_*` project.
- Treat `addons/gecs/docs/` as the authoritative GECS guide. Consult [the project map](references/project-map.md) to choose relevant documentation.
- For Godot engine APIs, GDScript, architecture, or debugging guidance, consult the sibling [godot-master skill](../../../../Game-Dev-Agentic-Skills/skills/godot-master/SKILL.md) and only the relevant references it links. Apply its Godot 4.7+ guidance to this Godot 4.7 project.
- Treat godot-master as engine guidance, not a replacement for this project's patterns or GECS docs. When advice conflicts, prefer the project's actual code and GECS documentation for local and addon behavior; verify engine-version-sensitive APIs against Godot 4.7 documentation.
- Keep GECS components focused on data and systems focused on behavior. Follow the local naming convention: `C_Name` components in `c_name.gd`, `NameSystem` systems in `s_name.gd`, and `Name` entities in `e_name.gd`.
- Respect Godot node types: `Entity` extends `Node`; use spatial properties only when the entity's actual root is `Node2D` or `Node3D`.
- Use the GECS command buffer (`cmd`) for entity/component structural changes made while systems iterate.
- Keep examples and learning projects isolated; do not move logic between `example_*` directories or modify addon internals unless the requested change calls for it.
- Preserve the surrounding GDScript style and resource/scene wiring. Avoid changing generated `.godot/` files.
- Validate the changed script or scene with the narrowest relevant available check. For behavior changes, look for an existing gdUnit test or add a focused one following the addon's test patterns.

## Project facts

- The Godot project declares engine feature version `4.7` in `project.godot`.
- GECS is available under `addons/gecs/`; its documentation and tests are maintained alongside the addon.
- The root project is a playground, with small and inventory examples in `example_small/` and `example_inventory/`.
