# Conversations
- Be terse. No praise. No hyperbole, no dramatic aphorisms.
- Ask for clarification if any part of my prompt is ambiguous.

# Plans
- Use precise language; write plans in the style of dry, analytical product requirements documents.
- Organize plans in cleanly separated, verifiable steps to minimize bugs. When implementing, pause to let me verify and commit between steps.
- Prepend plan file names with MM-DD, eg. 0606-refactor-scrolly.md.
- When I say "start" on a to-do list, start the first task, not the entire list.
- When decisions change, avoid writing a changelog of decisions. Just overwrite outdated information with the new decision and why -- the file is an active plan not a diary.

# Workflow
- Prefer one session = one task = one or more to-do items. Name every session like <projectname1keyword>-<task1keyword>, eg. 'ships-satellite'. Always keep a to-do list.
- Project plans live in /docs. Handoff notes from prior agents live at /docs/HANDOFF.md.
- Suggest parallelizable subagents when it would be efficient.

# Code
- NEVER EVER PUT API KEYS IN CODE.
- NEVER MAKE ANY GIT CHANGES. I will always do the commit.
- Suggest terse git commit messages less than 60 characters; OK to use
  shorthands.
- Code concisely. Use functional programming where appropriate; avoid
  unnecessary classes.
- Prefer to encapsulate methods as stateless helpers.
- If there's more than three helper functions, consider putting them in a
  sibling `util.js` or `methods.py` file.
- Use single character names for iterative variables or variables with a
  small scope.
- Precede each block of code with comments no longer than 4 lines that
  describes what the code does. Mark sections of related blocks with
  dashed banners, e.g. `// init ---`, `// draw ---`, `// main ---`.
- Comments explain non-obvious why, not what. Prefix scratch logs `// DEBUG`.
- Wrap all lines at 80 characters.
- Prefer performative code rather than readable verbose styles.
- Always ask me before running a server. If its a birdkit project, assume
  I already have the dev server running.
- Birdkit skills live in the repo under .agents/skills.

## Python
- Prefer vectorized operations over explicit loops for performance.

## Javascript
- If we have a resize handler, debounce it (default to 300ms).

## CSS
- Prefer to store color constants as raw RGB triplets so it's easy to use
  with opacity, e.g. `--blue: 12, 166, 232;` -> `rgba(var(--blue), 0.5)`.
- Group blocks of CSS with banner comments like `/* header --- */`,
  `/* scrolly --- */`, `/* page colors --- */`, etc.
