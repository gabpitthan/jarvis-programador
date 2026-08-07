# COMO USAR O JARVIS PARA PROGRAMAR

Este guia explica como usar o ENGINEERING OS/JARVIS no dia a dia para vibe coding com engenharia profissional por baixo.

O objetivo é simples:

> você descreve o resultado; o JARVIS descobre como implementar, escolhe a topologia de agentes, preserva padrões do projeto, executa, testa, revisa, documenta e entrega.

Você não precisa gerenciar manualmente arquitetura, testes, agentes, Git, memória ou documentação em toda task.

---

# 1. COMO PENSAR NO JARVIS

JARVIS não é um modelo de IA específico.

Ele é um sistema operacional de engenharia que vive no repositório.

Você pode usar:
- Codex;
- Claude Code;
- Gemini CLI;
- OpenCode;
- Copilot/agent compatível;
- outro coding agent atual ou futuro.

A CLI/modelo é o executor.
O ENGINEERING OS é a política e a memória operacional.

---

# 2. ARQUITETURA DOS ARQUIVOS

Arquivos principais:

`JARVIS_CORE.md`
- regras críticas sempre carregadas.

`ENGINEERING_OS_INDEX.md`
- mapa da constituição completa.

`ENGINEERING_OS_SPEC.md`
- autoridade normativa completa.

`modules/`
- políticas especializadas carregadas sob demanda.

`runtime/`
- estado da missão, capabilities, policy coverage e swarm.

`templates/`
- contratos de contexto, checkpoint e delegação.

A Spec completa não deve ser jogada inteira no contexto rotineiro.
O Core + módulos + trechos relevantes da Spec formam o contexto operacional.

---

# 3. INSTALAÇÃO EM UM PROJETO

Forma recomendada:

1. extraia o pacote dentro do repositório;
2. mantenha a estrutura do JARVIS em um diretório estável, por exemplo `.engineering/jarvis/`;
3. crie/adapte o arquivo de instrução que a CLI realmente lê;
4. faça esse arquivo apontar para `JARVIS_CORE.md` e para o protocolo de boot;
5. execute o `BOOTSTRAP_PROMPT.txt` uma vez para o agente analisar o projeto e adaptar o sistema;
6. revise alterações estruturais antes de colocá-las em produção.

Não copie cegamente padrões de um projeto para outro.
O primeiro bootstrap deve fazer DISCOVER → BASELINE → CAPABILITIES → ARCHITECT → INSTALL → VALIDATE.

---

# 4. BOOTLOADER POR CLI

A regra é: use o mecanismo nativo de instrução persistente da CLI como um bootloader curto.

Ele não deve duplicar toda a constituição.
Ele deve dizer ao agente para carregar o Core e seguir o ENGINEERING OS.

Exemplo conceitual de bootloader:

```md
# PROJECT AGENT BOOT

Antes de executar qualquer tarefa neste repositório:
1. leia `.engineering/jarvis/JARVIS_CORE.md`;
2. execute o BOOT definido no Core;
3. use `.engineering/jarvis/ENGINEERING_OS_INDEX.md` para consultar políticas;
4. carregue módulos necessários;
5. para T2+, faça Spec Lookup + Policy Coverage;
6. preserve estado/memória do projeto;
7. use SWARM somente quando justificado.
```

Exemplos de mecanismos conhecidos:
- Codex pode usar `AGENTS.md`;
- Claude Code pode usar seu arquivo de contexto/instruções de projeto;
- Gemini CLI suporta `GEMINI.md` como contexto persistente;
- outros agentes devem usar seu equivalente nativo.

Sempre confirme a documentação atual da CLI no bootstrap.

---

# 5. PRIMEIRA EXECUÇÃO

Na primeira execução, não comece pedindo uma feature grande.

Use o bootstrap:

```text
Leia BOOTSTRAP_PROMPT.txt e instale/adapte o ENGINEERING OS para este repositório. Faça discovery completo, baseline, capability detection e preserve as convenções boas existentes. Não implemente features não relacionadas.
```

