# OPENCODE ADAPTER — MODEL ROUTING EXAMPLE

This is an adapter example, not ENGINEERING OS policy.

OpenCode can configure primary agents/subagents with their own models and tool permissions. The exact provider/model IDs must be discovered from the installed OpenCode environment.

Recommended mapping:
- jarvis-orchestrator: primary; strong suitable profile; coordinates only.
- planner/architect: premium profile; read-oriented unless implementation is explicitly assigned.
- scout: economy profile; read/search/LSP only.
- implementer: standard profile; scoped edit/bash.
- test-worker: economy/standard profile; scoped tests.
- security-reviewer: premium profile; preferably read-only critic.
- integration-lead: standard/premium according to mission risk.
- final-reviewer: premium for material/high-risk work.

Rules:
1. Do not hard-code model names in universal policy.
2. Discover models/providers available to the current project.
3. Apply least privilege per agent.
4. Keep workers inside assigned write scopes.
5. Preserve JARVIS Core, relevant modules, invariants and success contract across all agents.
6. Route by project eval evidence when available.
