# PRODUCTION & OPERATIONS

Load for deployment, infra, observability, reliability or production impact.

## Core principles

Consider:
backward compatibility, rollout, health/readiness, migration ordering, downtime, rollback, logs, metrics, alerts and feature flags.

## External services & fail-closed behavior

When integrating with external providers (SMTP mailers, payment gateways, S3/MinIO storage, WhatsApp/Telegram connectors):
- **Fail-closed in production:** Never simulate success or silently drop deliveries when credentials or endpoints are unconfigured in production. If `SMTP_HOST` or credentials are missing in production, the service must fail-closed and abort operations, logging explicit alerts rather than generating false delivery claims.
- **Protocol verification:** Test connectivity, authentication, and handshake (e.g., STARTTLS/TLS and AUTH for SMTP; S3 bucket head check) during boot or readiness probes.
- **Timeouts & resilience:** Implement strict socket/connection timeouts, bounded retry/backoff, idempotency keys, and circuit breakers.

## Storage inventory & ledger readiness

- **State synchronization:** Migrations that add quota, ledger, or account state must not leave tenant resources in indefinite `PENDING` states that break user operations (e.g., avatar or media upload returning 503).
- **Readiness probes:** The `/health/ready` probe must verify database connectivity, Redis responsiveness, migration status, queue health, and storage account inventory state.

## Release approval & candidate SHA authorization

- **Separation of authority:** CI pass, review approval, and git merge **do not** authorize deployment.
- **Candidate exact SHA:** The product owner gives explicit release authorization strictly for the exact candidate commit SHA and target environment.
- **Fail-closed release receipt:** Entry points must verify an immutable, private release receipt (`mode 0600`) matching the exact SHA, target path, and owner instruction within a valid validity window (e.g., 90 minutes).

## Deployment & rollback safety

- **Pre-deploy backup:** Create and verify full logical database dumps and storage archives before mutating live runtime containers.
- **Rolling deployment:** Zero-downtime rolling update of application replicas with sequential health-check gates before traffic shifting.
- **Atomic frontend release:** Deploy web assets into a versioned release folder, switching the live symlink atomically with preserved rollback targets.
- **Immutable artifact manifests:** Record checksums (`SHA256SUMS`) for deploy artifacts and preserve rollback configurations.

## Post-change observation

DEPLOY → OBSERVE → COMPARE EXPECTED VS REAL → RESPOND/LEARN.
- Sample production health and readiness endpoints for an observation window.
- Monitor log streams for unhandled exceptions, crash loops, or elevated HTTP 4xx/5xx rates.
- Never claim production health without observable runtime evidence.
- A test not executed must be recorded as `NÃO EXECUTADO`; a deployment not observed must be recorded as `NÃO OBSERVADO`.