O agente deve descobrir:
- stack;
- arquitetura;
- comandos;
- testes;
- banco;
- autenticação;
- integrações;
- deployment;
- Git/GitHub;
- design system;
- canonicals;
- critical paths;
- capabilities da CLI;
- suporte a subagents/worktrees/browser/memory.

Depois disso, o repositório passa a ter um JARVIS adaptado ao projeto.

---

# 6. COMO PEDIR COISAS NO DIA A DIA

Você pode escrever de forma natural.

Exemplos:

```text
Jarvis, adiciona opção de exportar clientes em CSV.
```

```text
Jarvis, esse modal está ruim no mobile. Corrige e mantém o mesmo padrão visual do restante da aplicação.
```

```text
Jarvis, quero permitir que clientes convidem membros da equipe e controlem quais áreas cada membro pode acessar.
```

```text
Jarvis, o checkout está duplicando pedidos quando o usuário clica duas vezes. Descobre a causa e corrige.
```

Você NÃO precisa escrever:
- quais arquivos alterar;
- qual library usar;
- qual arquitetura usar;
- quais testes criar;
- quais agentes usar.

Se essas respostas puderem ser descobertas no repositório, o JARVIS deve descobri-las sozinho.

---

# 7. O QUE ACONTECE DEPOIS DO SEU PROMPT

Fluxo conceitual:

```text
USER INTENT
    ↓
INTENT COMPILER
    ↓
TASK / RISK CLASSIFICATION
    ↓
CAPABILITY CHECK
    ↓
CONTEXT + MEMORY RETRIEVAL
    ↓
CONSISTENCY / CANONICAL DISCOVERY
    ↓
MISSION PLAN / TASK GRAPH
    ↓
SOLO / ASSISTED / SWARM
    ↓
IMPLEMENTATION
    ↓
INTEGRATION
    ↓
TEST / ATTACK / REVIEW
    ↓
FINAL ACCEPTANCE
    ↓
DOCS / MEMORY / GITHUB
    ↓
ONE RESULT TO USER
```

---

# 8. MODOS DE EXECUÇÃO

## SOLO

Um agente executa tudo.

Normal para:
- T0;
- T1 simples;
- mudanças localizadas.

Exemplo:

```text
Muda o texto desse botão para "Salvar alterações".
```

Não faz sentido criar swarm.

## ASSISTED

Um agente principal implementa e outros agentes auxiliam como scouts ou reviewers.

Exemplo:

```text
Adiciona exportação CSV de clientes.
```

Possível topologia:

```text
Main Agent
├── Repository Scout
└── QA Reviewer
```

## SWARM

Um Orchestrator coordena múltiplos agentes especializados.

Exemplo:

```text
Cria sistema de equipe com convites, roles e permissões por área.
```

Possível topologia:

```text
JARVIS ORCHESTRATOR
├── Auth Scout
├── Database Scout
├── Architecture Lead
├── Database Worker
├── Backend Worker
├── Frontend Worker
├── Security Reviewer
├── QA Reviewer
└── Integration Lead
```

Você continua falando com apenas um JARVIS.

---

# 9. COMO O JARVIS DECIDE QUANTOS AGENTES USAR

Não existe número fixo.

Ele considera:
- domains independentes;
- dependências;
- risco;
- tamanho da mudança;
- capacidade de paralelização;
- necessidade de revisão independente;
- capabilities da CLI;
- custo marginal.

Exemplo:

Task simples → 1 agente.

Task média → principal + 1 reviewer.

Task grande com frontend/backend/database → 3 workers + Orchestrator + reviewers quando útil.

Task crítica → especialistas + reviewers independentes + approval gates.

Nunca use "10 agentes" como meta.

---

# 10. COMO FUNCIONA O PARALELISMO

O JARVIS cria um DAG/Task Graph.

Exemplo:

```text
DEFINE PERMISSION MODEL
          ↓
DEFINE DATA/API CONTRACT
          ↓
    ┌─────┼─────┐
    ↓     ↓     ↓
DATABASE BACKEND FRONTEND
    └─────┼─────┘
          ↓
     INTEGRATION
          ↓
  SECURITY + QA
```

Nodes independentes podem rodar juntos.
Nodes dependentes esperam.

Regra:

