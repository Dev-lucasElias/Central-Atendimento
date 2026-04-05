#!/usr/bin/env bash
# Cria labels, milestones e issues da Central de Atendimento no GitHub Projects.
# Pré-requisito: gh auth login executado e repo já existente.

set -euo pipefail

REPO="Dev-lucasElias/Central-Atendimento"
OWNER="@me"
PROJECT_NUMBER=2

# ──────────────────────────────────────────────────────────────
# 1. Labels
# ──────────────────────────────────────────────────────────────
echo "==> Criando labels..."

gh label create "case-01"          --color "0e8a16" --description "Case 01: Central de Atendimento Financeiro"   --repo "$REPO" --force
gh label create "modelagem"        --color "e4c513" --description "Decisões de estrutura de dados"               --repo "$REPO" --force
gh label create "regra-de-negocio" --color "d73a4a" --description "Regras de negócio a implementar"             --repo "$REPO" --force
gh label create "plugin"           --color "7057ff" --description "Código C# no Dataverse"                       --repo "$REPO" --force
gh label create "automacao"        --color "e99695" --description "Power Automate / fluxos declarativos"         --repo "$REPO" --force
gh label create "seguranca"        --color "6b6b6b" --description "Controle de permissões e papéis"             --repo "$REPO" --force
gh label create "ux"               --color "0075ca" --description "Experiência operacional, views e formulários" --repo "$REPO" --force
gh label create "extensao"         --color "a2eeef" --description "Melhorias pós-v1"                             --repo "$REPO" --force
gh label create "engenharia"       --color "f9d0c4" --description "Diagramas, arquitetura e decisões técnicas"   --repo "$REPO" --force

# ──────────────────────────────────────────────────────────────
# 2. Milestones
# ──────────────────────────────────────────────────────────────
echo "==> Criando milestones..."

create_milestone() {
  gh api "repos/$REPO/milestones" --method POST \
    --field title="$1" \
    --field description="$2" \
    --jq '.number'
}

create_milestone "Etapa 1 — Engenharia e Projeto"           "Diagramas, modelagem conceitual, arquitetura de solução e decisões técnicas iniciais."
create_milestone "Etapa 2 — Modelagem no Dataverse"         "Criar entidades, campos, relacionamentos e configurações no Dataverse."
create_milestone "Etapa 3 — Experiência Operacional Mínima" "Abertura, consulta, roteamento e encerramento de chamados funcionando."
create_milestone "Etapa 4 — Regras de Integridade"          "Validações, SLA, auditoria e regras de negócio protegidas no servidor."
create_milestone "Etapa 5 — Segurança"                      "Controle de acesso por perfil: atendente, coordenador, Carla e Ricardo."
create_milestone "Etapa 6 — Dashboards e Visibilidade"      "Dashboards por nível, dashboard gerencial e indicadores em tempo real."
create_milestone "Etapa 7 — Refinamento"                    "Naming, consistência, qualidade de views e preparação para evoluções."
create_milestone "Extensões"                                "Melhorias pós-v1: WhatsApp, Power Pages, IA na pesquisa de satisfação."

echo "  Milestones criadas."

# ──────────────────────────────────────────────────────────────
# 3. Issues
# ──────────────────────────────────────────────────────────────
echo "==> Criando issues..."

add_issue() {
  local url
  url=$(gh issue create --repo "$REPO" "$@")
  echo "    criada: $url"
  gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "$url"
}

# ── Etapa 1 — Engenharia e Projeto ──
add_issue \
  --title "[Etapa 1] Diagrama de casos de uso" \
  --body "Mapear atores e casos de uso do sistema. Arquivo: cases/diagramas/casosDeUso.puml" \
  --milestone "Etapa 1 — Engenharia e Projeto" \
  --label "case-01,engenharia"

add_issue \
  --title "[Etapa 1] Diagrama de entidades" \
  --body "Modelar entidades, campos e relacionamentos em nível conceitual. Arquivo: cases/diagramas/entidades.puml" \
  --milestone "Etapa 1 — Engenharia e Projeto" \
  --label "case-01,engenharia,modelagem"

