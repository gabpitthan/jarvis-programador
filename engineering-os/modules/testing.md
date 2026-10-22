# VERIFICATION & TESTING

Load for any non-trivial behavior change.

## Test selection & coverage

- Select tests from blast radius, not convenience.
- Diff coverage threshold: **>= 85%** on the newly added or altered code.
- Prefer regression test for meaningful bug fixes:
  REPRODUCE FAIL → IMPLEMENT → PASS → SEARCH SIMILAR RISK.

## Test oracle rule

Expected behavior should come from requirement, existing contract, official docs, known fixture or product decision—not an expectation invented solely to validate the implementation.

For critical paths include:
HAPPY / NEGATIVE / ABUSE / RECOVERY paths.

## Verification truthfulness (No False Claims)

- **Explicit execution state:** Never report a test as passing if it was not executed against actual code. Clearly differentiate `PASS`, `FAIL`, `NOT EXECUTED` (NÃO EXECUTADO), and `NOT APPLICABLE`.
- **No speculative health:** A successful compile, linter pass, or health check does not imply that complex business logic or end-to-end flows were tested.
- **E2E & UI proof:** E2E or accessible component proof is required when the requested outcome crosses multiple layers. Validate keyboard shortcuts, screen-reader accessibility labels, mobile responsiveness, and dark/light themes.
