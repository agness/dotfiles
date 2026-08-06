#!/usr/bin/env python3
"""Summarize Claude Code token usage & agentic-workflow signals.

Scans ~/.claude/projects/**/*.jsonl over a lookback window and prints
totals, per-session, per-model, tool-mix, and efficiency signals as
plain text for an LLM (or human) to interpret. Usage:
    python3 workflow-report.py [--days N]
"""
import json, glob, os, sys, datetime as dt
from collections import defaultdict, Counter

# config ---
ROOT = os.path.expanduser("~/.claude/projects")
DAYS = 14
if "--days" in sys.argv:
    DAYS = int(sys.argv[sys.argv.index("--days") + 1])
NOW = dt.datetime.now(dt.timezone.utc)
CUTOFF = NOW - dt.timedelta(days=DAYS)
READONLY = {"cat", "head", "tail", "grep", "find", "ls", "sed", "awk",
            "echo", "wc", "cd"}


# helpers ---
def parse(path):
    """Yield decoded JSON records from one jsonl, skipping bad lines."""
    with open(path) as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            try:
                yield json.loads(line)
            except json.JSONDecodeError:
                continue


def ts_of(d):
    """ISO timestamp -> aware datetime, or None."""
    t = d.get("timestamp")
    if not t:
        return None
    try:
        return dt.datetime.fromisoformat(t.replace("Z", "+00:00"))
    except ValueError:
        return None


def fmt(n):
    return f"{n:,}"


def label(s, w=40):
    """Session label: 'MM-DD name' (or project dir if no name)."""
    date = s["tmin"].strftime("%m-%d") if s["tmin"] else "??-??"
    nm = s["name"] or s["proj"]
    return f"{date} {nm}"[:w]


def scan(path):
    """Reduce one session file to a stats dict (None if out of window)."""
    s = dict(proj=os.path.basename(os.path.dirname(path.split("/subagents")[0])),
             sub="/subagents/" in path, inp=0, out=0, cc=0, cr=0,
             aturns=0, uturns=0, peak=0, tmin=None, tmax=None,
             tools=Counter(), first_user=None, cwd=None, name=None)
    for d in parse(path):
        t = ts_of(d)
        if t:
            s["tmin"] = t if s["tmin"] is None or t < s["tmin"] else s["tmin"]
            s["tmax"] = t if s["tmax"] is None or t > s["tmax"] else s["tmax"]
        s["cwd"] = s["cwd"] or d.get("cwd")
        typ = d.get("type")
        if typ == "custom-title":
            s["name"] = s["name"] or d.get("customTitle", "").strip("\"'")
        if typ == "user":
            s["uturns"] += 1
            if s["first_user"] is None:
                c = d.get("message", {}).get("content")
                s["first_user"] = c if isinstance(c, str) else None
        elif typ == "assistant":
            s["aturns"] += 1
            msg = d.get("message", {})
            u = msg.get("usage", {})
            i, o = u.get("input_tokens", 0), u.get("output_tokens", 0)
            cc = u.get("cache_creation_input_tokens", 0)
            cr = u.get("cache_read_input_tokens", 0)
            s["inp"] += i; s["out"] += o; s["cc"] += cc; s["cr"] += cr
            s["peak"] = max(s["peak"], i + cc + cr)
            cont = msg.get("content", [])
            if isinstance(cont, list):
                for b in cont:
                    if isinstance(b, dict) and b.get("type") == "tool_use":
                        s["tools"][b.get("name", "?")] += 1
                        if b.get("name") == "Bash":
                            cmd = b.get("input", {}).get("command", "").split()
                            if cmd:
                                s["_verb"] = s.get("_verb", Counter())
                                s["_verb"][cmd[0]] += 1
    # keep only sessions active within the window
    if s["tmax"] is None or s["tmax"] < CUTOFF:
        return None
    return s


# main ---
files = glob.glob(os.path.join(ROOT, "**", "*.jsonl"), recursive=True)
sessions = [s for s in (scan(f) for f in files) if s]

# aggregate totals + model + tools
agg = Counter()
tools = Counter()
verbs = Counter()
models = defaultdict(Counter)
for s in sessions:
    for k in ("inp", "out", "cc", "cr"):
        agg[k] += s[k]
    tools.update(s["tools"])
    verbs.update(s.get("_verb", {}))

tot_in = agg["inp"] + agg["cc"] + agg["cr"]
print(f"=== WORKFLOW REPORT (last {DAYS}d, {len(sessions)} sessions) ===")
print(f"window: {CUTOFF.date()} .. {NOW.date()}\n")

print("=== TOTALS ===")
print(f"output:          {fmt(agg['out'])}")
print(f"uncached input:  {fmt(agg['inp'])}")
print(f"cache_creation:  {fmt(agg['cc'])}")
print(f"cache_read:      {fmt(agg['cr'])}")
print(f"total input:     {fmt(tot_in)}")
if tot_in:
    print(f"cache_read share: {agg['cr']/tot_in*100:.1f}%  "
          f"(higher = more context reuse)")
if agg["cr"]:
    print(f"output / cache_read: {agg['out']/agg['cr']*100:.2f}%  "
          f"(low = heavy context re-read per token produced)")

print("\n=== TOP SESSIONS (by read volume) ===")
top = sorted(sessions, key=lambda x: -(x["cr"] + x["cc"]))[:8]
for s in top:
    dur = ""
    if s["tmin"] and s["tmax"]:
        dur = f"{(s['tmax']-s['tmin']).total_seconds()/3600:.1f}h"
    print(f"{label(s):40} turns={s['aturns']:>4} dur={dur:>7} "
          f"peak={fmt(s['peak']):>9} cr={fmt(s['cr']):>12}")

print("\n=== FLAGS ===")
for s in sessions:
    span = ((s["tmax"] - s["tmin"]).total_seconds() / 3600
            if s["tmin"] and s["tmax"] else 0)
    if span > 24:
        print(f"LONG-LIVED: {label(s)} ran {span:.0f}h "
              f"({s['aturns']} turns) — candidate for /clear discipline")
    if s["cwd"] in (os.path.expanduser("~/Code"),
                    os.path.expanduser("~/Projects")):
        print(f"ROOT CWD: {label(s)} worked from a root dir "
              f"(cwd={s['cwd']}) — should scope to a subdir")

print("\n=== TOOL MIX ===")
for nm, c in tools.most_common():
    print(f"{nm:18} {c}")
ro = sum(verbs[v] for v in READONLY)
bash_n = tools.get("Bash", 0)
if bash_n:
    print(f"\nread-only/nav Bash verbs (cat/ls/grep/cd/...): {ro} of "
          f"{bash_n} Bash calls — candidates for Read/Grep/Glob tools")
agent_n = tools.get("Agent", 0) + tools.get("Task", 0)
print(f"subagent (Agent) calls: {agent_n} — low count + long sessions "
      f"means exploration is bloating the main context")
