---
description: Analyze recent Claude Code token usage and suggest workflow improvements
argument-hint: "[--days N, default 14]"
allowed-tools: Bash(python3 ~/.claude/scripts/workflow-report.py:*)
---

Raw stats over the lookback window:

!`python3 ~/.claude/scripts/workflow-report.py $ARGUMENTS`

Title the report, including number of days and sessions in lookback.

Based only on the stats above: what is driving cost in this window, and
what is the single highest-impact change I could make going forward? If
the window looks healthy, say no change is needed. Refer to session by
name and date when possible.

Output the raw report at the end.
