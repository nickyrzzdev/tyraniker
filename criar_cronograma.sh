#!/usr/bin/env bash
# Cria milestones, issues e datas (Gantt) do projeto "Eu Sou a Lenda".
# Requisitos: gh instalado, `gh auth login` feito e escopo "project" ativo:
#   gh auth refresh -s project
#
# Uso:
#   1) edite as variáveis da seção CONFIGURAÇÃO
#   2) teste sem criar nada:   DRY_RUN=1 ./criar_cronograma.sh
#   3) rode de verdade:        ./criar_cronograma.sh
#
# ATENÇÃO: rodar duas vezes cria issues duplicadas. Rode uma vez só.

set -euo pipefail

# ---------------------------- CONFIGURAÇÃO ----------------------------
REPO="nickyrzzdev/tyraniker"   # ex.: nicole/eu-sou-a-lenda
PROJECT_OWNER="@me"               # "@me" se o projeto é da sua conta; ou o nome da organização
PROJECT_NUMBER=3                  # número na URL: github.com/users/.../projects/NUMERO
START_FIELD="Start date"          # nome do campo de início no projeto
END_FIELD="Target date"           # nome do campo de fim no projeto
YEAR=2026
DRY_RUN="${DRY_RUN:-0}"
# ----------------------------------------------------------------------

# Milestones (fases): "título|data final (dd/mm)"
MILESTONES=(
  "1. Pré-produção|20/11"
  "2. Protótipo / Core Loop|28/11"
  "3. Arte e Shaders|02/12"
  "4. Polimento|05/12"
  "5. GitHub Pages e Entrega|07/12"
)

# Tarefas: "milestone|título|início (dd/mm)|fim (dd/mm)|done"
# O último campo é opcional: "x" fecha a issue (tarefa já concluída).
TASKS=$(cat <<'EOF'
1. Pré-produção|Criar repositório e README|19/11|19/11|x
1. Pré-produção|Criar projeto Godot e estrutura de pastas|19/11|19/11
1. Pré-produção|Escrever mini-GDD|19/11|20/11
1. Pré-produção|Montar board e Roadmap no GitHub Projects|19/11|20/11
1. Pré-produção|Separar assets de referência no itch.io|20/11|20/11
2. Protótipo / Core Loop|Movimento do player (CharacterBody2D)|20/11|21/11
2. Protótipo / Core Loop|Câmera seguindo o player|21/11|21/11
2. Protótipo / Core Loop|Mapa do dia com TileMapLayer e colisões|21/11|23/11
2. Protótipo / Core Loop|Itens coletáveis com Area2D|22/11|23/11
2. Protótipo / Core Loop|Autoload GameState (recursos e sanidade)|23/11|23/11
2. Protótipo / Core Loop|HUD com contadores|23/11|24/11
2. Protótipo / Core Loop|Timer do dia e transição Dia → Noite|24/11|25/11
2. Protótipo / Core Loop|Casa com 3 barricadas e HP|25/11|26/11
2. Protótipo / Core Loop|Inimigo básico atacando a barricada|25/11|26/11
2. Protótipo / Core Loop|Reparar barricada (gasta madeira)|26/11|26/11
2. Protótipo / Core Loop|Estaca para matar o inimigo|26/11|27/11
2. Protótipo / Core Loop|Spawner de ondas por noite|27/11|27/11
2. Protótipo / Core Loop|Sistema de sanidade|27/11|28/11
2. Protótipo / Core Loop|Telas de vitória, derrota e reinício|28/11|28/11
3. Arte e Shaders|Sprite do player|25/11|27/11
3. Arte e Shaders|Sprites do vampiro e da barricada|26/11|28/11
3. Arte e Shaders|Tileset do bairro e da casa|27/11|29/11
3. Arte e Shaders|Shader de wobble|28/11|29/11
3. Arte e Shaders|Shader de posterização e paleta|29/11|30/11
3. Arte e Shaders|CanvasModulate + PointLight2D (dia/noite)|29/11|30/11
3. Arte e Shaders|Animação quadro a quadro (baixo FPS)|30/11|01/12
3. Arte e Shaders|Efeito de sanidade baixa no shader|01/12|02/12
3. Arte e Shaders|Sons e música (itch.io)|01/12|02/12
4. Polimento|Menu inicial e tela de créditos|02/12|03/12
4. Polimento|Balancear as 3 noites|03/12|04/12
4. Polimento|Feedback visual (tremor, flash de dano)|03/12|04/12
4. Polimento|Playtest e correção de bugs|04/12|05/12
4. Polimento|Exportar build Web (HTML5)|05/12|05/12
5. GitHub Pages e Entrega|Definir estrutura e tema do site|03/12|03/12
5. GitHub Pages e Entrega|Página inicial (título, descrição, prints)|03/12|04/12
5. GitHub Pages e Entrega|Seções "Sobre o jogo" e "Como jogar"|04/12|05/12
5. GitHub Pages e Entrega|Embutir ou linkar a build jogável|05/12|06/12
5. GitHub Pages e Entrega|Créditos dos assets (itch.io)|05/12|06/12
5. GitHub Pages e Entrega|Revisar README e fechar o Roadmap|06/12|06/12
EOF
)