> PARALLELIZE INDEPENDENT WORK. SERIALIZE DEPENDENT WORK.

---

# 11. WORKTREES E ISOLAMENTO

Se Git/worktrees estiverem disponíveis, o JARVIS pode separar frentes:

```text
worktree/db-feature
worktree/backend-feature
worktree/frontend-feature
```

Isso reduz conflitos.

Depois um Integration Lead combina as alterações.

Não significa que toda task terá múltiplas branches.
O isolamento é proporcional à necessidade.

---

# 12. DIFERENTES MODELOS PARA DIFERENTES PAPÉIS

O ENGINEERING OS não fixa modelo.

Uma implementação futura do router pode escolher:

```text
Architecture Lead → modelo A
Backend Worker → modelo B
Frontend Worker → modelo C
Security Reviewer → modelo D
```

Mas isso é opcional.

Se a CLI só possui um modelo, os mesmos papéis podem ser executados pelo mesmo modelo em contextos/passes separados.

ROLE != MODEL.

---

# 13. O QUE É UM SCOUT

Scout investiga sem sair alterando o projeto.

Exemplo:

```text
Repository Scout:
- localiza auth;
- identifica middleware;
- encontra testes;
- mapeia canonicals;
- encontra issue relevante;
- retorna resumo para Orchestrator.
```

Isso evita o agente principal desperdiçar contexto lendo milhares de arquivos.

---

# 14. O QUE É UM CRITIC / REVIEWER

Reviewer não existe para confirmar o implementer.

Existe para tentar encontrar algo errado.

Exemplo:

Security Reviewer:

```text
Tente acessar recurso de Tenant A usando usuário do Tenant B.
Procure authorization bypass, IDOR, mass assignment e regressões relacionadas ao diff.
```

QA Reviewer:

```text
Valide o success contract e tente quebrar o fluxo com estados inesperados.
```

Em mudanças críticas, review independente é mais valioso que mais um implementer.

---

# 15. QUANDO O JARVIS DEVE TE INTERROMPER

Idealmente apenas por:

1. decisão real de produto;
2. permissão/credencial necessária;
3. operação perigosa/irreversível;
4. blocker que não pode ser resolvido tecnicamente.

Exemplo correto:

```text
Preciso de uma decisão:
A) cada membro pode ter múltiplas roles;
B) cada membro possui uma role única.

Recomendo A porque...
```

Exemplo ruim:

```text
Qual pasta você quer que eu use?
```

Se o projeto consegue responder, JARVIS deve descobrir sozinho.

---

# 16. APPROVAL DE AÇÕES PERIGOSAS

JARVIS pode planejar autonomamente uma ação crítica, mas não deve executar silenciosamente:
- DROP/TRUNCATE;
- exclusão de dados reais;
- migration destrutiva em produção;
- rotação de secrets;
- alteração crítica de billing real;
- infraestrutura destrutiva;
- downtime material;
- ações irreversíveis.

Ele deve chegar com plano, impacto, rollback e pedido de approval no ponto necessário.

---

# 17. CONSISTÊNCIA AUTOMÁTICA

Quando você pede:

```text
Cria um botão para salvar.
```

JARVIS deve procurar:
- Button canônico;
- design tokens;
- loading pattern;
- icon library;
- accessibility pattern;
- formas existentes de salvar.

Fluxo:

```text
SEARCH EQUIVALENT
→ FIND CANONICAL
→ REUSE
→ EXTEND
→ CREATE ONLY IF NECESSARY
```

Isso vale para:
- UI;
- APIs;
- HTTP clients;
- validators;
- state management;
- logging;
- database access;
- auth;
- testes;
- documentação.

---

# 18. MEMÓRIA / RAG

Se Memory Engine avançado estiver disponível, JARVIS pode recuperar:
- decisões;
- bugs antigos;
- patterns;
- canonicals;
- issues;
- ADRs;
- código semanticamente relacionado.

Mas a memória não é autoridade superior ao código atual.

Prioridade geral:
realidade atual → código/config/schema → testes/contracts → decisões atuais → docs → Git/GitHub → memória → inferência.

Sem vector DB, JARVIS continua funcionando usando filesystem, Git, busca textual e `.engineering/`.

