#!/usr/bin/env bash
# Cria labels, milestones e issues do Case 01 no GitHub Projects.
# Pré-requisito: gh auth login executado e repo já existente.

set -euo pipefail

REPO="Dev-lucasElias/Central-Atendimento"
OWNER="@me"
PROJECT_NUMBER=2

# ──────────────────────────────────────────────────────────────
# 1. Labels
# ──────────────────────────────────────────────────────────────
echo "==> Criando labels..."

gh label create "case-01"           --color "0e8a16" --description "Case 01: Central de Atendimento Financeiro"         --repo "$REPO" --force
gh label create "modelagem"         --color "e4c513" --description "Decisões de estrutura de dados"                     --repo "$REPO" --force
gh label create "regra-de-negocio"  --color "d73a4a" --description "Regras de negócio a implementar"                   --repo "$REPO" --force
gh label create "plugin"            --color "7057ff" --description "Código C# no Dataverse"                             --repo "$REPO" --force
gh label create "automacao"         --color "e99695" --description "Power Automate / fluxos declarativos"               --repo "$REPO" --force
gh label create "seguranca"         --color "6b6b6b" --description "Controle de permissões e papéis"                   --repo "$REPO" --force
gh label create "ux"                --color "0075ca" --description "Experiência operacional, views e formulários"       --repo "$REPO" --force
gh label create "extensao"          --color "a2eeef" --description "Melhorias pós-v1"                                   --repo "$REPO" --force

# ──────────────────────────────────────────────────────────────
# 2. Milestones
# ──────────────────────────────────────────────────────────────
echo "==> Verificando/criando milestones..."

create_milestone_if_missing() {
  local title="$1" desc="$2"
  local exists
  exists=$(gh api "repos/$REPO/milestones" --jq ".[] | select(.title==\"$title\") | .number" 2>/dev/null)
  if [ -z "$exists" ]; then
    gh api "repos/$REPO/milestones" --method POST \
      --field title="$title" \
      --field description="$desc" \
      --jq '.number'
  else
    echo "$exists"
  fi
}

MS1=$(create_milestone_if_missing "Etapa 1 — Entendimento Funcional" "Responder por escrito: problema, atores, eventos e critérios de sucesso antes de modelar.")
MS2=$(create_milestone_if_missing "Etapa 2 — Proposta de Modelo" "Definir entidades, relacionamentos e dados obrigatórios em nível conceitual.")
MS3=$(create_milestone_if_missing "Etapa 3 — Experiência Operacional Mínima" "Primeira versão utilizável: registro, localização, priorização e visibilidade de atrasos.")
MS4=$(create_milestone_if_missing "Etapa 4 — Regras de Integridade" "Identificar quais regras protegem dado, bloqueiam operação ou podem ser assíncronas.")
MS5=$(create_milestone_if_missing "Etapa 5 — Segurança" "Definir quem cria, altera, redistribui, encerra e administra configurações.")
MS6=$(create_milestone_if_missing "Etapa 6 — Refinamento" "Revisar naming, consistência de status, qualidade de views e acoplamento.")
MS7=$(create_milestone_if_missing "Extensões" "Melhorias pós-v1: escalonamento, reabertura, classificação automática, indicadores e integrações.")

# Títulos para uso no gh issue create (--milestone aceita nome)
T1="Etapa 1 — Entendimento Funcional"
T2="Etapa 2 — Proposta de Modelo"
T3="Etapa 3 — Experiência Operacional Mínima"
T4="Etapa 4 — Regras de Integridade"
T5="Etapa 5 — Segurança"
T6="Etapa 6 — Refinamento"
T7="Extensões"

echo "  Milestones prontas: $MS1 $MS2 $MS3 $MS4 $MS5 $MS6 $MS7"

# ──────────────────────────────────────────────────────────────
# 3. Issues + adicionar ao project
# ──────────────────────────────────────────────────────────────
echo "==> Criando issues..."

add_issue() {
  local url
  url=$(gh issue create --repo "$REPO" "$@")
  echo "    criada: $url"
  gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "$url"
}

# --- Regra 1 ---
add_issue \
  --title "[Regra 1] Validar dados mínimos na abertura da solicitação" \
  --body "## Contexto
Uma solicitação não pode nascer sem informações mínimas que a tornem tratável operacionalmente.

## O que decidir
- Quais dados são realmente mínimos
- Onde essa validação deve acontecer (formulário, regra declarativa ou plugin)
- Como garantir que a regra continue válida mesmo fora do formulário principal

**Referência:** Case 01 — Regra 1" \
  --milestone "$T4" \
  --label "case-01,regra-de-negocio,plugin"

# --- Regra 2 ---
add_issue \
  --title "[Regra 2] Classificação obrigatória e consistente da solicitação" \
  --body "## Contexto
Toda solicitação precisa possuir classificação suficiente para priorização e tratamento.

## O que decidir
- Quais conceitos de classificação existem no processo
- Quais são obrigatórios na abertura e quais podem surgir depois
- Como evitar classificação pobre ou inconsistente

**Referência:** Case 01 — Regra 2" \
  --milestone "$T2" \
  --label "case-01,regra-de-negocio,modelagem"

