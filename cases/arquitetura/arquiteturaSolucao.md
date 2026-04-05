# Arquitetura de Solução — Central de Atendimento

Mapeamento de cada regra de negócio para a tecnologia de implementação no Dynamics 365.

## Legenda

| Tecnologia | Descrição |
|---|---|
| **BR-Form** | Business Rule escopo formulário |
| **BR-Entity** | Business Rule escopo entidade |
| **PA** | Power Automate |
| **Plugin-PreVal** | Plugin C# PreValidation |
| **Plugin-PreOp** | Plugin C# PreOperation |
| **Plugin-PostOp** | Plugin C# PostOperation |
| **Nativo** | Configuração nativa do Dataverse (campo obrigatório, lookup, etc.) |

---

## Mapeamento

| Regra | Tecnologia | Justificativa |
|---|---|---|
| Validar dados mínimos na abertura (cliente, tipo, subcategoria) | BR-Entity | Campos sempre obrigatórios, sem lógica condicional complexa. Migrar para Plugin-PreVal se surgir necessidade de inserção via plugin. |
| Vincular artigo ao chamado por categoria e subcategoria | Plugin-PreOp | Executa após validação, antes de salvar. Garante que o artigo já está vinculado no momento da criação. |
| Calcular data limite com base no SLA | Plugin-PreOp | Garante atomicidade — chamado nasce com data limite preenchida. PostOperation deixaria o registro inconsistente em caso de erro. |
| Alertar vencimento de SLA | PA | Fluxo recorrente que roda diariamente, busca chamados com prazo próximo e dispara notificação. Não depende de interação do usuário. |
| Registrar log de auditoria em alterações | Plugin-PostOp | Executa dentro da transação em toda alteração, independente da origem. Power Automate não garante confiabilidade suficiente para auditoria. |
| Notificar Ricardo em casos jurídicos ou do Banco Central | PA | Notificação disparada por evento (escalonamento para N3). Não precisa de bloqueio ou atomicidade. |
| Roteamento automático do chamado para o nível correto | Plugin-PreOp | Campo de nível e fila preenchidos antes de salvar. Chamado já nasce atribuído corretamente. |
| Impedir encerramento sem motivo registrado | BR-Entity | Validação de campo obrigatório no encerramento. Bloqueia qualquer origem de atualização. |
| Disparar pesquisa de satisfação ao encerrar | PA | Consequência do encerramento, não parte dele. Falha no envio não deve desfazer o encerramento. |
| Notificar atendente e coordenador na atribuição ou escalonamento | PA | Trigger no campo de atribuição do chamado. Notificação é consequência da atribuição, não precisa ser síncrona. |