---

# 19. GITHUB

Quando conectado e permitido, JARVIS pode usar GitHub como camada operacional:
- ler issues relacionadas;
- identificar PRs anteriores;
- criar issue para dívida fora de scope;
- preparar PR;
- acompanhar CI;
- responder a review;
- atualizar documentação/release notes.

Não transforme toda descoberta em nova tarefa.

---

# 20. COMO PEDIR UMA FEATURE GRANDE

Você pode continuar sendo curto:

```text
Jarvis, quero sistema de afiliados. Cada cliente pode gerar link, acompanhar cliques, vendas e comissão. Admin precisa conseguir configurar percentual e aprovar pagamentos.
```

Já é suficiente para iniciar discovery.

Se houver decisão de produto que realmente não pode ser inferida, JARVIS te pergunta depois de investigar.

---

# 21. COMO PEDIR UM BUGFIX

```text
Jarvis, quando o usuário clica duas vezes em pagar, às vezes aparecem dois pedidos. Descobre a causa e corrige sem quebrar o checkout.
```

Esperado:
- reproduzir;
- localizar root cause;
- investigar idempotência/concurrency;
- criar regression test;
- corrigir;
- testar cenário normal + duplicado;
- procurar padrão semelhante quando relevante.

---

# 22. COMO PEDIR UMA MUDANÇA VISUAL

```text
Jarvis, melhora essa página para ficar consistente com o restante do SaaS e corrige o mobile. Não quero mudança funcional.
```

Esperado:
- descobrir design system real;
- reutilizar componentes;
- renderizar quando tooling existir;
- verificar desktop/mobile;
- não inventar um segundo design system.

---

# 23. COMO PEDIR UMA REFATORAÇÃO

Evite apenas:

```text
Refatora tudo.
```

Melhor:

```text
Jarvis, essa área está difícil de manter. Analisa primeiro a causa e proponha/execute a menor refatoração que reduza duplicação sem mudar comportamento público.
```

JARVIS deve preservar comportamento e provar regressão zero proporcionalmente ao risco.

---

# 24. COMO PEDIR PESQUISA + IMPLEMENTAÇÃO

```text
Jarvis, preciso integrar [serviço]. Pesquise a documentação oficial da versão atual, descubra o padrão do projeto e implemente de forma consistente.
```

O agente não deve implementar API externa só com memória do modelo.

---

# 25. COMO SABER SE TERMINOU

A resposta final deve ser curta e orientada a resultado.

Exemplo:

```text
Implementado.

- sistema de convites e permissões criado;
- migration validada;
- tenant isolation testado;
- UI verificada em desktop/mobile;
- 34 testes relevantes passaram;
- documentação e memória atualizadas.

Risco restante: nenhum blocker conhecido.
Ação sua: nenhuma.
```

Não confunda "agentes terminaram" com "feature funciona".

---

# 26. SE UMA CLI NÃO SUPORTAR SUBAGENTS

Nada quebra.

Fallback:

```text
ROLE A
↓
ROLE B
↓
INDEPENDENT REVIEW PASS
```

O workflow fica sequencial.

JARVIS continua aplicando os mesmos contratos e políticas.

---

# 27. SE A CLI SUPORTAR SUBAGENTS

JARVIS pode usar suporte nativo.

O boot deve descobrir:
- como criar subagent;
- quais tools ele recebe;
- se possui contexto separado;
- como compartilhar estado;
- limites de concorrência;
- como controlar permissões.

Não presuma sintaxe universal.

---

# 28. USO COM CODEX

Use o mecanismo de instrução persistente suportado pelo Codex no repositório como bootloader para o JARVIS.

Mantenha a política canônica no ENGINEERING OS, não duplique milhares de linhas no bootloader.

Se a instalação de Codex utilizada suportar tarefas/agentes paralelos, o Orchestrator pode mapeá-los para o SWARM. Caso contrário, use fallback sequencial/isolado.

Sempre confirme capabilities da versão realmente instalada.

---

# 29. USO COM CLAUDE CODE

Crie/adapte o contexto persistente do projeto para apontar ao JARVIS.

