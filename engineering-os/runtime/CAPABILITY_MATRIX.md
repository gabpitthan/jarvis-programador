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
| Browser | NO | Sem browser driver instalado |
| Screenshots | NO | Consequência da ausência de browser; verificação visual depende do usuário |
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
- Sem browser e sem screenshots: nenhuma alegação de verificação visual pode ser feita pelo agente sozinho.
