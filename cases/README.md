# Case: Central de Atendimento Financeiro

## Proposito do case

Este case foi desenhado para te colocar em um contexto proximo de uma operacao corporativa de atendimento, onde existe uso intensivo da plataforma Dynamics com forte customizacao de processo.

O objetivo nao e reproduzir exatamente um modulo pronto da Microsoft. O objetivo e te fazer pensar como alguem que precisa transformar uma necessidade operacional em uma solucao consistente dentro do ecossistema Dynamics.

Ao final, voce deve conseguir justificar suas decisoes tecnicas com clareza.

---

# Enunciado

Uma instituicao financeira precisa centralizar o tratamento de solicitacoes abertas por clientes em seus canais de atendimento.

Essas solicitacoes podem envolver temas como:

- duvida sobre cobranca
- contestacao
- ajuste de cadastro
- revisao de limite
- reclamacao de atendimento
- solicitacoes operacionais diversas

O processo atual e desorganizado. Ha perda de rastreabilidade, falta de padronizacao, dificuldade para acompanhar atrasos e baixa visibilidade para supervisao.

A empresa quer uma solucao em Dynamics que permita registrar, acompanhar, direcionar e encerrar solicitacoes com controle operacional e historico confiavel.

Voce nao deve assumir que tudo precisa ser resolvido com entidades padrao do produto, nem que tudo deve ser feito com customizacao total. Parte do desafio e decidir o que faz sentido reutilizar e o que faz sentido construir.

---

# Objetivos de negocio

Sua solucao deve permitir que a operacao:

- registre novas solicitacoes de forma padronizada
- identifique quem e o cliente relacionado ao atendimento
- classifique a natureza da demanda
- acompanhe status e prazo
- encaminhe casos para tratamento especializado quando necessario
- preserve historico operacional
- permita supervisao da fila
- reduza encerramentos incorretos

---

# Regras de negocio

## Regra 1

Uma solicitacao nao pode nascer sem informacoes minimas que a tornem tratavel operacionalmente.

### O que voce precisa decidir

- quais dados sao realmente minimos
- onde essa validacao deve acontecer
- como garantir que a regra continue valida mesmo fora do formulario principal

## Regra 2

Toda solicitacao precisa possuir classificacao suficiente para priorizacao e tratamento.

### O que voce precisa decidir

- quais conceitos de classificacao existem no processo
- quais sao obrigatorios na abertura e quais podem surgir depois
- como evitar classificacao pobre ou inconsistente

## Regra 3

A solucao deve permitir diferenciar atendimentos simples de atendimentos que exigem tratativa especializada.

### O que voce precisa decidir

- quais sinais determinam essa diferenciacao
- como isso impacta atribuicao, filas, responsaveis ou status
- se essa regra e puramente de processo ou tambem de seguranca

## Regra 4

Solicitacoes com maior criticidade devem receber tratamento mais rapido que as demais.

### O que voce precisa decidir

- como a criticidade e determinada
- se ela e informada, calculada ou combinada
- como o prazo deve responder a isso
- onde essa logica deve viver

## Regra 5

Nao deve ser possivel encerrar uma solicitacao sem rastreabilidade suficiente sobre o motivo e o contexto do encerramento.

### O que voce precisa decidir

- o que significa rastreabilidade suficiente
- quais dados passam a ser obrigatorios no encerramento
- como impedir encerramentos inconsistentes

## Regra 6

A supervisao precisa conseguir identificar rapidamente o que esta atrasado, parado ou mal distribuido.

### O que voce precisa decidir

- quais sinais indicam atraso ou gargalo
- como expor isso operacionalmente
- quais informacoes precisam estar visiveis sem depender de consulta manual complexa

## Regra 7

Mudancas relevantes no ciclo de vida da solicitacao devem ser auditaveis do ponto de vista operacional.

### O que voce precisa decidir

- o que conta como mudanca relevante
- qual nivel de historico faz sentido
- se o historico sera apenas tecnico ou operacionalmente util

## Regra 8

Nem todo usuario deve poder executar todas as acoes sobre uma solicitacao.

### O que voce precisa decidir

- quais perfis existem
- quais operacoes exigem nivel maior de controle
- o que deve ser controlado por seguranca real e o que pode ser apenas orientacao de tela

---

# Restricoes do desafio

Para fins de estudo, respeite estas restricoes:

- voce deve usar Dynamics como plataforma principal
- a solucao deve ser pensada para model-driven app
- voce pode combinar recursos declarativos e codigo
- voce nao deve comecar por integracoes externas
- voce nao deve depender de PCF para a primeira versao
- voce deve justificar tecnicamente cada escolha relevante

---

# O que este case quer te ensinar

Este case foi desenhado para forcar aprendizado em cinco frentes:

## 1. Modelagem

Voce vai precisar decidir o que representa dado mestre, dado transacional, historico e configuracao.

## 2. Arquitetura de regra

Voce vai precisar decidir quando usar:

- comportamento de formulario
- regra declarativa
- automacao
- plugin

## 3. Processo operacional

Voce vai precisar pensar como um sistema sera usado por atendente, supervisor e administracao, e nao apenas como um conjunto de tabelas.

## 4. Seguranca

Voce vai precisar separar o que e conveniencia de interface do que e controle real de permissao.

## 5. Evolucao controlada

