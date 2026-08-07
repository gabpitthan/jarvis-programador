# DATABASE ENGINEERING

Load for schema, queries, persistence, migrations, transactions or data integrity.

Check:
- real DB/version;
- data volume;
- nullability/defaults;
- indexes/cardinality;
- uniqueness/FKs/cascades;
- query plans when relevant;
- locking/concurrency;
- transaction duration/isolation;
- migration duration;
- backwards compatibility;
- rollout order;
- rollback;
- backups for destructive actions.

Never edit an already-applied migration silently.
For production, prefer backward-compatible evolution and EXPAND → MIGRATE → CONTRACT when needed.

Check idempotency, duplicate events, race conditions and lost updates.
