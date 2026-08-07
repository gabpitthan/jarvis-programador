# CAPABILITY MATRIX

Preenchida no bootstrap de 2026-08-07 para o ambiente **Claude Code / servidor Ubuntu (`claudeuser`)**.
Reavalie no BOOT de cada sessão: a CLI executora pode mudar (Codex, Gemini CLI, OpenCode) e as capabilities mudam com ela.

| Capability | Status | Evidence/Notes |
|---|---|---|
| Filesystem | YES | Ferramentas Read/Write/Edit nativas |
| Shell | YES | Bash, `nproc`=4, Node v22.22.3 |
| Git | YES | `/usr/bin/git`; credential store em `~/.git-credentials-konnex` |
| GitHub | PARTIAL | Sem `gh` CLI. Push por HTTPS + credential store; leitura da API por `curl` |
| Web research | YES | WebSearch/WebFetch disponíveis via ToolSearch (deferred) |
| Browser | YES | Chromium do Playwright em `~/.cache/ms-playwright/chromium-1234`. O pacote npm não está instalado globalmente: `npm i playwright` num diretório de trabalho resolve em ~3 s, porque só o pacote falta — o browser já está em cache. Verificado em 2026-08-07 contra `https://whitelabel.usekonnex.com` |
| Screenshots | YES | `page.screenshot({fullPage:true})` grava PNG; os PNGs são legíveis pela ferramenta Read. Verificado em 1440×900 claro, 1440×900 escuro e 390×844 |
| Database tools | YES | `docker exec whitelabel-whaticket-postgres-1 psql` — PostgreSQL 16.14 |
| Docker/container | YES | 19 containers ativos (whitelabel, whazing 1-3, wuzapi) |
| Subagents | YES | Ferramenta Agent: `general-purpose`, `Explore`, `Plan`, `claude` |
| Vector search | NO | Sem índice vetorial configurado |
| Code index/LSP | NO | Busca é textual (Grep/Glob) |
| Graph query | NO | — |
| Deploy access | YES | Docker + acesso a `/root/*` por travessia; produção real neste host |
| Production access | YES | **RED zone.** Whitelabel WhatsApp em produção com tráfego real |
| Native subagents | YES | Ferramenta Agent com contexto isolado por agente |
| Multi-process execution | YES | `Bash(run_in_background)` + agentes em background |
| Parallel tool execution | YES | Múltiplas chamadas independentes no mesmo bloco |
| Git worktrees | YES | `git worktree` + ferramentas EnterWorktree/ExitWorktree; `isolation: "worktree"` na Agent |
| Isolated agent contexts | YES | Cada subagente parte de contexto frio |
| Agent messaging/shared state | YES | SendMessage/ListAgents; estado compartilhado por arquivo em `runtime/` |
| Model routing | YES | Override por agente: `opus`, `sonnet`, `haiku`, `fable` |

## Restrições deste host que o JARVIS deve respeitar

- Os projetos pertencem a `root`; `/root` está aberto só para travessia. "Permission denied" ao editar resolve-se com `chown` no escopo mínimo, nunca recursivo no repo inteiro.
- Hooks de `PreToolUse` **negam** em vez de pedir: `block-secrets.sh` (leitura de segredos) e `block-destructive.sh` (`rm -rf` com alvo em `/home`, `/root`, `/var`, `/etc`, raiz). Um bloqueio é a política funcionando — não contorne, mude a abordagem (mover para trash em vez de apagar).
- `defaultMode` é `bypassPermissions`. O freio não é o prompt de permissão: é o AUTONOMY BUDGET do Core.
- **Verificação visual é obrigação do agente, não do usuário.** A primeira versão desta matriz declarou `Browser: NO` porque o pacote `playwright` não aparecia em `node_modules` — sem notar que os browsers já estavam em cache e que só faltava o pacote. A conclusão errada teria feito toda sessão futura declarar UNVERIFIED e devolver a verificação para Gabriel, justamente na frente onde o projeto mais precisa dela (redesign de 44 telas, contraste WCAG). Corrigido em 2026-08-07 com execução real, não com leitura.

  Receita que funciona neste host:

  ```bash
  cd <diretório de trabalho> && npm init -y && npm i playwright   # ~3 s
  # chromium.launch() → page.goto() → page.screenshot({fullPage:true})
  ```

  O que medir em cada verificação: erro de console, `pageerror`, requisição
  falha, rolagem horizontal, valor **computado** de cor/contraste (nunca o valor
  que o código deveria produzir), em desktop claro, desktop escuro e mobile.

- Lição geral desta linha: ausência de um pacote não é ausência da capacidade.
  Antes de escrever `NO` na matriz, **tente executar**. Uma capability marcada
  NO por engano não gera erro — gera trabalho que ninguém faz mais.
