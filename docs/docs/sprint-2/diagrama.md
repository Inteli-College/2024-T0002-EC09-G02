---
sidebar_position: 1
slug: '/sprint_2/diagrama'
label: "Diagrama"
---

# Visão geral do sistema

A solução proposta é uma arquitetura IoT robusta que utiliza serviços gerenciados da AWS para coletar, processar e visualizar dados provenientes de dispositivos IoT simulados. Essa solução é composta por vários componentes interconectados, cada um desempenhando um papel fundamental no fluxo de dados. Vamos explorar brevemente cada componente para entender como a solução opera.

## Diagrama de Blocos da Arquitetura - v2.0

![alt text](<../../static/img/Diagrama de blocos - Cloud-v2.png>)

### Descrição dos Componentes Anteriores

- **Cliente MQTT**: Dispositivo que publica mensagens em tópicos MQTT. No contexto do projeto, o cliente MQTT é um simulador de um dispositivo IoT.
- **Broker MQTT**: Servidor que gerencia a comunicação entre os clientes MQTT. No contexto do projeto, o broker MQTT é o serviço AWS IoT Core. A escolha do Iot Core se deu pela sua escalabilidade, segurança e integração com outros serviços da AWS, ao qual no próprio processo de configuração de um dispositivo, é possível criar regras para processar mensagens e armazená-las em outros serviços.
- **AWS IoT Core**: Serviço da AWS que gerencia a comunicação entre dispositivos IoT e a nuvem. O AWS IoT Core permite a conexão segura de dispositivos com a nuvem, além de oferecer recursos para processar e armazenar mensagens.
- **DynamoDB**: Banco de dados NoSQL da AWS que armazena as mensagens recebidas do broker MQTT. O DynamoDB foi escolhido por sua escalabilidade, desempenho e integração com outros serviços da AWS.
- **Amazon EKS**: Serviço da AWS que gerencia clusters de contêineres. O EKS foi escolhido para hospedar a aplicação web por sua escalabilidade, segurança e integração com outros serviços da AWS.
- **EC2**: Serviço da AWS que fornece capacidade de computação na nuvem. O EC2 foi escolhido para estar acoplado ao EKS e hospedar os nós do Kubernetes e seus respectivos pods.

### Descrição dos Componentes Adicionados

- **AWS Glue**: Serviço da AWS que oferece recursos para preparar e carregar dados para análise. O AWS Glue executa a rotina de tratamento e catalogação dos dados do DynamoDB por meio do AWS Glue ETL para o AWS Glue Data Catalog.
  - **AWS Glue ETL**: Serviço da AWS que oferece recursos para extrair, transformar e carregar dados para análise. O AWS Glue ETL foi escolhido para extrair, transformar e carregar os dados do DynamoDB para o AWS Glue Data Catalog.
  - **AWS Glue Data Catalog**: Serviço da AWS que oferece recursos para catalogar e armazenar metadados de dados. O AWS Glue Data Catalog foi escolhido para armazenar os metadados dos dados extraídos, transformados e carregados do DynamoDB.

