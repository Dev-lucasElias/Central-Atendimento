# ADR — Architecture Decision Records

Registro das decisões arquiteturais relevantes da Central de Atendimento.

---

## ADR-001 — Validação de campos obrigatórios via Business Rule Entity

**Contexto:** Chamados precisam nascer com cliente, tipo e subcategoria preenchidos, independente da origem da inserção.

**Decisão:** Business Rule com escopo Entity.

**Consequências:**
- Bloqueia formulário, Web API e Power Automate
- Não bloqueia inserções via Plugin C# — migrar para Plugin PreValidation se surgir essa necessidade
- Mais simples de manter que um plugin para esse caso

---

## ADR-002 — Vínculo de artigo ao chamado via Plugin PreOperation

**Contexto:** Ao abrir um chamado, o sistema deve buscar e vincular automaticamente o artigo correspondente à categoria e subcategoria informadas.

**Decisão:** Plugin C# PreOperation no evento Create do Chamado.

**Consequências:**
- Executa após a validação (PreValidation) e antes de salvar
- Artigo já está vinculado no momento da criação do registro
- Depende que a base de artigos esteja populada e categorizada corretamente

---

## ADR-003 — Cálculo de data limite com base no SLA via Plugin PreOperation

**Contexto:** Todo chamado precisa ter uma data limite calculada com base no tipo e no prazo configurado na entidade ConfiguracaoSLA.

**Decisão:** Plugin C# PreOperation no evento Create do Chamado.

**Consequências:**
- Garante atomicidade — chamado nasce com data limite preenchida
- PostOperation foi descartado pois o registro existiria por um instante sem data limite, risco de inconsistência em caso de erro
- Depende que ConfiguracaoSLA esteja populada para o tipo do chamado

---

## ADR-004 — Roteamento automático via Plugin PreOperation

**Contexto:** O chamado deve ser atribuído automaticamente ao nível e fila corretos com base em tipo e subcategoria, sem intervenção manual.

**Decisão:** Plugin C# PreOperation no evento Create do Chamado.

**Consequências:**
- Campo de nível e fila preenchidos antes de salvar
- Substitui o processo manual de roteamento por e-mail
- Lógica de roteamento deve ser parametrizável para suportar mudanças sem redeploy

---

## ADR-005 — Auditoria de alterações via Plugin PostOperation

**Contexto:** Toda alteração em um chamado deve ser registrada com campo alterado, valor anterior, valor novo, usuário e timestamp.

**Decisão:** Plugin C# PostOperation no evento Update do Chamado.

**Consequências:**
- Executa em toda alteração independente da origem
- Power Automate foi descartado por não garantir confiabilidade e atomicidade suficientes para auditoria
- PostOperation é adequado aqui pois o registro do log não precisa bloquear a operação principal

---

## ADR-006 — Notificações via Power Automate

**Contexto:** Diversas situações exigem notificação: atribuição de chamado, escalonamento, vencimento de SLA, casos jurídicos e encerramento.

**Decisão:** Power Automate para todas as notificações.

**Consequências:**
- Notificações são consequências de eventos, não parte das operações — falha no envio não deve desfazer a operação
- Trigger por mudança de campo (atribuição, status, nível) ou recorrência (SLA)
- Desacoplado da lógica de negócio principal

---

## ADR-007 — Pesquisa de satisfação disparada via Power Automate

**Contexto:** Ao encerrar um chamado, o cliente deve receber automaticamente uma pesquisa de satisfação.

**Decisão:** Power Automate com trigger no update do status para encerrado.

**Consequências:**
- Plugin PostOperation foi descartado pois falha no envio não deve desfazer o encerramento
- Pesquisa é uma ação consequente e independente do encerramento
- Entidade PesquisaSatisfacao separada permite evolução futura com análise de sentimento via IA
