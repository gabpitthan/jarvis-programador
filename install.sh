#!/usr/bin/env bash
# Instala o ENGINEERING OS / JARVIS em um projeto.
#
#   ./install.sh <caminho-do-projeto> [--copy]
#
# Por padrão cria um symlink para este repositório, de modo que atualizar o
# JARVIS aqui atualize todos os projetos de uma vez. Use --copy para congelar
# uma cópia independente (projetos que precisam divergir da política central).
set -euo pipefail

JARVIS_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-}"
MODE="${2:-}"

if [[ -z "$TARGET" ]]; then
  echo "uso: $0 <caminho-do-projeto> [--copy]" >&2
  exit 1
fi

if [[ ! -d "$TARGET" ]]; then
  echo "erro: '$TARGET' não é um diretório" >&2
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd)"

if [[ "$TARGET" == "$JARVIS_HOME" ]]; then
  echo "erro: o repositório do JARVIS não se instala dentro de si mesmo" >&2
  exit 1
fi

DEST="$TARGET/.engineering/jarvis"
mkdir -p "$TARGET/.engineering"

if [[ -L "$DEST" && "$(readlink "$DEST")" == "$JARVIS_HOME/engineering-os" ]]; then
  # Já é o mesmo link: reinstalar não muda nada e não deve deixar lixo.
  rm "$DEST"
elif [[ -e "$DEST" || -L "$DEST" ]]; then
  BACKUP="$DEST.anterior-$(date +%Y%m%d-%H%M%S)"
  mv "$DEST" "$BACKUP"
  echo "instalação anterior movida para $BACKUP"
fi

if [[ "$MODE" == "--copy" ]]; then
  cp -a "$JARVIS_HOME/engineering-os" "$DEST"
  echo "JARVIS copiado para $DEST (cópia independente)"
else
  ln -s "$JARVIS_HOME/engineering-os" "$DEST"
  echo "JARVIS ligado a $DEST -> $JARVIS_HOME/engineering-os"
fi

# Bootloader da CLI. Não sobrescreve política existente: faz merge por anexação,
# conforme BOOTSTRAP_PROMPT.txt ("não remova políticas existentes úteis").
write_bootloader() {
  local file="$1"
  local marker="# JARVIS BOOT"

  if [[ -f "$file" ]] && grep -qF "$marker" "$file"; then
    echo "bootloader já presente em $(basename "$file") — nada a fazer"
    return
  fi

  # Instalação parcial silenciosa é pior que falha: um projeto sem bootloader
  # não carrega o Core e nada avisa. Falhe alto.
  if [[ -f "$file" && ! -w "$file" ]] || [[ ! -e "$file" && ! -w "$(dirname "$file")" ]]; then
    echo "erro: sem permissão de escrita em $file" >&2
    echo "       corrija o dono no escopo mínimo e rode de novo:" >&2
    echo "       sudo chown \$USER $file" >&2
    return 1
  fi

  if [[ -f "$file" ]]; then
    printf '\n' >> "$file"
    echo "bootloader anexado a $(basename "$file") (política existente preservada)"
  else
    echo "bootloader criado em $(basename "$file")"
  fi

  cat >> "$file" <<'EOF'
# JARVIS BOOT

Este repositório usa o ENGINEERING OS / JARVIS.

Antes de qualquer tarefa:

1. leia `.engineering/jarvis/JARVIS_CORE.md` por completo e execute o BOOT definido nele;
2. carregue `.engineering/jarvis/ENGINEERING_OS_INDEX.md`;
3. classifique a task T0–T4 e selecione módulos por `.engineering/jarvis/runtime/MODULE_ROUTER.md`;
4. para T2+, faça o lookup dirigido da Spec segundo `.engineering/jarvis/runtime/SPEC_LOOKUP_PROTOCOL.md` e preencha o Policy Coverage antes de mudança material;
5. decida SOLO / ASSISTED / SWARM conforme a topologia da task e as capabilities reais;
6. verifique o resultado real antes de declarar DONE.

Não duplique a política do ENGINEERING OS neste arquivo. Ele é bootloader.
EOF
}

write_bootloader "$TARGET/CLAUDE.md"
[[ -f "$TARGET/AGENTS.md" ]] && write_bootloader "$TARGET/AGENTS.md"

echo
echo "pronto. rode uma vez no projeto, para o agente adaptar o OS ao repositório:"
echo
echo "  Leia .engineering/jarvis/BOOTSTRAP_PROMPT.txt e instale/adapte o ENGINEERING OS"
echo "  para este projeto. Faça discovery, baseline, capability detection, canonicals e"
echo "  validação antes de considerar o setup pronto."
