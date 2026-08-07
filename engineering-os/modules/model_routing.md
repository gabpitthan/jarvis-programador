# MODULE — ADAPTIVE MODEL ROUTING

Load when:
- more than one model/provider/profile is available;
- ASSISTED or SWARM execution is considered;
- task cost/latency matters;
- independent review can use a distinct model;
- the environment supports per-agent model selection.

## Purpose

Choose execution topology, logical roles, model capability profiles and execution adapters independently.

## Required sequence

1. Classify mission risk/complexity/reversibility.
2. Choose SOLO / ASSISTED / SWARM.
3. Build dependency-aware task graph.
4. Assign logical roles.
5. Specify capability needs for each node.
6. Inspect available models/providers/adapters.
7. Route to cheapest suitable capability.
8. Apply Permission Envelope and context minimization.
9. Execute and verify.
10. Escalate/downroute based on evidence.
11. Record outcome for future project-specific evals.

## Profiles

ECONOMY — scouts, indexing, simple deterministic edits, routine scaffolding.
STANDARD — ordinary coding/debugging.
PREMIUM — architecture, ambiguous planning, hard debugging, high-value review.
CRITICAL — maximum capability only for exceptional consequence/complexity.

Profiles are abstract. Never bind policy permanently to a vendor/model name.

## Economics

Optimize total expected mission cost:
inference + retries + rework + integration + latency + failure consequence.

Do not use premium models for deterministic discovery.
Do not use weak models where failure consequence dominates price.

## Independence

For high-risk review prefer a fresh/different model or provider when permitted and useful.
Critics should receive requirements, diff, invariants and evidence rather than persuasive implementation narrative.

## Portability

Native subagent routing → use when available.
Multiple CLI processes/worktrees → use when native routing is absent.
Sequential role passes → fallback.

## OpenCode adapter note

When OpenCode is the selected adapter, it can expose per-agent model/tool configuration. Discover actual available model IDs at runtime; never assume names from this document. Keep OpenCode-specific configuration in an adapter, not in the universal Core.

## Safety

Cross-provider routing requires context sensitivity classification and minimum necessary context.
Provider availability does not imply authorization to send project data.

## Verification

Routing quality is measured by verified task outcomes, not perceived model intelligence.
