# Workspace — vários projetos, vários CLIs, ao mesmo tempo

`jarvis` (em `~/.local/bin/jarvis`) opera múltiplos projetos em paralelo, cada um
podendo ser conduzido por CLIs diferentes (Claude Code, Codex, ...), todos sob o
mesmo ENGINEERING OS.

## O modelo

- **Perfis de política.** Nem tudo fica sob o mesmo Jarvis. Cada projeto escolhe um
  **perfil** no onboard (`--profile <nome>`). O perfil padrão `producao` é o
  repositório canônico (o "Jarvis no main"), compartilhado por quem o usa. Outros
  perfis (`jarvis profile new <nome>`) são cópias que **divergem sozinhas** — política
  própria, sem afetar os demais. Projetos do mesmo perfil compartilham e atualizam
  juntos; perfis diferentes são independentes.
- **Estado = privado por instância.** Estado de trabalho novo vive em
  `.engineering/state/instances/<id-do-pane-ou-sessao>/`, um por processo/conta.
  Os antigos `.engineering/state/<cli>/` são históricos, pois duas contas do
  mesmo CLI poderiam colidir ali. O quadro compartilhado de missão é definido
  pelo projeto; não use os arquivos em `engineering-os/runtime/` como estado
  mutável. `.engineering/state/` é git-ignorado.

## Uso

```bash
jarvis add  <caminho> [--profile <nome>] [--copy]   # onboarda num perfil (padrão: producao)
jarvis up   <nome> [claude|codex|gemini|agy]  # abre/atacha uma janela do CLI
jarvis ls                          # projetos registrados (com perfil) + sessões vivas
jarvis down <nome>                 # encerra a sessão do projeto
jarvis profiles                    # lista os perfis de política
jarvis profile new <nome> [--from <perfil>]   # cria um perfil que diverge sozinho
jarvis clis                        # CLIs detectados no servidor
```

Perfis diferentes para propósitos diferentes:

```bash
jarvis profile new lite            # política enxuta a partir do canônico
jarvis add /root/whitelabel-whaticket             # perfil producao (rigoroso)
jarvis add /home/claudeuser/konnex-lp --profile lite
# editar profiles/lite/ muda só quem usa 'lite'; producao e o main ficam intactos
```

Cada projeto vira uma **sessão tmux** (nome = pasta do projeto); cada CLI vira uma
**janela** dentro dela. Projetos diferentes são sessões diferentes, então rodam em
paralelo. Dentro de um projeto, `Ctrl-b` + número troca de CLI; `Ctrl-b d` solta a
sessão sem matá-la.

O comando `jarvis up` abre uma janela por tipo de CLI; contas adicionais já
abertas em panes próprios precisam ser registradas como instâncias distintas no
quadro de missão do projeto. Não reutilize o mesmo estado privado para duas
contas.

Exemplo — Whitelabel no Claude e a landing no Codex, ao mesmo tempo:

```bash
jarvis add /root/whitelabel-whaticket
jarvis add /home/claudeuser/konnex-lp
jarvis up whitelabel-whaticket claude    # sessão 'whitelabel-whaticket', janela 'claude'
jarvis up konnex-lp codex                # sessão 'konnex-lp', janela 'codex'
```

## Isolamento que o modelo NÃO cobre (cuide à parte)

- **Working tree do git.** Dois agentes no mesmo repo e mesma branch colidem. Para
  tarefas paralelas no mesmo projeto, use `git worktree add` — uma branch/dir por
  tarefa — e aponte o CLI para o worktree.
- **Portas e containers.** Cada projeto sobe serviços em portas próprias. Mantenha o
  registro em `reference_servidor` na memória para não colidir.