# --- Regra 3 ---
add_issue \
  --title "[Regra 3] Diferenciar atendimento simples vs. especializado" \
  --body "## Contexto
A solução deve permitir diferenciar atendimentos simples de atendimentos que exigem tratativa especializada.

## O que decidir
- Quais sinais determinam essa diferenciação
- Como isso impacta atribuição, filas, responsáveis ou status
- Se essa regra é puramente de processo ou também de segurança

**Referência:** Case 01 — Regra 3" \
  --milestone "$T3" \
  --label "case-01,regra-de-negocio"

# --- Regra 4 ---
add_issue \
  --title "[Regra 4] Criticidade determina prazo de atendimento" \
  --body "## Contexto
Solicitações com maior criticidade devem receber tratamento mais rápido que as demais.

## O que decidir
- Como a criticidade é determinada (informada, calculada ou combinada)
- Como o prazo deve responder à criticidade
- Onde essa lógica deve viver

**Referência:** Case 01 — Regra 4" \
  --milestone "$T4" \
  --label "case-01,regra-de-negocio,automacao"

# --- Regra 5 ---
add_issue \
  --title "[Regra 5] Rastreabilidade obrigatória no encerramento" \
  --body "## Contexto
Não deve ser possível encerrar uma solicitação sem rastreabilidade suficiente sobre o motivo e o contexto do encerramento.

## O que decidir
- O que significa rastreabilidade suficiente
- Quais dados passam a ser obrigatórios no encerramento
- Como impedir encerramentos inconsistentes

**Referência:** Case 01 — Regra 5" \
  --milestone "$T4" \
  --label "case-01,regra-de-negocio,plugin"

# --- Regra 6 ---
add_issue \
  --title "[Regra 6] Visibilidade de atrasos e gargalos para supervisão" \
  --body "## Contexto
A supervisão precisa conseguir identificar rapidamente o que está atrasado, parado ou mal distribuído.

## O que decidir
- Quais sinais indicam atraso ou gargalo
- Como expor isso operacionalmente
- Quais informações precisam estar visíveis sem consulta manual complexa

**Referência:** Case 01 — Regra 6" \
  --milestone "$T3" \
  --label "case-01,regra-de-negocio,ux"

# --- Regra 7 ---
add_issue \
  --title "[Regra 7] Auditoria de mudanças no ciclo de vida da solicitação" \
  --body "## Contexto
Mudanças relevantes no ciclo de vida da solicitação devem ser auditáveis do ponto de vista operacional.

## O que decidir
- O que conta como mudança relevante
- Qual nível de histórico faz sentido
- Se o histórico será apenas técnico ou operacionalmente útil

**Referência:** Case 01 — Regra 7" \
  --milestone "$T4" \
  --label "case-01,regra-de-negocio,plugin"

# --- Regra 8 ---
add_issue \
  --title "[Regra 8] Controle de permissões por perfil de usuário" \
  --body "## Contexto
Nem todo usuário deve poder executar todas as ações sobre uma solicitação.

## O que decidir
- Quais perfis existem
- Quais operações exigem nível maior de controle
- O que deve ser controlado por segurança real vs. orientação de tela

**Referência:** Case 01 — Regra 8" \
  --milestone "$T5" \
  --label "case-01,regra-de-negocio,seguranca"

# --- Extensão 1 ---
add_issue \
  --title "[Ext 1] Escalonamento automático por inatividade" \
  --body "## Contexto
Criar uma lógica de escalonamento para itens que ficaram tempo demais sem andamento.

**Referência:** Case 01 — Extensão 1" \
  --milestone "$T7" \
  --label "case-01,extensao,automacao"

# --- Extensão 2 ---
add_issue \
  --title "[Ext 2] Reabertura controlada de itens encerrados" \
  --body "## Contexto
Permitir reabertura controlada de itens encerrados.

**Referência:** Case 01 — Extensão 2" \
  --milestone "$T7" \
  --label "case-01,extensao,regra-de-negocio"

# --- Extensão 3 ---
add_issue \
  --title "[Ext 3] Classificação automática ou semi-automatizada" \
  --body "## Contexto
Criar um mecanismo de classificação automática ou semi-automatizada.

**Referência:** Case 01 — Extensão 3" \
  --milestone "$T7" \
  --label "case-01,extensao,automacao"

# --- Extensão 4 ---
add_issue \
  --title "[Ext 4] Indicadores operacionais para supervisão" \
  --body "## Contexto
Criar indicadores operacionais para supervisão.

**Referência:** Case 01 — Extensão 4" \
  --milestone "$T7" \
  --label "case-01,extensao,ux"

# --- Extensão 5 ---
add_issue \
  --title "[Ext 5] Simulação de dependência externa sem acoplamento" \
  --body "## Contexto
Adicionar algum tipo de simulação de dependência externa sem acoplar a primeira versão a uma integração real.

**Referência:** Case 01 — Extensão 5" \
  --milestone "$T7" \
  --label "case-01,extensao"

echo ""
echo "Concluído. Acesse: https://github.com/users/Dev-lucasElias/projects/2/views/1"
