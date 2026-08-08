# KNOWLEDGE GRAPH (graphify)

Load when a task depends on knowing how a codebase is wired rather than what a
single file says.

The user does not choose when to build the graph. Decide from the task, using
the triggers below, and say what it showed — never make the user manage it.

## What it answers

`grep` finds a string. The graph answers structure:

- what calls this, and what breaks if it changes;
- which modules are so connected that every change touches them (**god nodes**);
- which parts form a cluster that could be understood or replaced alone
  (**communities**);
- whether a cycle exists between modules;
- the shortest path between two pieces of code that look unrelated.

Local tree-sitter AST across ~40 languages. Deterministic, no LLM in the parse,
no telemetry, no API key for code-only corpora.

## Build it when

- **First contact with an unfamiliar repository.** Before planning anything
  material in a codebase this session has not mapped.
- **The dependency gate is unmeasured.** `modules/code_health.md` requires
  cycles and coupling; the graph answers both.
- **Blast radius is unclear.** Before changing anything used in more than a few
  places — trace the callers instead of guessing.
- **A defect class, not an instance.** When the same bug shape may exist
  elsewhere, the graph finds the siblings that text search misses.
- **Refactoring or extraction.** Communities show what actually separates; a
  split along the wrong seam creates two coupled halves.
- **Large legacy file.** Before touching a file with high complexity, see what
  depends on it.

## Do not build it when

- The change is one file and one behavior — cost without benefit.
- The repository is small enough to read.
- The graph exists and nothing relevant changed. Use `--update` for incremental
  re-extraction; do not rebuild from scratch out of habit.

## How

```bash
/graphify .                    # build for the current repo
/graphify . --update           # only new or changed files
/graphify . --code-only        # skip docs/PDF semantic extraction (no API calls)
/graphify query "<pergunta>"   # traverse and answer
graphify path "A" "B"          # shortest path between two nodes
graphify explain "X"           # plain-language explanation of a node
graphify diagnose multigraph   # edge-collapse risk in the built graph
```

Outputs land in `graphify-out/`: `graph.json` (queryable), `graph.html`
(interactive) and `GRAPH_REPORT.md` (readable summary).

Add `graphify-out/` to `.gitignore` unless the team decides to version the
report. It is derived data — rebuildable, and large.

## Rules

**The graph describes the code, not the truth of runtime.** It shows a call
exists, never that it executes, and never that it is correct. It does not
replace reading the code, running it, or the evidence rule in the Core. Treat it
as a map: it tells you where to look.

**An edge is a hypothesis until confirmed.** Dynamic dispatch, reflection,
string-built calls and dependency injection are invisible to a static parse.
Absence of an edge is not proof of absence — say so when reporting.

**Report what it changed in the decision.** A graph built and not used is wasted
time. Either it altered the plan, the blast radius or the batch boundary, or it
should not have been built.

**Rebuild before trusting.** A stale graph is worse than none: it describes code
that no longer exists and reads as authoritative. Check the age of
`graph.json` against the last commit before answering from it.