Claude Code também pode ser usado programaticamente/por subprocesso em arquiteturas de orquestração quando apropriado.

Não use permissões perigosas globais apenas para reduzir prompts. Configure Permission Envelope proporcional.

Sempre confirme capabilities da versão instalada.

---

# 30. USO COM GEMINI CLI

Use `GEMINI.md`/mecanismo de contexto do projeto como bootloader conforme suporte da versão instalada.

Se subagents/extensions estiverem disponíveis, o adapter pode mapear roles do JARVIS para essas capabilities.

Se não estiverem, degrade para execução sequencial.

---

# 31. TROCAR DE MODELO NO MEIO DA TASK

Tasks relevantes devem persistir checkpoint.

Novo agente carrega:
- Core;
- Active Mission;
- Swarm State;
- Task Graph;
- decisions;
- evidence;
- base commit;
- remaining work.

Ele não precisa da conversa anterior.

---

# 32. EXEMPLO COMPLETO

Pedido:

```text
Jarvis, quero permitir que clientes conectem domínio próprio ao SaaS.
```

Possível execução:

```text
Orchestrator
├── Repository Scout → descobre routing/tenant infra
├── Research Scout → verifica DNS/SSL/provider
├── Architecture Lead → define contract
├── Backend Worker → domain verification
├── Database Worker → domain state/schema
├── Frontend Worker → settings UI
├── Security Reviewer → takeover/tenant isolation
├── QA Reviewer → domain journey/failure states
└── Integration Lead → combina + testa
```

Você continua vendo uma única missão.

---

# 33. O QUE NÃO FAZER

Não peça ao Jarvis para ignorar testes só por velocidade.
Não deixe múltiplos agentes escreverem no mesmo arquivo sem coordenação.
Não use swarm em tarefa trivial.
Não trate saída de um subagent como verdade sem integração/review.
Não entregue credenciais de produção a todos os agents.
Não transforme RAG em source of truth.
Não permita que cada CLI crie sua própria política divergente.

---

# 34. ROTINA RECOMENDADA

No dia a dia:

1. abra a CLI no root do projeto;
2. confirme que o bootloader carrega JARVIS;
3. escreva o resultado que deseja;
4. deixe JARVIS investigar e escolher execução;
5. responda apenas a decisões/approvals reais;
6. leia o resultado final;
7. faça revisão humana extra em mudanças críticas quando necessário.

É isso.

A complexidade fica dentro do sistema.

---

# 35. NORTH STAR

A experiência ideal é:

```text
VOCÊ:
"Jarvis, faz X."

JARVIS:
descobre
planeja
orquestra
programa
testa
corrige
revisa
integra
documenta
aprende

JARVIS:
"Pronto."
```

VIBE CODING NA SUPERFÍCIE.
ENGENHARIA PROFISSIONAL POR BAIXO.


---

# Adaptive model routing

You normally do not choose models manually.

Example request:

> Jarvis, implement a complete affiliate system with tracking, commissions, dashboard and payout approval.

Jarvis should decide:
- SOLO, ASSISTED or SWARM;
- which logical roles are needed;
- which work is dependent vs parallel;
- which nodes deserve ECONOMY, STANDARD, PREMIUM or CRITICAL capability;
- which available CLI/provider/model executes each node;
- whether an independent reviewer should use a different model/provider.

A typical large mission can look like:

PREMIUM planner
→ stabilize architecture/contracts
→ STANDARD backend + STANDARD frontend in parallel
→ ECONOMY/ STANDARD tests and documentation
→ PREMIUM independent security/final review.

This is not fixed. The router must inspect the actual environment and project evidence.

## When using OpenCode

Connect/configure the providers you are authorized to use and let the adapter discover available models. OpenCode supports per-agent model and permission configuration, so it is a good execution adapter for heterogeneous routing.

Do not copy model IDs from this guide blindly. Use the IDs exposed by the installed OpenCode environment.

## User overrides

You can still say:
- "Use at most 3 agents."
- "Do not use provider X."
- "Keep this under my configured cost budget."
- "Force a premium independent review."
- "Run this SOLO."
- "Use SWARM but no cross-provider routing."

Otherwise Jarvis chooses automatically.
