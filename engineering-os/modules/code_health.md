# CODE HEALTH GATES

Load before approving any feature for production. Mandatory for T2+.

These four gates exist because generated code passes review and tests while the
codebase silently becomes unmaintainable. Correctness gates answer "does this
work?". These answer "can a human still own this in six months?".

Run them on the CHANGED surface first, then on the repository trend. A single
absolute number is weak evidence; a number that moved in the wrong direction is
strong evidence.

Record all four in the delivery evidence. **Unmeasured is not passed.** If the
project has no tooling for a gate, that absence is the finding — install it or
declare the gate NOT MEASURED explicitly, never silently.

---

## 1. LOAD

Measure requests per second and latency under concurrency for the endpoints the
change touches.

Baseline before the change, measure after, compare. Absolute RPS depends on the
host and means little alone; a **regression against the baseline** is the signal.

Tools by ecosystem: `k6`, `autocannon`, `oha`, `wrk`, `hey`, `locust`.

Report: RPS, p50, p95, p99, error rate, and the concurrency level used.
Never report the average alone — the average hides the tail where users live.

Fail when:
- RPS drops materially versus baseline without an explicit accepted trade-off;
- p95 or p99 degrades while p50 stays flat (a tail regression: some requests
  now do far more work);
- error rate rises under load;
- latency grows non-linearly with concurrency (queueing, pool exhaustion, lock
  contention).

On failure: profile before optimizing. Do not add cache or index without
evidence of the bottleneck — see `modules/database.md`.

## 2. COVERAGE

Threshold: **85%**. Below that, write the missing tests.

A TDD instruction does not produce tests. Agents skip tests they find tedious,
declare a suite complete while whole branches are unexercised, and report
success honestly because from inside the task it looks done. Coverage is how you
find out. Measure it every time; never take the claim.

Tools: `jest --coverage`, `vitest --coverage`, `c8`, `pytest --cov`,
`go test -cover`, `dotnet test /p:CollectCoverage=true`.

Measure two numbers, not one:
- **coverage of the diff** — the code this batch added or changed;
- **repository coverage trend** — it must not fall.

Diff coverage below the threshold blocks even when repository coverage is high:
new untested code hides inside a large tested codebase.

Fail when:
- coverage is under 85% on the changed surface;
- repository coverage dropped versus the previous batch;
- branch coverage lags line coverage badly — the error paths are untested, and
  error paths are where incidents live.

On failure: write the missing tests before shipping. If regenerating them, give
the failing case, not "add tests" — an agent asked for coverage writes tests
that assert whatever the code already does, which raises the number and proves
nothing. See the test oracle rule in `modules/testing.md`.

## 3. CYCLOMATIC COMPLEXITY

Keep the code within reach of a human.

Complexity is the count of independent paths through a function. High complexity
means more paths than a reader can hold, more states than tests can cover, and
eventually a function only a model can modify. That is the loss of control this
gate prevents — the goal is not elegance, it is keeping the owner able to own it.

Thresholds per function:
- **≤ 10** — normal;
- **11–15** — justify in the review;
- **> 15** — blocks; split before shipping.

Also watch: function length, nesting depth (> 4 is a smell), and parameter count.

Tools: ESLint `complexity` rule, `eslint-plugin-sonarjs`, `lizard`
(multi-language), `radon cc` (Python), `gocyclo` (Go), `PHPMD` (PHP).

Fail when a changed function crosses the threshold, or when the repository's
worst-case complexity grows batch after batch.

On failure: extract the branches into named functions. A `switch` with fifteen
cases is fine; fifteen nested conditions with side effects is not. Splitting for
the metric alone is worse than the metric — the split must make the code
readable, or it just moves the complexity somewhere with a better score.

## 4. DEPENDENCY STRUCTURE

Measure how much each part of the system needs other parts to work.

Coupling is what turns a change into a cascade: a fix in one module breaks three
others, a module cannot be tested without booting the world, and no piece can be
replaced without touching everything. It is the slowest and most expensive kind
of decay, and the least visible in review — every individual import looked
reasonable.

Measure:
- **circular dependencies** — target zero, no exceptions. A cycle means neither
  side can be understood, tested or replaced alone;
- **fan-out** — how many modules a module imports. High fan-out equals fragile;
- **fan-in** — how many import it. High fan-in equals dangerous to change and
  worth stabilizing;
- **layer violations** — the domain must not import the framework, the UI must
  not import the database driver;
- **depth** — how far a change propagates through the import graph.

Tools: `madge --circular`, `dependency-cruiser` (JS/TS, supports declared
architectural rules), `import-linter` (Python), `go-arch-lint`, `deptrac` (PHP),
`NDepend` (.NET).

When no per-language tool is installed, `graphify` answers this gate directly
and across ~40 languages at once — cycles, god nodes and communities come from
the same graph. See `modules/knowledge_graph.md`. It does not replace a
per-language linter with declared architectural rules, which fails
automatically on the next violation; use it to measure now and to decide which
rules are worth declaring.

Fail when:
- a new cycle appears;
- the change adds a dependency that crosses a declared layer boundary;
- a module's fan-out grows without a stated reason.

On failure: invert the dependency (depend on an interface owned by the consumer)
or extract the shared piece into its own module. Prefer declaring the
architectural rule in the tool so the next violation fails automatically instead
of being found by inspection.

---

## Reporting

Every delivery that touches code reports the four, with the number and the
direction of travel:

```
LOAD        1.240 rps · p95 82ms · p99 210ms · 0 errors · 50 vus   (baseline 1.190 rps / p95 79ms)
COVERAGE    diff 91% · repo 78% (+2)  · branch 84%
COMPLEXITY  worst changed function 8 · repo worst 22 (unchanged)
DEPENDENCY  0 cycles · fan-out +1 on services/billing · no layer violations
```

A gate with no tooling reports `NOT MEASURED` and the reason. Silence reads as
approval and is therefore forbidden — see the fail-closed rule in the Core.

## Ratchet

These gates only work as a ratchet. Record the numbers each batch, and never let
them get worse without an explicit, written decision. A threshold met once and
then eroded slowly is how a codebase becomes unmaintainable while every
individual batch looked acceptable.

Legacy code below the thresholds is not fixed by decree: hold the line on the
changed surface, and let the repository number improve as the code is touched.
