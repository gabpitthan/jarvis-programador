# VERIFICATION & TESTING

Load for any non-trivial behavior change.

Select tests from blast radius, not convenience.

Prefer regression test for meaningful bug fixes:
REPRODUCE FAIL → IMPLEMENT → PASS → SEARCH SIMILAR RISK.

Test oracle rule:
expected behavior should come from requirement, existing contract, official docs, known fixture or product decision—not an expectation invented solely to validate the implementation.

For critical paths include:
HAPPY / NEGATIVE / ABUSE / RECOVERY paths.

E2E proof is preferred when the requested outcome crosses multiple layers.
