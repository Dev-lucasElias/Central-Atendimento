# Documento de Requisitos — Central de Atendimento Financeiro

**Cliente:** Banco Ricardo
**Gestor responsável:** Ricardo
**Supervisora operacional:** Carla
**Plataforma:** Microsoft Dynamics 365 / Dataverse
**Prazo:** 6 meses

---

## 1. Contexto

O banco opera uma central de atendimento com múltiplos canais e três níveis hierárquicos de atendimento. O processo atual é manual, descentralizado e sem visibilidade gerencial em tempo real. Os chamados são controlados em planilhas, o roteamento é feito por e-mail e os prazos legais são monitorados individualmente por cada analista.

---

## 2. Objetivos

- Centralizar os canais de entrada no Dynamics
- Automatizar o roteamento de chamados para o time correto
- Controlar prazos legais com alertas automáticos
- Entregar visibilidade em tempo real para coordenadores e gestão
- Registrar histórico completo e auditável de cada chamado

---

## 3. Canais de entrada

| Canal | Status |
|---|---|
| Telefone | Fase 1 |
| E-mail | Fase 1 |
| WhatsApp | Fase futura |
| Autoatendimento (Power Pages) | Fase futura |

### Origem dos chamados

- **Reativa:** cliente entra em contato e o atendente abre o chamado
- **Proativa:** sistema identifica falha ou risco na conta e abre chamado automaticamente

---

## 4. Estrutura organizacional

### Nível 1 — Atendimento Geral
- ~15 atendentes
- Resolve dúvidas simples (segunda via, informações gerais)
- Ponto de entrada de todos os chamados

### Nível 2 — Especialistas por Área
- Analistas de cartões, investimentos, conta corrente e crédito
- Recebem chamados escalados do Nível 1

### Nível 3 — Especialistas Sênior / Jurídico
- Atuam em casos com Banco Central e situações jurídicas
- Nível mais crítico

---

## 5. Perfis e permissões

| Perfil | Visualiza | Edita | Relatórios | Observação |
|---|---|---|---|---|
| Atendente / Analista / Especialista | Próprios chamados | Próprios chamados | Não | — |
| Coordenador | Chamados do seu nível e equipe | Chamados do seu nível e equipe | Não | Não enxerga outros níveis |
| Carla | Todos os níveis | Todos os chamados | Não | Pode escalar e intervir |
| Ricardo | Todos os níveis | Não edita | Sim | Notificado automaticamente em casos críticos |

---

## 6. Chamados

### 6.1 Tipos
- Reclamação
- Solicitação
- Dúvida
- Cancelamento

### 6.2 Subcategorias
- Cartão
- Investimento
- Conta corrente
- Crédito

### 6.3 Roteamento
- Automático com base no tipo e subcategoria do chamado
- Sem intervenção manual, sem e-mail

---

## 7. SLA e prazos

- Prazo legal do Banco Central: **10 dias úteis**
- Alertas automáticos de vencimento de prazo
- Notificação automática para Ricardo em casos jurídicos ou envolvendo Banco Central

---

## 8. Dashboards

### Coordenador (por nível)
- Chamados abertos, em andamento e encerrados da própria equipe
- Chamados próximos do vencimento de SLA
- Visibilidade em tempo real

### Ricardo e Carla (gestão)
- Visão consolidada de todos os níveis
- Filtros: nível, time, tipo de demanda, período
- Indicadores de volume, SLA e distribuição

---

## 9. Base de conhecimento

- Artigos, procedimentos e scripts de atendimento
- Consultável pelo atendente durante o próprio atendimento
- Reduzir dependência de consultas a colegas

---

## 10. Pesquisa de satisfação

- Envio automático ao cliente após encerramento do chamado

---

## 11. Auditoria

- Registro de todas as alterações em chamados
- Campos obrigatórios: quem alterou, o quê foi alterado, data e hora

---

## 12. Requisitos não funcionais

| Requisito | Detalhe |
|---|---|
| Volume | 300 a 800 chamados por dia |
| Privacidade | Conformidade com LGPD nos dados dos clientes |
| Migração | Dados históricos do sistema legado a avaliar complexidade |
| Plataforma | Model-driven app no Dynamics 365 |

---

## 13. Fora do escopo da fase 1

- Integração com WhatsApp
- Portal de autoatendimento para o cliente (Power Pages)
- Integrações externas além dos canais de e-mail e telefone
