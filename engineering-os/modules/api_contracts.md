# API & CONTRACTS

Load for APIs, SDKs, webhooks, events, queues or public/internal contracts.

Before changing public symbols/contracts:
search references globally and identify external-consumer risk.

Maintain consistency in:
naming, validation, auth, authorization, status codes, error envelope, pagination, serialization, idempotency and versioning.

Prefer evolution:
ADD → DUAL SUPPORT → MIGRATE CONSUMERS → OBSERVE → DEPRECATE → REMOVE.

Never break consumers silently.
