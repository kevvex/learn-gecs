# Implementation tasks: Space Invaders combat loop

**Status:** Not started  
**Related documents:** [Specification](spec.md) · [Technical design](design.md)

Complete tasks in order unless implementation evidence justifies changing the
sequence. Check off a task only after its acceptance criteria are verified.

## 1. Prepare the play area and controls

- [ ] Define/configure horizontal movement and fire actions; bind fire to Space.
- [ ] Establish the play-area bounds and lower player lane.
- [ ] Verify the existing player scene starts in the lower part of the screen.
- [ ] Add focused checks for horizontal-only movement and edge clamping.

**Traceability:** REQ-001, REQ-002; AC-001, AC-002

## 2. Add projectile and firing state

- [ ] Define reusable projectile state, including direction/speed, faction,
  damage, and the data needed for cleanup.
- [ ] Implement player hold-to-fire behavior with a configurable cooldown.
- [ ] Spawn player shots upward through the GECS world/command buffer.
- [ ] Verify release stops new shots and sustained input respects the cooldown.

**Traceability:** REQ-003, REQ-006, REQ-009; AC-003

## 3. Add enemies and enemy firing

- [ ] Create a small enemy entity/scene and place a group above the player.
- [ ] Add configurable enemy firing cadence and downward projectiles.
- [ ] Verify the starting scene shows enemies and their projectiles travel down.

**Traceability:** REQ-004, REQ-005; AC-004

## 4. Resolve hits and damage

- [ ] Choose and document the collision approach in [technical design](design.md).
- [ ] Implement opposing-faction hit validation and one-time projectile
  consumption.
- [ ] Remove an enemy on a valid player projectile hit.
- [ ] Reduce player health on a valid enemy projectile hit.
- [ ] Test that friendly projectiles do not damage their owner's faction.

**Traceability:** REQ-006, REQ-007; AC-005, AC-006

## 5. Clean up and integrate

- [ ] Remove projectiles after they leave the play area.
- [ ] Register systems in the required order in `example_small/main.gd`.
- [ ] Run focused tests and launch `example_small/main.tscn` for a manual
  end-to-end check.
- [ ] Confirm that reaching zero health or removing all enemies does not
  accidentally introduce game-over or victory behavior.

**Traceability:** REQ-008, REQ-009; AC-007, AC-008
