# Technical design: Space Invaders combat loop

**Status:** Proposed  
**Related spec:** [Feature specification](spec.md)

## Design principles

- Keep this example self-contained in `example_small/`.
- Follow GECS composition: components describe state; systems implement gameplay
  behavior.
- Keep existing player scene presentation where practical and use Node2D-based
  entities for spatial gameplay.
- Keep balance values configurable rather than baking them into processing
  logic.
- Defer game-state transitions; damage and entity removal are enough for this
  iteration.
- Implement and verify the feature in small runnable slices. Commit each
  verified slice before beginning the next; avoid combining unfinished work
  across slices.

## Entity and component responsibilities

Names below are conceptual until implementation. Reuse existing components
where their semantics fit instead of creating duplicate state.

| Entity | State needed | Notes |
| --- | --- | --- |
| Player | Existing health, velocity, and input state; player identity; fire cooldown/request | The existing `e_player.tscn` already supplies `C_Health`, `C_Velocity`, and `C_UserInput`. |
| Enemy | Enemy identity and any health/state needed by the chosen hit model | A player hit removes the enemy. One-hit removal is sufficient for this scope. |
| Projectile | Position, velocity/direction, owner or faction, damage, and lifetime/bounds state | Ownership is required to prevent friendly fire. |

Prefer a clear faction/owner value on projectiles over separate duplicated
projectile implementations if both sides can share the same movement and
collision logic. Keep any player/enemy-specific firing timers on the shooter or
in a dedicated firing-state component.

## System responsibilities and flow

1. **Input:** Read horizontal movement and Space; update player movement state
   and a fire request. Do not create projectiles from inside input polling.
2. **Movement:** Advance player and projectile positions using `delta`, clamp
   the player to the play area, and keep the player in its lower gameplay lane.
3. **Firing:** Consume player fire requests subject to the cooldown. Advance
   enemy firing timers and emit downward shots when ready.
4. **Collision and damage:** Detect projectile/target overlaps, validate
   opposing ownership, apply configured damage or remove a one-hit enemy, and
   consume each projectile on its first valid hit.
5. **Cleanup:** Remove projectiles outside the play area.

Register the required systems on the existing `World` in `main.gd`. Keep
ordering explicit: movement and firing should happen before hit resolution;
cleanup should not prevent a projectile that has just crossed a target from
being resolved in the same frame.

## Structural changes

Firing, valid hits, and out-of-bounds cleanup create or remove entities. Queue
those changes through the system command buffer (`cmd`) while systems are
iterating. Spawn projectiles through the GECS world so they are tracked and
processed consistently. Do not add an entity to the scene tree separately
before registering it with the world.

## Collision approach

The game is 2D and entities are spatial. Choose one collision mechanism for
projectiles and targets and use it consistently:

- Prefer Godot 2D overlap/collision nodes if they fit the entity scenes and
  reliably report hits to GECS state.
- A small, explicit geometry check is also acceptable for this learning example
  if it remains easy to test and avoids maintaining parallel collision state.

Whichever approach is chosen must support the ownership rules in REQ-006 and
consume a projectile only once. Record the choice here when implementation
begins.

## Existing project touchpoints

- `example_small/main.tscn` hosts the `World`, entity root, and player instance.
- `example_small/main.gd` assigns `ECS.world`, registers systems, and processes
  the ECS each frame.
- `example_small/entities/e_player.tscn` is a `Node2D` entity scene with an
  animated sprite and existing health, velocity, and user-input components.
- `example_small/systems/s_user_input.gd` and `s_movement.gd` are the current
  input and movement starting points.
- `project.godot` contains the project's current input map; add named horizontal
  and fire actions there if built-in actions are not sufficient.

## Verification

- Validate input, cooldown, bounds, ownership, damage, hit consumption, and
  cleanup with focused gdUnit tests where practical.
- Run the example scene to verify the visible player/enemy layout and that shots
  move and hit in the expected directions.
- No game-over or victory assertion belongs in this iteration.