Voce vai precisar construir uma primeira versao coerente sem tentar resolver tudo de uma vez.

---

# Ordem sugerida de implementacao

Esta ordem nao te entrega a resposta. Ela apenas organiza a investigacao.

## Etapa 1: entendimento funcional

Antes de abrir o maker portal, responda por escrito:

- qual e o problema de negocio
- quem sao os atores
- quais eventos importam no processo
- quando uma solicitacao muda de fase
- o que caracteriza sucesso ou falha operacional

Se voce nao consegue responder isso, ainda nao esta pronto para modelar.

## Etapa 2: proposta de modelo

Desenhe sua solucao em nivel conceitual:

- quais tipos de registro precisam existir
- quais relacionamentos parecem necessarios
- quais informacoes sao estaveis e quais mudam frequentemente
- quais dados sao obrigatorios em cada momento do processo

Evite sair criando tudo no portal sem antes defender sua ideia.

## Etapa 3: experiencia operacional minima

Pense na primeira versao utilizavel:

- como o usuario registra uma solicitacao
- como localiza o que precisa tratar
- como distingue prioridades
- como sabe o que esta atrasado

O objetivo aqui e criar experiencia operacional minima, nao perfeicao.

## Etapa 4: regras de integridade

Depois de ter processo minimo funcionando, identifique:

- quais regras so melhoram UX
- quais regras precisam proteger o dado
- quais regras precisam bloquear operacao
- quais regras podem ser assincronas

## Etapa 5: seguranca

So depois de entender o fluxo, decida:

- quem cria
- quem altera
- quem redistribui
- quem encerra
- quem administra configuracoes

## Etapa 6: refinamento

Revise:

- naming
- consistencia de status
- qualidade das views
- redundancia de campos
- risco de acoplamento desnecessario

---

# Perguntas-guia

Estas perguntas sao parte do estudo. Nao pule.

## Sobre modelagem

- O processo gira em torno de um unico registro central ou de varios registros de igual peso?
- O que precisa existir como cadastro e o que pode ser apenas atributo de um registro?
- O que precisa de historico proprio?
- O que precisa ser configuravel sem deploy?

## Sobre regras

- Essa regra e de usabilidade ou de integridade?
- Ela precisa funcionar mesmo se o dado vier por integracao?
- Ela precisa bloquear no ato ou pode acontecer depois?
- Ela depende de contexto de tela ou de estado real do processo?

## Sobre experiencia

- Como um atendente sabera o que fazer sem treinamento longo?
- Como um supervisor encontrara problema operacional rapidamente?
- O que precisa aparecer em view, formulario e dashboard?

## Sobre seguranca

- O que voce quer apenas esconder?
- O que voce realmente precisa impedir?
- Quais acoes sao sensiveis demais para depender de JavaScript ou regra visual?

## Sobre manutencao

- Sua solucao aguenta novas categorias e regras sem refatoracao grande?
- Ha algo que voce esta resolvendo com codigo mas deveria ser parametrizavel?
- Ha algo que voce esta deixando declarativo mas deveria estar protegido no servidor?

---

# Criterios de avaliacao da sua solucao

Voce pode considerar sua proposta boa quando ela atender a estes criterios:

## Clareza

A estrutura da solucao permite entender rapidamente o processo.

## Coerencia

As regras implementadas refletem o negocio sem contradicoes.

## Robustez

As regras criticas nao dependem apenas de interface.

## Operacionalidade

A solucao e utilizavel por quem trabalha no dia a dia.

## Evolucao

A primeira versao nao fecha portas para evolucoes futuras.

---

# Erros que este case quer que voce cometa cedo

Sim, isso faz parte do estudo.

Provavelmente voce vai:

- supermodelar no inicio
- colocar regra no lugar errado
- confundir experiencia de tela com integridade
- criar mais atributos do que precisava
- deixar permissao fraca demais ou dura demais

Isso e esperado. O objetivo e justamente revisar essas decisoes depois.

---

# O que voce nao deve esperar deste material

Este material nao vai te entregar:

- quais tabelas criar
- quais colunas criar
- qual tecnologia usar em cada regra
- como nomear cada componente
- o desenho final correto

Se isso aparecesse aqui, deixaria de ser um case de aprendizado e viraria uma implementacao guiada.

---

# Extensoes para fazer sozinho depois

Quando sua primeira versao estiver pronta, adicione melhorias sem ajuda direta:

## Extensao 1

Criar uma logica de escalonamento para itens que ficaram tempo demais sem andamento.

## Extensao 2

Permitir reabertura controlada de itens encerrados.

## Extensao 3

Criar um mecanismo de classificacao automatica ou semi-automatizada.

## Extensao 4

Criar indicadores operacionais para supervisao.

## Extensao 5

Adicionar algum tipo de simulacao de dependencia externa sem acoplar a primeira versao a uma integracao real.

---

# Como eu vou atuar como tutor

Quando voce trouxer sua proposta, eu nao vou reescrever a solucao por voce de imediato.

Eu vou revisar assim:

- onde sua modelagem esta fraca
- onde sua regra ficou no lugar errado
- onde sua seguranca esta cosmetica
- onde sua experiencia operacional esta ruim
- quais decisoes estao boas e por que

Esse e o formato certo para voce aprender com erro, revisao e iteracao.
