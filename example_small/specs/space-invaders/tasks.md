# Implementation tasks: Space Invaders combat loop

**Status:** Not started  
**Related documents:** [Specification](spec.md) · [Technical design](design.md)

Complete slices in order unless implementation evidence justifies changing the
sequence. Keep the example runnable at each checkpoint. For each slice, finish
only the listed scope, verify its criteria, review the changes, and commit that
working slice before starting the next. Do not carry unfinished follow-on work
into an earlier slice's commit. If implementation requires a scope or design
change, update the spec/design and acceptance criteria before continuing.

## 1. Player movement and play area

- [ ] Configure horizontal movement actions in Godot's Input Map.
- [ ] Keep player movement horizontal, frame-rate independent, and inside the
  play-area bounds/lower lane.
- [ ] Verify the existing player scene starts in the lower part of the screen.
- [ ] Add focused checks for horizontal-only movement and edge clamping.
- [ ] Run the example and verify movement manually; commit this working slice.

**Traceability:** REQ-001, REQ-002; AC-001, AC-002

## 2. Player projectile prototype

- [ ] Add a visible player projectile using a built-in solid-color 2D shape.
- [ ] Configure the fire action in Godot's Input Map with Space as its default
  binding.
- [ ] Implement hold-to-fire with a configurable cooldown and upward movement.
- [ ] Spawn shots through the GECS world/command buffer.
- [ ] Verify firing cadence and projectile visibility; commit this working
  slice.

**Traceability:** REQ-003, REQ-009, REQ-010; AC-003, AC-009

## 3. Enemy prototype and starting layout

- [ ] Create a visible enemy using a built-in solid-color 2D shape.
- [ ] Place a small group of enemies above the player.
- [ ] Ensure placeholder visual bounds match the intended collision bounds.
- [ ] Run the example and verify the layout; commit this working slice.

**Traceability:** REQ-004, REQ-010; AC-004, AC-009

## 4. Enemy projectile prototype

- [ ] Add an enemy firing timer/cadence and downward-moving enemy projectiles.
- [ ] Use a distinct solid color for enemy shots.
- [ ] Verify enemy shots appear and travel downward; commit this working slice.

**Traceability:** REQ-005, REQ-010; AC-004, AC-009

## 5. Projectile hits and damage

- [ ] Choose and document the collision approach in [technical design](design.md).
- [ ] Implement opposing-faction hit validation and one-time projectile
  consumption.
- [ ] Remove an enemy on a valid player projectile hit; reduce player health on
  a valid enemy projectile hit.
- [ ] Test both hit paths and verify friendly projectiles cause no damage.
- [ ] Run a manual combat check; commit this working slice.

**Traceability:** REQ-006, REQ-007, REQ-009; AC-005, AC-006

## 6. Projectile cleanup and end-to-end verification

- [ ] Remove projectiles after they leave the play area.
- [ ] Confirm all systems are registered in the required order in
  `example_small/main.gd`.
- [ ] Run focused tests and launch `example_small/main.tscn` for a manual
  end-to-end check.
- [ ] Confirm that reaching zero health or removing all enemies does not
  introduce game-over or victory behavior.
- [ ] Commit the verified cleanup/integration slice.

**Traceability:** REQ-008, REQ-009; AC-007, AC-008