add_issue \
  --title "[Etapa 1] Diagrama de sequência — ciclo de vida do chamado" \
  --body "Mapear o fluxo completo de um chamado do registro ao encerramento, incluindo escalonamentos." \
  --milestone "Etapa 1 — Engenharia e Projeto" \
  --label "case-01,engenharia"

add_issue \
  --title "[Etapa 1] Definir arquitetura de solução" \
  --body "Mapear cada regra de negócio para: Business Rule, Power Automate ou Plugin C#. Justificar tecnicamente." \
  --milestone "Etapa 1 — Engenharia e Projeto" \
  --label "case-01,engenharia"

add_issue \
  --title "[Etapa 1] Documentar decisões técnicas (ADR)" \
  --body "Registrar decisões arquiteturais relevantes no formato ADR em docs/adr/." \
  --milestone "Etapa 1 — Engenharia e Projeto" \
  --label "case-01,engenharia"

# ── Etapa 2 — Modelagem no Dataverse ──
add_issue \
  --title "[Etapa 2] Criar entidade Chamado" \
  --body "Criar tabela Chamado com campos: título, tipo, subcategoria, status, data abertura, data limite." \
  --milestone "Etapa 2 — Modelagem no Dataverse" \
  --label "case-01,modelagem"

add_issue \
  --title "[Etapa 2] Criar entidade Cliente" \
  --body "Criar tabela Cliente com campos: nome, CPF, e-mail, telefone. Relacionar com Chamado." \
  --milestone "Etapa 2 — Modelagem no Dataverse" \
  --label "case-01,modelagem"

add_issue \
  --title "[Etapa 2] Criar entidade ConfiguracaoSLA" \
  --body "Criar tabela ConfiguracaoSLA com tipo de chamado e prazo em dias úteis. Deve ser configurável sem deploy." \
  --milestone "Etapa 2 — Modelagem no Dataverse" \
  --label "case-01,modelagem"

add_issue \
  --title "[Etapa 2] Criar entidade Artigo (base de conhecimento)" \
  --body "Criar tabela Artigo com título, conteúdo, categoria e subcategoria para vínculo automático ao chamado." \
  --milestone "Etapa 2 — Modelagem no Dataverse" \
  --label "case-01,modelagem"

add_issue \
  --title "[Etapa 2] Criar entidade LogAuditoria" \
  --body "Criar tabela LogAuditoria com campo alterado, valor anterior, valor novo, data/hora e usuário." \
  --milestone "Etapa 2 — Modelagem no Dataverse" \
  --label "case-01,modelagem"

add_issue \
  --title "[Etapa 2] Criar entidade PesquisaSatisfacao" \
  --body "Criar tabela PesquisaSatisfacao com nota e texto avaliativo. Relacionar 1:1 com Chamado." \
  --milestone "Etapa 2 — Modelagem no Dataverse" \
  --label "case-01,modelagem"

# ── Etapa 3 — Experiência Operacional Mínima ──
add_issue \
  --title "[Etapa 3] Abertura manual de chamado pelo atendente" \
  --body "Formulário de abertura com campos obrigatórios: cliente, tipo, subcategoria e descrição." \
  --milestone "Etapa 3 — Experiência Operacional Mínima" \
  --label "case-01,ux"

add_issue \
  --title "[Etapa 3] Roteamento automático de chamados por nível" \
  --body "Rotear chamado automaticamente para o time correto com base em tipo e subcategoria, sem intervenção manual." \
  --milestone "Etapa 3 — Experiência Operacional Mínima" \
  --label "case-01,automacao"

add_issue \
  --title "[Etapa 3] Vínculo automático de artigo ao chamado via plugin" \
  --body "Plugin PreOperation que busca artigo por categoria/subcategoria e vincula ao chamado na abertura." \
  --milestone "Etapa 3 — Experiência Operacional Mínima" \
  --label "case-01,plugin"

add_issue \
  --title "[Etapa 3] Consulta de chamados por atendente" \
  --body "View de chamados atribuídos ao atendente logado com filtros de status e tipo." \
  --milestone "Etapa 3 — Experiência Operacional Mínima" \
  --label "case-01,ux"

add_issue \
  --title "[Etapa 3] Encerramento de chamado com rastreabilidade" \
  --body "Impedir encerramento sem motivo e contexto registrados. Disparar pesquisa de satisfação ao encerrar." \
  --milestone "Etapa 3 — Experiência Operacional Mínima" \
  --label "case-01,regra-de-negocio,plugin"

