# Space Invaders spec set

**Status:** Draft  
**Scope:** First playable combat loop for `example_small`

Read these documents in order:

1. [Feature specification](spec.md) — goals, scope, requirements, and acceptance criteria.
2. [Technical design](design.md) — proposed GECS responsibilities and gameplay flow.
3. [Implementation tasks](tasks.md) — ordered work items traced to the requirements.

The design and task list are proposals for implementation. Update them alongside
the spec if implementation reveals a necessary change. The first release covers
player/enemy combat only; victory and defeat rules are intentionally deferred.

## Incremental implementation workflow

Implement one small, working slice at a time, following [the task checklist](tasks.md).
For each slice:

1. Implement only that slice, keeping the example runnable.
2. Verify its listed acceptance criteria with focused tests and/or a manual run.
3. Fix any failures and review the resulting changes.
4. Commit the verified slice before starting the next one.

Do not begin the next slice until the current one is working and committed. Keep
each commit focused on its slice; do not bundle unfinished follow-on work. If a
slice reveals a necessary spec or design change, update the documents and
verification criteria before continuing.
