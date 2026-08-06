---
description: List files edited in this session that are uncommitted, with a one-line summary each
---

Uncommitted files in this repo:

!`git status --porcelain 2>/dev/null || echo "(not a git repo)"`

Review your tool calls from this session. Find every file you modified, then filter to only changes that appear as uncommitted in the git status above.

For each qualifying file, output exactly one line:

`<filename>(<N> lines): <summary of changes>`

For every line after the first, omit the word "lines":

`<filename>(<N>): <summary of changes>`

Rules:
- Entire line ≤ 80 chars; trim summary to fit
- One line per file, no headers, no extra text
- If no qualifying files: "No uncommitted session edits"
