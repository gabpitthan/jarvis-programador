# CONSISTENCY ENGINE

Load when creating or modifying reusable patterns, UI, APIs, libraries, architecture or cross-cutting concerns.

## Canonical discovery
Before creating:
1. search equivalent behavior;
2. search abstractions and usages;
3. inspect dominant implementation frequency;
4. inspect docs/ADRs/canonicals;
5. inspect recent Git history if ambiguity remains.

Classify: CANONICAL / DOMINANT / ACCEPTED ALTERNATIVE / LEGACY / OUTLIER / DEPRECATED / UNKNOWN.

Prefer REUSE → EXTEND → CONSOLIDATE → CREATE.

## Canonical registry
Maintain durable canonicals for concerns such as:
- buttons/components;
- forms/validation;
- HTTP clients;
- auth;
- logging;
- dates;
- state;
- database access;
- error handling;
- tests;
- design tokens.

A canonical must have evidence and scope.

## Drift detection
Look for duplicate or competing systems.
Do not refactor unrelated drift automatically; register it unless directly blocking or dangerous.

## Deprecation lifecycle
NEW CANONICAL → OLD DEPRECATED → NO NEW USAGE → MIGRATE → VERIFY ZERO CONSUMERS → REMOVE.
