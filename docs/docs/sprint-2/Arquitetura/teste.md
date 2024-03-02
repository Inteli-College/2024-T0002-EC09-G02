---
sidebar_position: 3
slug: '/sprint_1/arquitetura/teste'
label: "Teste arquitetura"
---
# Teste da Arquitetura

Elaborar testes para a arquitetura proposta é essencial para garantir que o sistema atenda aos requisitos do projeto e funcione corretamente. A seguir, são apresentados os testes a serem realizados para validar a arquitetura proposta.

## Testes Manuais

### Teste de Conexão MQTT

**Objetivo:** Verificar se o cliente MQTT consegue publicar mensagens nos tópicos corretos e se o broker MQTT encaminha corretamente as mensagens para o AWS IoT Core.

**Passos:**

1. Configurar um cliente MQTT para publicar mensagens nos tópicos especificados.
2. Verificar se as mensagens são recebidas pelo broker MQTT.
3. Verificar se as mensagens são encaminhadas corretamente para o AWS IoT Core.

**Ferramentas:** Cliente MQTT (por exemplo, MQTT Explorer)

### Teste de Armazenamento no DynamoDB

**Objetivo:** Assegurar que as mensagens recebidas do broker MQTT são corretamente armazenadas no DynamoDB.

**Passos:**

1. Publicar mensagens nos tópicos MQTT para simular a entrada de dados.
2. Verificar se as mensagens são armazenadas no DynamoDB.
3. Consultar o DynamoDB para confirmar se os dados estão corretos e completos.

**Ferramentas:** AWS Management Console (para consulta e verificação do DynamoDB)

### Teste de Integração entre AWS IoT Core, DynamoDB e ECR/EC2

**Objetivo:** Garantir que a integração entre o AWS IoT Core, DynamoDB e os serviços ECR/EC2 está funcionando corretamente.

**Passos:**

1. Confirmar se o AWS IoT Core está encaminhando as mensagens para o DynamoDB.
2. Verificar se as imagens Docker do Grafana e do Prometheus estão armazenadas no Amazon ECR.
3. Garantir que o Amazon EKS esteja integrado ao EC2 e possa provisionar os pods conforme necessário.
4. Testar a comunicação entre os serviços, garantindo que o Grafana possa acessar os dados armazenados no DynamoDB.

**Ferramentas:** AWS Management Console, Kubectl (para gerenciamento do Kubernetes)

### Teste de Visualização de Dados no Grafana

**Objetivo:** Confirmar que o Grafana está corretamente configurado para visualizar os dados armazenados no DynamoDB.

**Passos:**

1. Acessar o Grafana Dashboard.
2. Configurar os painéis para exibir os dados relevantes.
3. Verificar se os dados são exibidos corretamente nos painéis do Grafana.

**Ferramentas:** Navegador web para acessar o Grafana Dashboard.

### Teste de Escalabilidade e Provisionamento Automático

**Objetivo:** Garantir que a arquitetura seja escalável e possa provisionar recursos automaticamente conforme necessário.

**Passos:**

1. Simular um aumento na carga de trabalho, aumentando o número de mensagens MQTT publicadas.
2. Observar se o Amazon EKS provisiona automaticamente novos pods conforme a demanda.
3. Verificar se o desempenho do sistema permanece estável mesmo sob carga aumentada.

**Ferramentas:** Ferramentas de monitoramento de desempenho (por exemplo, AWS CloudWatch, Prometheus) para observar o provisionamento automático e o desempenho do sistema.

## Testes Automatizados - GitHub Actions

### Teste de Build de Imagens Docker

**Objetivo:** Verificar se as imagens Docker do Grafana e do Prometheus são construídas corretamente.

**Passos:**

1. Configurar uma pipeline de CI/CD para construir as imagens Docker automaticamente.
2. Verificar se as imagens são construídas sem erros.
3. Armazenar as imagens no Amazon ECR.

**Ferramentas:** GitHub Actions e Docker

### Teste de Integração com DynamoDB

**Objetivo:** Assegurar que a aplicação web pode se conectar ao DynamoDB e acessar os dados corretamente.

**Passos:**

1. Configurar uma pipeline de CI/CD para testar a integração com o DynamoDB.
2. Verificar se é possivel acessar os dados armazenados no DynamoDB.
3. Confirmar se ocorre a exibição dos dados corretamente.

**Ferramentas:** GitHub Actions e ferramentas de teste de integração

### Teste de Configuração do Amazon EKS

**Objetivo:** Garantir que o Amazon EKS esteja corretamente configurado e possa provisionar os pods conforme necessário.

**Passos:**

1. Configurar uma pipeline de CI/CD para testar a configuração do Amazon EKS.
2. Verificar se o Amazon EKS provisiona os pods conforme necessário.
3. Testar a comunicação entre os serviços para garantir que o Grafana possa acessar os dados armazenados no DynamoDB.
4. Confirmar se o desempenho do sistema permanece estável mesmo sob carga aumentada.

**Ferramentas:** GitHub Actions, Kubectl (para gerenciamento do Kubernetes)

## Conclusão

Os testes propostos visam garantir que a arquitetura proposta seja robusta, escalável e capaz de atender aos requisitos do projeto. A combinação de testes manuais e automatizados permite validar a arquitetura em diferentes níveis, desde a integração entre os serviços até a escalabilidade e provisionamento automático. A realização desses testes é essencial para garantir a qualidade e o desempenho do sistema, bem como para identificar possíveis problemas e melhorias ao longo das sprints.