# Converte "dd/mm" em "AAAA-MM-DD"
iso() {
  local d m
  IFS=/ read -r d m <<< "$1"
  printf '%s-%s-%s' "$YEAR" "$m" "$d"
}

# ---------------------------- VERIFICAÇÕES ----------------------------
command -v gh >/dev/null || { echo "gh não encontrado. Instale: https://cli.github.com"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Faça login primeiro: gh auth login"; exit 1; }

if [[ "$REPO" == "SEU-USUARIO/NOME-DO-REPO" ]]; then
  echo "Edite a variável REPO no início do script."
  exit 1
fi

[[ "$DRY_RUN" == "1" ]] && echo ">>> MODO TESTE (DRY_RUN): nada será criado <<<"

# --------------------- IDs do projeto e dos campos ---------------------
if [[ "$DRY_RUN" != "1" ]]; then
  PROJECT_ID=$(gh project view "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --format json --jq '.id')
  START_ID=$(gh project field-list "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --format json \
    --jq ".fields[] | select(.name==\"$START_FIELD\") | .id")
  END_ID=$(gh project field-list "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --format json \
    --jq ".fields[] | select(.name==\"$END_FIELD\") | .id")

  if [[ -z "$PROJECT_ID" || -z "$START_ID" || -z "$END_ID" ]]; then
    echo "Não achei o projeto ou os campos de data."
    echo "Confira PROJECT_NUMBER, START_FIELD e END_FIELD (Settings → Fields no projeto)."
    exit 1
  fi
fi

# ---------------------------- MILESTONES ------------------------------
echo "== Criando milestones =="
for item in "${MILESTONES[@]}"; do
  IFS='|' read -r title due <<< "$item"
  echo "  - $title (até $(iso "$due"))"
  if [[ "$DRY_RUN" != "1" ]]; then
    gh api "repos/$REPO/milestones" \
      -f title="$title" \
      -f due_on="$(iso "$due")T23:59:59Z" \
      --silent || echo "    (já existe ou falhou, seguindo)"
  fi
done

# ------------------------------ ISSUES --------------------------------
echo "== Criando issues e preenchendo datas =="
while IFS='|' read -r -u 3 milestone title start end done_flag; do
  [[ -z "$milestone" ]] && continue
  echo "  - [$milestone] $title ($(iso "$start") → $(iso "$end"))"
  [[ "$DRY_RUN" == "1" ]] && continue

  url=$(gh issue create --repo "$REPO" \
    --title "$title" \
    --body "Fase: $milestone" \
    --milestone "$milestone" </dev/null)

  item_id=$(gh project item-add "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" \
    --url "$url" --format json --jq '.id' </dev/null)

  gh project item-edit --id "$item_id" --project-id "$PROJECT_ID" \
    --field-id "$START_ID" --date "$(iso "$start")" >/dev/null </dev/null
  gh project item-edit --id "$item_id" --project-id "$PROJECT_ID" \
    --field-id "$END_ID" --date "$(iso "$end")" >/dev/null </dev/null

  if [[ "${done_flag:-}" == "x" ]]; then
    gh issue close "$url" --reason completed >/dev/null </dev/null
  fi
done 3<<< "$TASKS"

echo "Pronto! Abra o projeto no GitHub e use a view Roadmap."
