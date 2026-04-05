# Business Rule — Escopos e Poder de Restrição

Business Rule pode ser configurada em dois escopos no Maker Portal (tabela → Business rules → Scope):

**Escopo Form** — roda apenas no browser, no formulário. Serve para guiar o usuário na tela: mostrar/ocultar campos, obrigatoriedade condicional, valores padrão. Não protege o dado.

**Escopo Entity** — roda no servidor. Protege o dado independente de onde ele vier, exceto quando a origem é um Plugin C#.

## Tabela comparativa de restrição

| Origem da operação | Business Rule (Form) | Business Rule (Entity) | Plugin PreValidation |
|---|---|---|---|
| Usuário no formulário | ✅ bloqueia | ✅ bloqueia | ✅ bloqueia |
| Web API / integração externa | ❌ não bloqueia | ✅ bloqueia | ✅ bloqueia |
| Power Automate | ❌ não bloqueia | ✅ bloqueia | ✅ bloqueia |
| Custom Action | ❌ não bloqueia | ✅ bloqueia | ✅ bloqueia |
| Plugin C# | ❌ não bloqueia | ❌ não bloqueia | ✅ bloqueia |
| Importação em massa | ❌ não bloqueia | ⚠️ depende do modo | ✅ bloqueia |

## Regra prática

- Regra de UX → Business Rule Form
- Proteger contra API e automações → Business Rule Entity
- Proteger contra tudo, incluindo plugins → Plugin PreValidation
