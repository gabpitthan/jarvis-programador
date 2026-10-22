#!/usr/bin/env bash
# Instala o ENGINEERING OS / JARVIS em um projeto.
#
#   ./install.sh <caminho-do-projeto> [--copy]
#
# Este script agora delega para `workspace/jarvis add`, que é o instalador
# canônico: além do symlink de política (ou --copy para congelar), ele cria
# o estado de missão isolado por CLI e escreve os bootloaders de todos os CLIs
# presentes (CLAUDE.md, AGENTS.md, ...), para que Claude, Codex e outros rodem
# em paralelo sem corromper o estado um do outro.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$HERE/workspace/jarvis" add "$@"
