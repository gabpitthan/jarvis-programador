# ENGINEERING OS / JARVIS

Arquitetura operacional modular para vibe coding com engenharia profissional por baixo.

## Camadas

1. `JARVIS_CORE.md` — núcleo normativo robusto, sempre carregado.
2. `ENGINEERING_OS_INDEX.md` — índice para encontrar políticas relevantes.
3. `ENGINEERING_OS_SPEC.md` — constituição normativa completa.
4. `modules/` — profundidade especializada por concern.
5. `runtime/` — capabilities, missão ativa, lookup da Spec e policy coverage.
6. `templates/` — context capsule e checkpoints.

## Regra operacional

T0/T1 usam Core + contexto/módulos necessários.
T2+ exigem consulta seletiva à Spec e Policy Coverage.
T3/T4 exigem consulta aprofundada e gates de risco/approval/rollback.

A Spec não deve ser carregada integralmente em toda sessão, mas também nunca deve ser ignorada quando uma política relevante puder estar fora do Core.

O objetivo é evitar os dois extremos:
- monólito de contexto com ~10 mil linhas sempre carregadas;
- Kernel curto demais que perde nuance normativa.

## Multi-agent execution

JARVIS now supports logical SOLO, ASSISTED and SWARM modes.
The user still interacts with one Orchestrator. Internally, JARVIS may delegate discovery, implementation and independent review to multiple agents/models/CLI processes.

Load `modules/orchestration.md` for any multi-agent mission and maintain `runtime/SWARM_STATE.md`.

See `HOW_TO_USE_JARVIS.md` for the practical workflow.

## Adapters / bootloaders

`adapters/` contains small examples for connecting agent-specific persistent instruction files to the canonical JARVIS Core. They are bootloaders, not copies of the policy.


## Adaptive Execution & Model Routing

The package includes `modules/model_routing.md`, `runtime/ROUTING_STATE.md`, and an OpenCode adapter example. Routing separates topology, role, model profile and execution adapter so the system can mix models/providers without changing project engineering standards.