# ── Etapa 4 — Regras de Integridade ──
add_issue \
  --title "[Etapa 4] Validar dados mínimos na abertura do chamado" \
  --body "Plugin PreValidation garantindo que cliente, tipo e subcategoria estejam preenchidos mesmo fora do formulário." \
  --milestone "Etapa 4 — Regras de Integridade" \
  --label "case-01,regra-de-negocio,plugin"

add_issue \
  --title "[Etapa 4] Calcular data limite com base no SLA" \
  --body "Ao abrir chamado, buscar ConfiguracaoSLA pelo tipo e calcular data limite em dias úteis." \
  --milestone "Etapa 4 — Regras de Integridade" \
  --label "case-01,regra-de-negocio,automacao"

add_issue \
  --title "[Etapa 4] Alertar vencimento de SLA" \
  --body "Notificar atendente e coordenador quando chamado estiver próximo ou com prazo vencido." \
  --milestone "Etapa 4 — Regras de Integridade" \
  --label "case-01,regra-de-negocio,automacao"

add_issue \
  --title "[Etapa 4] Registrar log de auditoria em alterações" \
  --body "Plugin PostOperation registrando campo alterado, valor anterior, valor novo, usuário e timestamp." \
  --milestone "Etapa 4 — Regras de Integridade" \
  --label "case-01,regra-de-negocio,plugin"

add_issue \
  --title "[Etapa 4] Notificar Ricardo em casos jurídicos ou do Banco Central" \
  --body "Disparar notificação automática para Ricardo quando chamado for escalado para Nível 3." \
  --milestone "Etapa 4 — Regras de Integridade" \
  --label "case-01,regra-de-negocio,automacao"

# ── Etapa 5 — Segurança ──
add_issue \
  --title "[Etapa 5] Controle de acesso por perfil" \
  --body "Configurar papéis: atendente edita próprios chamados, coordenador edita o nível, Carla edita tudo, Ricardo só visualiza." \
  --milestone "Etapa 5 — Segurança" \
  --label "case-01,seguranca"

add_issue \
  --title "[Etapa 5] Coordenador enxerga apenas o próprio nível e equipe" \
  --body "Configurar visibilidade via Business Unit ou security roles para isolar cada nível." \
  --milestone "Etapa 5 — Segurança" \
  --label "case-01,seguranca"

# ── Etapa 6 — Dashboards e Visibilidade ──
add_issue \
  --title "[Etapa 6] Dashboard do coordenador por nível" \
  --body "Chamados abertos, em andamento, próximos do vencimento e encerrados da própria equipe em tempo real." \
  --milestone "Etapa 6 — Dashboards e Visibilidade" \
  --label "case-01,ux"

add_issue \
  --title "[Etapa 6] Dashboard gerencial para Ricardo e Carla" \
  --body "Visão consolidada com filtros por nível, time, tipo de demanda e período." \
  --milestone "Etapa 6 — Dashboards e Visibilidade" \
  --label "case-01,ux"

# ── Extensões ──
add_issue \
  --title "[Ext] Integração com WhatsApp" \
  --body "Centralizar canal WhatsApp como entrada de chamados junto ao telefone e e-mail." \
  --milestone "Extensões" \
  --label "case-01,extensao"

add_issue \
  --title "[Ext] Portal de autoatendimento via Power Pages" \
  --body "Permitir que o cliente abra chamados diretamente sem passar pelo atendente." \
  --milestone "Extensões" \
  --label "case-01,extensao"

add_issue \
  --title "[Ext] Análise de humor na pesquisa de satisfação com IA" \
  --body "Usar IA para classificar o sentimento do texto avaliativo da pesquisa de satisfação." \
  --milestone "Extensões" \
  --label "case-01,extensao"

add_issue \
  --title "[Ext] Migração de dados históricos do sistema legado" \
  --body "Avaliar complexidade e executar migração dos chamados históricos para o Dataverse." \
  --milestone "Extensões" \
  --label "case-01,extensao"

echo ""
echo "Concluído. Acesse: https://github.com/users/Dev-lucasElias/projects/2/views/1"
