# SPEC LOOKUP PROTOCOL

`ENGINEERING_OS_SPEC.md` é a autoridade normativa completa.

## Antes da implementação

1. classifique T0–T4;
2. identifique domínios, riscos e concerns;
3. use `ENGINEERING_OS_INDEX.md` para localizar políticas;
4. carregue módulos relevantes;
5. para T2+, leia as seções relevantes da Spec antes de mudança material;
6. para T3/T4, inclua obrigatoriamente políticas de risco, segurança, dados/produção, rollback e verification aplicáveis;
7. registre cobertura em `runtime/POLICY_COVERAGE.md` ou equivalente de missão.

## Escalation triggers

Consulte a Spec mesmo em T0/T1 quando:
- Core/módulo estiver ambíguo;
- houver conflito entre fontes;
- um novo padrão/tecnologia estiver sendo introduzido;
- um comportamento puder quebrar contrato;
- houver side effect não trivial;
- houver ação destrutiva ou irreversível;
- houver dúvida normativa.

## Lookup behavior

SEARCH INDEX → READ RELEVANT SPEC SECTION → EXTRACT APPLICABLE POLICY → RECORD COVERAGE → EXECUTE.

Não carregue as 10 mil linhas por reflexo.
Não deixe de consultar a Spec apenas para economizar contexto.

## Conflict resolution

Se Core, módulo e Spec parecerem divergir:
1. confira se a informação está atual;
2. prefira política normativa mais específica e aplicável;
3. respeite Policy Hierarchy;
4. verifique realidade atual do repositório;
5. marque contradição e corrija documentação derivada depois da task quando necessário.

Nunca invente uma quarta política para resolver conflito.


## Adaptive routing lookup

For material heterogeneous model/provider routing, consult Spec sections 425–457 and load `modules/model_routing.md`.
