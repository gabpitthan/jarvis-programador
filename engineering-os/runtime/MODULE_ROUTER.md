# MODULE ROUTER

The router selects depth; the Core preserves invariants.

Always load:
- `JARVIS_CORE.md`
- `ENGINEERING_OS_INDEX.md`

Then classify task and load relevant modules.

For T2+: Spec lookup is MANDATORY through `runtime/SPEC_LOOKUP_PROTOCOL.md`, and POLICY_COVERAGE must be recorded.

For T3/T4: consult all relevant normative sections for security/risk/data/production/rollback plus domain-specific policies before dangerous execution.

## Suggested routing

Unfamiliar repository, unclear blast radius, coupling/cycles question, refactor or extraction, or a defect class that may repeat → `modules/knowledge_graph.md`. Decide from the task; never ask the user to manage the graph. Report what it changed in the plan, or do not build it.
Any feature approved for production → `modules/code_health.md` (load, coverage, complexity, dependency structure). Mandatory for T2+; the four gates are reported in the delivery evidence, and an unmeasured gate is reported as NOT MEASURED, never omitted.
Frontend/UI → `modules/frontend.md` + `modules/consistency.md` + testing when behavior changes.
API/webhook/contracts → `modules/api_contracts.md` + security/testing as applicable.
Database/data/migration → `modules/database.md` + security/testing/operations when applicable.
Auth/security/secrets → `modules/security.md` + testing.
Dependencies → `modules/dependencies.md` + security.
GitHub/repository governance → `modules/github.md`.
Memory/RAG/context → `modules/memory.md`.
Production/deploy/infra → `modules/operations.md` + security/testing.
T2+/multi-agent/long mission → `modules/orchestration.md`.
External/version-sensitive knowledge → `modules/research.md`.
Durable behavior/contracts/architecture → `modules/documentation.md`.
ENGINEERING OS changes → `modules/evals.md`.

Load multiple modules when the task crosses concerns.
Do not use module selection to bypass a relevant Core or Spec rule.

## Swarm routing

Any task considering multiple agents MUST load `modules/orchestration.md`.
For ASSISTED/SWARM execution also initialize `runtime/SWARM_STATE.md` and use `templates/AGENT_ASSIGNMENT.md` for delegated nodes.

Before spawning agents, determine whether the task should be SOLO / ASSISTED / SWARM.
Do not spawn workers until dependencies, ownership and expected outputs are defined sufficiently.


## Adaptive routing

Load `modules/model_routing.md` when multiple model/provider profiles are available, when ASSISTED/SWARM is selected, or when cost/latency/independent-review routing matters. For material routing consult Spec sections 425–457.
