# Case 01: Central de Atendimento Financeiro

## Propósito do case

Colocar você diante de um problema real de operação bancária onde existe uso intensivo de atendimento ao cliente, falta de controle de processo e ausência de visibilidade gerencial.

O objetivo não é reproduzir um módulo pronto. É te fazer pensar como alguém que precisa transformar uma operação desorganizada em uma solução consistente dentro do ecossistema Dynamics.

---

## Enunciado

O Banco Ricardo opera uma central de atendimento ao cliente com cerca de 15 atendentes na linha de frente. Os clientes entram em contato via telefone ou e-mail e os atendentes abrem chamados manualmente. Em alguns casos o próprio sistema pode identificar uma falha ou risco na conta do cliente e o atendente abre um chamado de forma proativa.

O processo atual é completamente desorganizado. Os chamados são controlados em planilhas pessoais e o gestor só tem visibilidade do dia anterior (D+1). Não existe controle de prazo, os analistas controlam os vencimentos em post-its. O roteamento entre times é feito por e-mail. Não há histórico confiável nem rastreabilidade de quem alterou o quê.

O banco quer uma solução em Dynamics que centralize os canais de entrada, organize as filas automaticamente, controle prazos legais e entregue visibilidade em tempo real para a gestão.

---

## Estrutura organizacional

A operação funciona em três níveis:

**Nível 1 — Atendimento geral**
Linha de frente com aproximadamente 15 atendentes. Resolvem dúvidas simples como segunda via de cartão e informações gerais. Recebem chamados por telefone e e-mail.

**Nível 2 — Especialistas por área**
Analistas especializados em cartões, investimentos, conta corrente e crédito. Recebem chamados escalados do Nível 1 que exigem conhecimento técnico da área.

**Nível 3 — Especialistas sênior e jurídico**
Atuam em casos que chegam ao Banco Central, reclamações formais e situações jurídicas. Nível mais crítico da operação.

Cada nível tem um coordenador responsável pela gestão da equipe.

---

## Perfis e permissões

| Perfil | Acesso |
|---|---|
| Atendente / Analista / Especialista | Edita apenas os próprios chamados atribuídos |
| Coordenador | Edita e visualiza todos os chamados do seu nível e equipe |
| Carla (supervisora operacional) | Edita qualquer chamado, pode escalar e intervir |
| Ricardo (gestor geral) | Visualiza tudo, não edita, gera relatórios |

---

## Dores levantadas

- Sem visibilidade em tempo real — gestão opera com dados do dia anterior
- Sem controle de SLA — prazos vivem em post-its e planilhas pessoais
- Roteamento manual por e-mail — chamados chegam no time errado ou se perdem
- Sem histórico confiável — não se sabe quem alterou o quê
- Atendentes perdem tempo perguntando para colegas como resolver casos
- Sem pesquisa de satisfação do cliente após atendimento

---

## Requisitos funcionais

### Chamados
- Abertura manual pelo atendente (via contato do cliente) ou automática (via detecção de falha)
- Tipos: reclamação, solicitação, dúvida, cancelamento
- Subcategorias: cartão, investimento, conta corrente, crédito
- Roteamento automático para o nível e time correto sem intervenção manual

### Prazos e SLA
- Controle do prazo legal de 10 dias úteis exigido pelo Banco Central
- Alertas automáticos de vencimento de prazo
- Notificação automática para Ricardo em casos jurídicos ou do Banco Central

### Gestão e visibilidade
- Dashboard por nível para coordenadores (enxerga apenas o próprio nível e equipe)
- Dashboard unificado para Ricardo e Carla com filtros por nível, time, tipo de demanda e período
- Visibilidade em tempo real (eliminar o D+1)

### Base de conhecimento
- Artigos, procedimentos e scripts de atendimento consultáveis durante o próprio atendimento

### Auditoria
- Registro de todas as alterações: quem alterou, o quê e quando

### Pesquisa de satisfação
- Envio de pesquisa ao cliente após encerramento do chamado

---

## Restrições

- Dynamics como plataforma principal
- Solução pensada para model-driven app
- Canais de entrada na primeira versão: telefone e e-mail
- WhatsApp e autoatendimento do cliente (Power Pages) ficam para versões futuras
- Necessário suportar de 300 a 800 chamados por dia
- Migração de dados históricos do sistema legado a ser avaliada
- LGPD nos dados dos clientes
- Prazo de entrega: 6 meses

---

## O que este case quer te ensinar

1. **Modelagem** — separar dado mestre, transacional, histórico e configuração em um contexto bancário real
2. **Arquitetura de regra** — decidir quando usar Business Rule, Power Automate ou Plugin para cada regra levantada
3. **Segurança** — implementar controle de acesso por nível hierárquico real
4. **Processo operacional** — pensar como atendente, coordenador e gestor ao mesmo tempo
5. **Evolução controlada** — entregar uma primeira versão funcional sem fechar portas para as evoluções mapeadas

---

## Perguntas-guia

### Sobre modelagem
- O chamado é o registro central ou existe algo mais relevante orbitando em torno dele?
- O que precisa de histórico próprio além do chamado em si?
- O que é configurável sem deploy (tipos, subcategorias, SLAs)?

### Sobre regras
- O roteamento automático depende de quê exatamente — tipo, subcategoria, nível, disponibilidade?
- A regra de prazo precisa bloquear ou só alertar?
- A notificação do Ricardo é síncrona ou pode ser assíncrona?

### Sobre segurança
- O que o coordenador pode fazer que o atendente não pode?
- Como garantir que Carla pode intervir sem precisar ser administradora do sistema?
- O Ricardo não editar é orientação de tela ou restrição real?

### Sobre experiência
- Como o atendente sabe para qual nível escalar sem precisar perguntar para alguém?
- Como o coordenador identifica picos de atendimento hoje, em tempo real?
- Como a base de conhecimento aparece no contexto do chamado sem atrapalhar o fluxo?

---

## Ordem sugerida de implementação

1. Entendimento funcional — diagramas, atores, fluxo, modelo conceitual
2. Modelagem das entidades no Dataverse
3. Experiência operacional mínima — abertura, consulta e encerramento de chamado
4. Roteamento automático entre níveis
5. Controle de SLA e alertas
6. Segurança por perfil
7. Dashboards de gestão
8. Base de conhecimento
9. Pesquisa de satisfação e auditoria
10. Refinamento e preparação para evoluções futuras
