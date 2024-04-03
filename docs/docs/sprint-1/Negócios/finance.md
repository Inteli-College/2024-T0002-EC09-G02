---
sidebar_position: 6
slug: '/sprint_1/negocios/financial'
label: "Análise financeira"
---

# Análise financeira

## Visão Geral

A análise financeira é um processo crucial que permite às empresas e investidores avaliar a viabilidade, estabilidade e lucratividade de um negócio ou projeto. Ela contempla a revisão e avaliação das demonstrações financeiras de uma empresa, como balanços patrimoniais, demonstrações de resultado e fluxos de caixa. Essa análise proporciona insights valiosos sobre a saúde financeira da empresa, incluindo sua capacidade de gerar lucro, administrar dívidas e financiar suas operações.

## Estrutura de Custos

A estrutura de custos é detalhada em 3 partes: mão de obra utilizada no desenvolvimento do MVP, os custos totais de serviços em nuvem utilizados e a possibilidade de terceirizar o serviço (venda como produto próprio para outras empresas).

### Gastos com mão de obra

Para a implementação do projeto, será necessário uma equipe composta por uma equipe de profissionais especializados, composta por engenheiros Juniors, Plenos, Seniors, Gerentes e profissionais de QA (Quality Assurance), todos dedicados à criação e ao aprimoramento contínuo do modelo. A tabela a seguir detalha a composição dessa equipe, incluindo o número de profissionais em cada categoria, o custo anual e mensal associado a cada um, refletindo o investimento total necessário para o desenvolvimento ao longo do ano.

| Cargo     | Quantidade | Preço p/ Ano   | Preço p/ mês |
|-----------|------------|----------------|--------------|
| Juniors   | 1          | R$84.000,00    | R$7.000,00   |
| Plenos    | 3          | R$468.000,00   | R$39.000,00  |
| Seniors   | 1          | R$204.000,00   | R$17.000,00  |
| Gerentes  | 1          | R$120.000,00   | R$10.000,00  |
| QA        | 1          | R$180.000,00   | R$15.000,00  |
| **Total** | **7**      | **R$1.056.000,00** | **R$88.000,00** |

### Gastos com serviços Cloud

Este quadro apresenta um resumo dos custos anuais e mensais associados ao uso de diversos serviços da arquitetura em clound para o projeto, incluindo HiveMQ, AWS Elastic Load Balancing, Kafka, Amazon EC2, Amazon VPC e AWS RDS . O total anual em dólares é convertido para reais utilizando a taxa de câmbio de R$5.05, resultando em um custo anual de R$178,665.77 e um custo mensal de R$14,888.81. Essa análise de custos é fundamental para o planejamento financeiro do projeto, permitindo uma avaliação precisa dos gastos com infraestrutura de nuvem e garantindo a alocação eficiente de recursos para operações críticas.

| Arquitetura                             | Preço p/ Ano   | Preço p/ Mês  |
|-------------------------------------|----------------|----------------|
| HiveMQ                              | $3,696,00      | $308.00        |
| AWS Elastic Load Balancing          | $3,206.88      | $267.24        |
| Kafka                              | $13,200.00     | $448.08        |
| Amazon EC2                          | $659.52        | $54.96         |
| Amazon VPC                          | $8,556.00      | $713.00        |
| AWS RDS                             | $5,556.00      | $448.08        |
| MongoDB                             | $684.00        | $57.00         |
| **Total em dólares**                | **$35,379.36** | **$2,948.28**  |
| **Total em reais**                  | **R$178,665.77**|**R$14,888.81**|
| **Taxa de câmbio (Dólar para Real)**| **R$5.05**                      |

**Escolha dos serviços do HiveMQ e MOngoDB**

Para o HiveMQ, foi escolhido o plano `Starter`. A escolha do plano foi baseada em uma conta media de 1600 sensores e 71.424.000 mensagens em um periodo de 31 dias. Este plano contempla a quantidade estimada. 
O MongoDB utiliza o plano `Dedicated` por ter acesso até 4 TB de espaço. A primeiro momento será uma quantidade boa e suficiente para a quantidade de dados e requests que serão utilizados mas poderá ser necessario fazer um Upgrade em algum momento. 


### Terceirização de serviços

Este quadro detalha os custos envolvidos em uma possível terceirização de serviços e na utilização da infraestrutura em clound para um determinado projeto, totalizando R$778,665.77 por ano, com um custo mensal de R$64.888.81. O lucro estimado após esses gastos é de R$421,334.23 ao ano, equivalendo a um retorno mensal de R$50.000,00. Além disso, o cálculo do imposto, presumivelmente sobre o faturamento total, é indicado como R$463,467.6. Esse resumo financeiro é essencial para entender a viabilidade econômica do projeto, permitindo uma análise precisa dos benefícios versus os custos de terceirização e uso de serviços de computação em nuvem.

| Descrição                | Preço por Ano   | Preço por Mês |
|--------------------------|-----------------|---------------|
| Serviço                  | R$600.000,00    | R$50.000,00   |
| Arquitetura              | R$178,665.77    | R$14,888.81   |
| **Total em reais**       | **R$778,665.77**| **R$64.888.81**|
| **Lucro estimado**       | **R$421,334.23**| **R$50.000,00**|
| **Imposto (10%)**        | **R$463,467.66**| Não aplicável |

## Custo total do MVP

Para representar todos os gastos de forma resumida, este quadro apresenta uma visão detalhada dos custos anuais e mensais associados ao desenvolvimento e manutenção do Produto Mínimo Viável (MVP), sem considerar a terceirização de serviços. Os custos incluem a equipe de engenheiros, arquitetura, implementação do projeto e manutenção do modelo, totalizando R$2.824,331.54 por ano, o que resulta em um custo mensal de R$235,360.96. Além disso, é mencionado um imposto de 20%, resultando em R$3.389.197,84. Este resumo financeiro é crucial para compreender o investimento necessário para o lançamento do MVP, permitindo uma análise aprofundada da viabilidade financeira do projeto antes de prosseguir com a terceirização ou outras expansões.

| Item                   | Preço por Ano    | Preço por Mês  |
|------------------------|------------------|----------------|
| Equipe de Engenheiro   | R$1.056.000,00   | R$88.000,00    |
| Arquitetura            | R$178,665.77     | R$14,888.81     |
| Implementação          | R$1.266,259.64   | R$105,521.64    |
| Manutenção do modelo   | R$355.000,00     | R$29.583,33    |
| **Total em reais**     | **R$2.824,331.54** | **R$235,360.96**|
| **Imposto (20%)**      | **R$3.389.197,84**| Não aplicável  |
