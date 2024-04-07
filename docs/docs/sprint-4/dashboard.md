---
sidebar_position: 6
slug: 'Dashboard'
---

# Metabase

O Metabase é uma ferramenta de software de código aberto projetada para simplificar a análise e a visualização de dados. Ele oferece uma interface intuitiva que permite aos usuários criar consultas, gráficos e painéis interativos sem a necessidade de conhecimento avançado em SQL ou programação. O Metabase suporta a conexão com uma variedade de bancos de dados, como MySQL, PostgreSQL e MongoDB, entre outros.

Além da sua gratuitdade, também podemos utilizar do grande potencial na criação de dashboards públicos, por isso escolhemos ele como nossa ferramenta de dashboards.

## Conexão com o banco de dados

Utilizamos o MongoDB como banco de dados. Por conta da sua natureza ``noSQL``, temos algumas limitações em relação à criação dos gráficos. Contudo, o Metabase possui completa integração com esse tipo de banco de dados, permitindo a simples conexão com as tabelas que precisamos para a criação do dashboard.

## O Dashboard

Dividimos nosso dashboard em algumas partes:
- Visão geral;
- Poluição sonora;
- Poluição de gases.

Observação: Temos os dados de radiação solar e tamanho de partícula, mas a formatação dos dados está incorreta. Para a próxima sprint, arrumaremos essa formatação e criaremos os dashboards para essas informações.

### Visão geral

A primeira visualização que há no dashboard (o qual pode ser visualizado em [Dashboard](http://metabase-load-balancer-465771358.us-east-1.elb.amazonaws.com/public/dashboard/6c5c5c87-f215-42ea-ba72-6829a20302da)) é a visão geral da região. Aqui, nosso objetivo é dar apenas uma noção sobre a situação em São Paulo.

![Dashboard sobre a visão geral da região norte de São Paulo](<../../static/img/sprint-4/Dash-geral.png>)

Nesse seção, temos 5 gráficos no total:

#### Gauges

Gauges (ou alertas) são ótimos para passar uma informação rápida sobre o que determinado número significa. Isso acontece por conta da sua natureza cromática de dividir intervalos em níveis de alarme, simbolizando como a informação está no momento e o quão perto ela está de se tornar perigosa, por exemplo.

##### Poluição sonora

O primeiro alarme é sobre o nível de poluição sonora (medida em decibéis), simbolizando se o barulho em determinada região de São Paulo está Aceitável, Tolerável ou Perigoso, tendo os limites estabelecidos por pesquisas que medem até quantos decibéis começam a danificar o sistema humano. [Fonte](https://www.audiumbrasil.com.br/blog/protecao-auditiva/volume-e-decibeis/#:~:text=O%20volume%20mais%20suave%20percebido,mais%20alto%20que%2050%20dB.).

![Alarme sobre poluição sonora, mostrando 69 decibéis, representando uma poluição tolerável.](<../../static/img/sprint-4/Gauge-som.png>)

##### Níveis de poluição de gases (CO, CO2 e NO2)

Os próximos 3 alarmes são sobre os níveis de poluição de gases (medida em partes por milhão ou bilhão), simbolizando se um gás (entre CO, CO2 e NO2) em determinada região de São Paulo está Aceitável, Tolerável ou Perigoso.

![Alarmes sobre poluição dos gases CO, CO2 e NO2 em partes por milhõa, representando poluições, respectivaemente, tolerável, tolerável e aceitável.](<../../static/img/sprint-4/Gauges-gas.png>)

#### Poluição de gases

Por último há um gráfico de linhas com a variação dos 3 gases em suas medidas.

![alt text](<../../static/img/sprint-4/Linhas-gas.png>)


### Poluição de gases

A segunda visualização que há no dashboard (o qual pode ser visualizado em [Dashboard](http://metabase-load-balancer-465771358.us-east-1.elb.amazonaws.com/public/dashboard/6c5c5c87-f215-42ea-ba72-6829a20302da)) é a visão geral sobre poluição de gases da região. Aqui, nosso objetivo é demonstrar a poluição de gases na região por uma segunda visualização.

![Dashboard sobre a visão geral de poluição de gases da região norte de São Paulo](<../../static/img/sprint-4/Dash-gas.png>)

### Poluição sonora

A terceira visualização que há no dashboard (o qual pode ser visualizado em [Dashboard](http://metabase-load-balancer-465771358.us-east-1.elb.amazonaws.com/public/dashboard/6c5c5c87-f215-42ea-ba72-6829a20302da)) é a visão geral sobre poluição sonora da região. Aqui, nosso objetivo é demonstrar a poluição sonora na região por uma segunda visualização.

![Dashboard sobre a visão geral de poluição sonora da região norte de São Paulo](<../../static/img/sprint-4/Dash-som.png>)

Aqui, há dois novos indicadores:


#### Número de violações

Esse indicador representa o número de vezes que o nível de som na região de São Paulo passou de 55 decibéis, que é o limite para começar a danificar um pouco sistema humano.

![74 violações](<../../static/img/sprint-4/Som-Violacoes.png>)

#### Poluição sonora anual

Uma breve representação de como a poluição sonora se comportou ao longo do ano.

![Gráfico de linhas sobre a variação de som no ano](<../../static/img/sprint-4/Linhas-som-ano.png>)

