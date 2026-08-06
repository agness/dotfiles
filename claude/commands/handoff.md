---
description: Write a handoff note for another agent to resume this work.
---

Write a compact handoff note to `/docs/HANDOFF.md` so a fresh agent can resume this work.

## Steps

1. **Check for existing content.** If handoff file exists and is non-empty,
   show the user its contents and ask permission to overwrite.

2. **Gather context:**
   - Task list: completed, in-progress, and pending items
   - Any `/docs/` files a new agent should read first (plans, specs, etc.)
   - Decisions, constraints, or blockers from this session not captured in those files

3. **Write `/docs/HANDOFF.md`** using this structure:

   ```
   # <short title> — <local datetime>

   ## Read first
   <list /docs/ plan or spec files relevant to the task; omit section if none>

   ## Status
   - Done: <completed tasks>
   - In progress: <current task and where it was left off>
   - Next: <pending tasks>

   ## Notes
   <session-specific context a fresh agent needs that isn't in the files above:
   decisions made mid-session, known blockers, discovered constraints.
   Omit section if nothing to add.>
   ```

   Never include anything already covered by CLAUDE.md (workflow rules,
   code style, git rules, comment conventions, etc.) -- HANDOFF.md is for
   session-specific state only.

## Guidelines
- Reference existing `/docs/` files rather than restating their content.
- Keep it terse, be economical with tokens.
- If no task list exists, derive status from conversation context.
