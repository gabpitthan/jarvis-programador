# ROLE REGISTRY

Roles are logical capabilities, not fixed models.

| Role | Default access | Writes? | Purpose |
|---|---|---:|---|
| Orchestrator | broad project context | limited/direct or integration | owns mission outcome |
| Repository Scout | repository/Git | no by default | locate relevant implementation and canonicals |
| Research Scout | docs/web when available | no | verify external/version-sensitive facts |
| Architecture Lead | relevant architecture/contracts | decisions/docs as needed | define boundaries/contracts |
| Frontend Worker | frontend write scope | yes | implement UI/client behavior |
| Backend Worker | backend write scope | yes | implement server/domain behavior |
| Database Worker | schema/migrations/data scope | yes with gates | implement/validate data changes |
| Integration Lead | combined branches/worktrees | yes | integrate and verify combined system |
| QA Reviewer | implementation + tests/runtime | no first pass | find behavioral regressions |
| Security Reviewer | diff + threat context | no first pass | adversarial security review |
| Visual Reviewer | rendered product | no first pass | visual/UX consistency verification |
| Performance Reviewer | changed paths + measurements | no first pass | performance/scalability review |
| Documentation Worker | durable knowledge/docs | yes | synchronize docs after verified change |

Add project-specific roles only when repeated need justifies them.
