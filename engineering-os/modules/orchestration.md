# ORCHESTRATION / SWARM

Load for T2+ missions, subagents, parallel work, multi-model execution or long-running tasks.

## Execution modes

SOLO
- one principal agent;
- default for T0/T1.

ASSISTED
- principal agent + scouts and/or critics;
- useful when independent discovery/review adds value.

SWARM
- Orchestrator + specialized workers/critics;
- useful for independent multi-domain work, T2+, or high-risk review.

Never equate more agents with better engineering.

## Orchestrator

The Orchestrator owns the final outcome even when every implementation node is delegated.

It must:
1. compile user intent;
2. create success contract;
3. build DAG/task graph;
4. identify dependencies;
5. select roles;
6. assign ownership/write scopes;
7. choose parallel vs sequential execution;
8. maintain shared mission state;
9. integrate outputs;
10. resolve conflicts;
11. run final verification;
12. communicate one coherent result to the user.

## Roles

SCOUTS — read-first discovery.
LEADS — architecture/domain decisions.
WORKERS — scoped implementation.
CRITICS — independent review.
INTEGRATION LEAD — combines and validates the system.

Possible specialized roles:
Repository Scout
Architecture Scout
GitHub Scout
Research Scout
Frontend Lead/Worker
Backend Lead/Worker
Database Lead/Worker
Security Reviewer
QA Reviewer
Visual Reviewer
Performance Reviewer
Adversarial Reviewer
Documentation Worker
Operations Reviewer.

Roles are logical. They do not imply a particular model or CLI.

## DAG

Each node may contain:
NODE_ID
OBJECTIVE
INPUTS
OUTPUTS
DEPENDENCIES
ROLE
OWNER
WRITE_SCOPE
RISK
STATUS
EVIDENCE
BLOCKERS.

States:
PENDING / READY / RUNNING / BLOCKED / REVIEW / FAILED / DONE / SUPERSEDED.

Only READY nodes may start.

PARALLELIZE INDEPENDENT WORK.
SERIALIZE DEPENDENT WORK.

## Contract-first parallelism

When teams depend on shared contracts, define enough contract first.
Examples:
- DB schema;
- API DTO;
- events;
- permissions;
- error shape;
- acceptance criteria.

Then parallelize consumers/producers where safe.

## Ownership

Every writing worker gets temporary ownership by file/module/domain/worktree.
Avoid concurrent writes to same file.
If overlap is required, serialize or nominate one integration owner.

## Isolation

When supported prefer branch/worktree/sandbox per writing lane.
Record BASE_COMMIT, branch/worktree, files changed and contract assumptions.

## Agent result contract

Every subagent returns:
ROLE
NODE_ID
STATUS
SUMMARY
AREAS/FILES
DECISIONS
ASSUMPTIONS
EVIDENCE/TESTS
RISKS
UNRESOLVED
HANDOFF.

Workers additionally return diff/commit/branch when applicable.
Critics return severity + evidence.

## Integration

One Integration Lead owns combined correctness.
Check:
- contracts;
- overlapping changes;
- stale outputs;
- migrations;
- cross-module behavior;
- integration tests;
- final diff.

Merge success is not product success.

## Critics

Critics should be independent where practical.
Severity:
BLOCKER / CRITICAL / HIGH / MEDIUM / LOW / NIT.

Do not create duplicate reviewers with identical missions.

## Capability degradation

If native subagents exist → use them when justified.
Else if multiple isolated processes/worktrees are possible → orchestrate them safely.
Else → execute roles sequentially while preserving distinct review passes.

The logical workflow must survive CLI differences.

## Dynamic sizing

Default guidance:
T0 → SOLO
T1 → SOLO or ASSISTED
T2 → ASSISTED or small SWARM
T3 → SWARM / independent review when capabilities justify
T4 → controlled SWARM + human approval gates.

Spawn a subagent only when work is contractable, useful and integrable.

## Failure recovery

If a worker fails:
OBSERVE → CLASSIFY → RETRY / REASSIGN / REPLAN / SERIALIZE.

Do not lose mission state.

Before accepting delayed worker output, revalidate base commit, contracts and current need.

## Security

Subagents receive least privilege.
Scouts are read-first.
Critics are review-first.
No subagent may bypass Permission Envelope or approval gates.

## Final swarm gate

DONE only when:
- task graph dispositioned;
- combined implementation integrated;
- conflicts resolved;
- tests relevant to combined blast radius pass;
- critic blockers resolved;
- policy coverage complete;
- docs/memory updated;
- success contract verified end-to-end when possible.

THE USER TALKS TO ONE JARVIS. JARVIS MAY USE MANY AGENTS.

## Entrada por qualquer CLI e coordenação entre processos

Quando o mesmo projeto possuir vários CLIs interativos, qualquer CLI pode
receber a intenção. O receptor torna-se o Integration Lead daquela missão;
nenhuma conta ou fornecedor é líder permanente. Antes de iniciar escrita,
reconcilie panes/processos, worktrees, ownership e missões já ativas. Use o
quadro transacional de missão definido pelo projeto, quando existir, para
registrar objetivo, critérios de aceite, DAG, base, dono e escopo de cada nó.

Distribua nós READY apenas a executores capazes e efetivamente disponíveis.
Equilibre o histórico de trabalho entre eles sem atrasar uma tarefa por
igualdade numérica. Nunca envie prompt para um pane ocupado. Se a sessão não
suportar entrega segura a outro CLI, continue os nós locais e registre a fila;
não alegue que o trabalho foi distribuído.

Cada executor retorna evidência vinculada ao HEAD. O líder confere a base e
integra uma vez. A missão só fecha após aceitação do resultado combinado. T0/T1
seguem SOLO por padrão; T2+ podem usar ASSISTED/SWARM conforme dependências e
risco. Produção continua sujeita a autorização específica do usuário: CI verde,
aprovação de revisão e merge não autorizam deploy. A publicação aguarda autorização
explícita e separada do proprietário vinculada ao candidato exato (SHA). Nenhum quadro
de missão, autonomia de swarm ou estado `DONE` concede permissão de deploy.
