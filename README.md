# jarvis-programador

Fonte canônica do **ENGINEERING OS / JARVIS** — a política de engenharia que governa como agentes programam em todos os projetos deste servidor.

Não é uma aplicação. É a regra geral. Um projeto de aplicação aponta para cá; ele não copia a política.

## A ideia

```
USER INTENT → AUTONOMOUS ENGINEERING → VERIFIED RESULT
```

Você descreve o resultado. O agente descobre o caminho técnico, consulta a política certa, implementa, verifica, documenta e só interrompe você quando existe decisão real de produto, risco fora do orçamento de autonomia, ou um blocker genuíno.

## Estrutura

| Caminho | Papel |
|---|---|
| `engineering-os/JARVIS_CORE.md` | Núcleo normativo, sempre carregado (~50 KB) |
| `engineering-os/ENGINEERING_OS_INDEX.md` | Mapa para consulta seletiva da Spec |
| `engineering-os/ENGINEERING_OS_SPEC.md` | Autoridade normativa completa (~213 KB) |
| `engineering-os/modules/` | Profundidade por concern: segurança, database, frontend, orquestração, roteamento de modelo… |
| `engineering-os/runtime/` | Protocolos e gabaritos; estado vivo fica no projeto, separado por instância |
| `engineering-os/templates/` | Contratos de context capsule, checkpoint e delegação |
| `engineering-os/adapters/` | Bootloaders para Claude Code, Codex, Gemini CLI, OpenCode |
| `install.sh` | Instala o OS em um projeto |

A camada que resolve o problema central: **a Spec nunca é carregada inteira por reflexo, e nunca é ignorada quando uma política relevante está fora do Core.** T0/T1 rodam com Core + módulos. T2+ exigem lookup dirigido na Spec e Policy Coverage preenchido antes de mudança material.

## Instalar em um projeto

```bash
./install.sh /caminho/do/projeto           # symlink — o projeto acompanha a política central
./install.sh /caminho/do/projeto --copy    # cópia congelada, para quem precisa divergir
```

Depois, uma vez por projeto:

```
Leia .engineering/jarvis/BOOTSTRAP_PROMPT.txt e instale/adapte o ENGINEERING OS
para este projeto. Faça discovery, baseline, capability detection, canonicals e
validação antes de considerar o setup pronto.
```

O bootstrap não trata o pacote como template cego: ele descobre o projeto real antes de instalar.

## Usar

```
Jarvis, adiciona exportação CSV de clientes.
```

O JARVIS escolhe sozinho entre SOLO / ASSISTED / SWARM. Você não gerencia agentes.

Guias: `engineering-os/QUICKSTART.md` (5 min) e `engineering-os/HOW_TO_USE_JARVIS.md` (completo).

## Ambiente

`engineering-os/runtime/CAPABILITY_MATRIX.md` é um retrato histórico do ambiente Claude Code, não inventário atual. Cada CLI precisa redescobrir suas capacidades no BOOT. Para várias contas no mesmo projeto, use estado privado por instância e um quadro compartilhado de ownership.

Reavalie a matriz quando a CLI executora mudar. O OS é portátil entre agentes; as capabilities não são.

## Versão

Pacote base `engineering_os_jarvis_v9`, preservado íntegro em `engineering-os-v9-original.zip` para diff contra futuras versões upstream.
