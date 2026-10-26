# Feature specification: Space Invaders combat loop

**Status:** Draft  
**Target:** `example_small`  
**Product scope:** A small, single-screen, 2D Space Invaders-style gameplay example built with Godot and GECS.

## Goal

Create a playable combat loop in which the player moves a ship horizontally
along the bottom of the play area, fires upward, and avoids enemy projectiles
fired from a formation above. Projectiles can damage their intended target.

## Player experience

The player starts in the lower part of the play area. Left and right controls
move the ship horizontally. Holding Space fires upward repeatedly with a
cooldown between shots. Enemies occupy the upper part of the play area and fire
downward. An enemy projectile hit reduces the player's health.

## Requirements

### P0 — required for the first playable loop

- **REQ-001 — Player movement:** The player can move left and right using the
  configured horizontal movement actions. Movement is independent of frame rate.
- **REQ-002 — Play-area bounds:** The player remains fully inside the horizontal
  play-area bounds and cannot move above or below its gameplay lane.
- **REQ-003 — Player firing:** Holding the configured fire action (Space by
  default) spawns upward-moving player projectiles at a limited, configurable
  firing rate. Releasing the action stops further shots.
- **REQ-004 — Enemy presence:** The starting scene contains a small, visible
  group of enemies above the player.
- **REQ-005 — Enemy firing:** Enemies fire downward-moving projectiles over
  time. Enemy firing cadence is configurable.
- **REQ-006 — Projectile ownership and hits:** Player projectiles can hit
  enemies; enemy projectiles can hit the player. Projectiles affect only the
  opposing side, and each projectile is consumed after a valid hit.
- **REQ-007 — Damage:** A valid enemy projectile hit reduces the player's
  health by the projectile's configured damage amount. A valid player
  projectile hit removes the hit enemy from active play.
- **REQ-008 — Projectile cleanup:** Projectiles that leave the play area are
  removed and no longer participate in collision or damage processing.
- **REQ-009 — GECS integration:** Gameplay entities, state, and processing use
  the existing GECS world and `ECS.process()` loop. Structural entity changes
  made during system iteration use GECS's command buffer.

### Deferred

- Victory, defeat, game-over, restart, and next-wave rules.
- Enemy formation movement, changing speed, and wave progression.
- Score, lives, shields, power-ups, and difficulty progression.
- Audio, title/pause menus, and presentation polish beyond what is needed to
  identify the player, enemies, and projectiles.
- Final balance values for player/enemy firing cadence, movement speed, health,
  and damage. These should be configurable and tuned during playtesting.

## Acceptance criteria

- **AC-001:** With left or right input held, the player moves in that direction;
  it does not move vertically. Releasing input stops horizontal motion.
- **AC-002:** At either horizontal edge, the entire player remains within the
  play area while the corresponding movement input is held.
- **AC-003:** Holding Space produces upward player projectiles at the configured
  cadence; releasing Space prevents additional projectiles from being spawned.
- **AC-004:** At least one enemy is visible above the player when the example
  starts, and enemy projectiles travel downward.
- **AC-005:** A player projectile hitting an enemy removes that enemy and
  consumes the projectile. An enemy projectile does not damage an enemy.
- **AC-006:** An enemy projectile hitting the player decreases player health by
  the configured damage amount and consumes the projectile. A player
  projectile does not damage the player.
- **AC-007:** A projectile leaving the play area is cleaned up without affecting
  an entity.
- **AC-008:** The loop runs through the example's GECS world; no game-over or
  victory behavior is required when health reaches zero or all current enemies
  are removed.

## Assumptions and open decisions

- The first version is one screen and uses the existing `example_small` player
  scene as its starting point.
- Space is the default fire binding; movement uses configurable horizontal
  input actions.
- Enemy projectiles travel straight down. Enemy aiming and formation movement
  are not part of this first spec.
- Enemy count, initial formation layout, visual collision sizes, and balance
  values are implementation/playtesting choices, not fixed requirements.
- Health reaching zero may continue to use the existing `C_Dead` marker, but
  handling that state as a defeat is explicitly out of scope.
