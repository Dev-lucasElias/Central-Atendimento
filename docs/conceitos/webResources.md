# Web Resources no Power Apps Model-Driven

Web Resources são arquivos publicados no ambiente do Dataverse que ficam expostos para uso dentro de um app Model-Driven. Podem ser HTML, CSS, JavaScript, imagens, entre outros.

## Como funciona

A página inicial de um Model-Driven App pode apontar para qualquer web resource do ambiente. Um HTML pode referenciar CSS e JS internamente, desde que esses arquivos também estejam publicados como web resources separadas no ambiente.

```html
<link rel="stylesheet" href="seu_publisher_new_style.css" />
<script src="seu_publisher_new_app.js"></script>
```

## Tecnologias suportadas

- HTML + CSS + JavaScript puro
- Bibliotecas externas (jQuery, Chart.js etc.) subindo os arquivos como web resources
- React, Angular ou Next.js — compilando o projeto (`npm run build`) e subindo o bundle gerado como web resources

Não há servidor envolvido. Tudo roda no browser do usuário. Para acessar dados do Dataverse, usa-se a Web API via `fetch`, com autenticação herdada do contexto do usuário logado.

## Web Resource vs. PCF

| | Web Resource | PCF |
|---|---|---|
| O que é | Página/arquivo solto no ambiente | Componente que vive dentro de um campo ou grid |
| Onde aparece | Página inteira no app | Dentro de um formulário ou view |
| Framework | Livre (qualquer coisa compilada) | Obrigatório usar o SDK do PCF |
| Acesso ao Dataverse | Web API via fetch | Context API do PCF |
| Complexidade | Menor para começar | Maior, mas mais integrado ao formulário |

**Regra prática:** se quer substituir como um campo é renderizado, usa PCF. Se quer uma tela própria no app, usa Web Resource.
