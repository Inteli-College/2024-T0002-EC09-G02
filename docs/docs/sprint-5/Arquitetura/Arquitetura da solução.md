---
sidebar_position: 1
slug: 'Arquitetura da solução'
---

# Arquitetura da solução

A solução proposta é uma arquitetura IoT robusta que utiliza serviços gerenciados da AWS para coletar, processar e visualizar dados provenientes de dispositivos IoT simulados. Essa solução é composta por vários componentes interconectados, cada um desempenhando um papel fundamental no fluxo de dados.

## Diagrama de Blocos da Arquitetura - v5.0

![Diagrama de blocos sobre o MQTT](<../../../static/img/Diagrama de blocos v5.0 - MQTT.png>)

### Descrição dos Componentes 

**Broker no HiveMQ:** Servidor que gerencia a comunicação entre os clientes MQTT. No contexto do projeto, o broker MQTT é o serviço HiveMQ. A escolha do HiveMQ se deu pela sua facilidade de integração, compatibilidade, autenticação via usuário e senha.

**Kafka da Confluent:** A adoção do Kafka, oferecido pela Confluent, como nosso sistema de event streaming é fundamental para o processamento eficiente e em tempo real dos dados coletados. O Kafka se destaca pela sua capacidade de gerenciar grandes volumes de dados, fornecendo uma solução robusta para o processamento e análise de informações ambientais.

**MongoDB Atlas:** Para o armazenamento de dados, optamos pelo MongoDB Atlas, uma plataforma de banco de dados como serviço (DBaaS) que oferece alta disponibilidade, automação de backup e recuperação de desastres, entre outras características. O uso do MongoDB Atlas simplifica a gestão do banco de dados, permitindo uma escalabilidade fácil e um desempenho confiável, tudo isso com custos previsíveis e competitivos.

**Metabase em uma EC2 com Autoscaler:** A implementação do Metabase para visualização e análise de dados em uma instância EC2 da AWS com capacidade de autoscaling representa uma solução inovadora e custo-efetiva para a análise de dados. O Metabase, uma ferramenta open-source de business intelligence, combinado com a flexibilidade e a escalabilidade da infraestrutura AWS EC2, permite uma análise de dados poderosa e acessível. A funcionalidade de autoscaling garante que a plataforma possa se ajustar automaticamente à demanda, otimizando os custos e assegurando que o desempenho não seja comprometido durante picos de uso.

## Diagrama de Implantação - v5.0

Um diagrama de implantação é um tipo de diagrama UML (Unified Modeling Language) que representa a arquitetura física de um sistema, ou seja, como os seus componentes são distribuídos em hardware e software. Ele mostra como os diferentes elementos do sistema, como nós de processamento, dispositivos de armazenamento e software, estão interconectados e implantados em diversos nós físicos, como servidores, computadores pessoais, dispositivos móveis, entre outros.

A funcionalidade principal de um diagrama de implantação é fornecer uma visão geral da infraestrutura física do sistema, ajudando os desenvolvedores, arquitetos de sistemas e administradores a entender como os componentes do sistema são distribuídos e como eles se comunicam entre si. Isso é útil para planejar a implantação do sistema em um ambiente real, dimensionar os recursos necessários, identificar possíveis pontos de falha e otimizar a comunicação entre os componentes.

![Diagrama de Implantação 4](<../../../static/img/DiagramaImplantacao4.png>)

## Diagrama de Sequência - v5.0

O diagrama ilustra o fluxo de dados de um dispositivo IoT até a apresentação em um dashboard de análise, utilizando uma arquitetura de processamento de dados baseada em eventos. 

Este fluxo assegura que os dados capturados pelos dispositivos IoT sejam transmitidos de maneira segura e eficiente para sistemas de armazenamento e análise, permitindo insights oportunos e a tomada de decisão baseada em dados. A integração do HiveMQ com o Kafka Confluent e MongoDB facilita o processamento e análise escaláveis de eventos em tempo real, enquanto o Metabase permite a visualização de dados de uma forma acessível para os usuários finais.

![Diagrama de Sequência 4](<../../../static/img/sequence-sprint4.png>)
