---
sidebar_position: 2
slug: '/sprint_2/arquitetura/diagrama'
label: "Diagrama"
---
# Diagrama de Blocos

A arquitetura da solução define como os componentes do sistema se comunicam e interagem. Sua representação por meio de um diagrama de blocos é essencial para compreender o funcionamento do sistema e identificar possíveis problemas e melhorias. Vale ressaltar que o diagrama de blocos simplifica a arquitetura, omitindo detalhes de implementação e comunicação entre componentes. Além disso, ao utilizar o ambiente em nuvem da AWS Academy, a arquitetura está restrita aos serviços e recursos disponíveis na AWS, sendo necessário adaptá-la ao longo das sprints. Fato que ocorreu na sprint 2, onde a arquitetura foi adaptada para atender as necessidades do projeto.

## Diagrama de Blocos da Arquitetura - v2.0

![alt text](<../../../static/img/Diagrama de blocos - Cloud-v2.png>)

### Descrição dos Componentes Anteriores

- **Cliente MQTT**: Dispositivo que publica mensagens em tópicos MQTT. No contexto do projeto, o cliente MQTT é um simulador de um dispositivo IoT.
- **Broker MQTT**: Servidor que gerencia a comunicação entre os clientes MQTT. No contexto do projeto, o broker MQTT é o serviço AWS IoT Core. A escolha do Iot Core se deu pela sua escalabilidade, segurança e integração com outros serviços da AWS, ao qual no próprio processo de configuração de um dispositivo, é possível criar regras para processar mensagens e armazená-las em outros serviços.
- **AWS IoT Core**: Serviço da AWS que gerencia a comunicação entre dispositivos IoT e a nuvem. O AWS IoT Core permite a conexão segura de dispositivos com a nuvem, além de oferecer recursos para processar e armazenar mensagens.
- **DynamoDB**: Banco de dados NoSQL da AWS que armazena as mensagens recebidas do broker MQTT. O DynamoDB foi escolhido por sua escalabilidade, desempenho e integração com outros serviços da AWS.
- **Amazon EKS**: Serviço da AWS que gerencia clusters de contêineres. O EKS foi escolhido para hospedar a aplicação web por sua escalabilidade, segurança e integração com outros serviços da AWS.
- **EC2**: Serviço da AWS que fornece capacidade de computação na nuvem. O EC2 foi escolhido para estar acoplado ao EKS e hospedar os nós do Kubernetes e seus respectivos pods.

### Descrição dos Componentes Adicionados

- **AWS Glue**: Serviço da AWS que oferece recursos para preparar e carregar dados para análise. O AWS Glue a rotina de tratamento e catalogação dos dados do DynamoDB por meio do AWS Glue - ETL para o AWS Glue - Data Catalog.
  - **AWS Glue - ETL**: Serviço da AWS que oferece recursos para extrair, transformar e carregar dados para análise. O AWS Glue - ETL foi escolhido para extrair, transformar e carregar os dados do DynamoDB para o AWS Glue - Data Catalog.
  - **AWS Glue - Data Catalog**: Serviço da AWS que oferece recursos para catalogar e armazenar metadados de dados. O AWS Glue - Data Catalog foi escolhido para armazenar os metadados dos dados extraídos, transformados e carregados do DynamoDB.

### Descrição de Fluxo

#### 1. Input de Dados

1. O cliente MQTT publica mensagens em tópicos MQTT as informações de cada sensor.
2. O broker MQTT recebe as mensagens e as encaminha para o AWS IoT Core. Onde os tópicos são configurados para serem encaminhados primeiro pelo nome "sensor", região e por tipo de sensor, ficando na nomenclarura: "sensor/região/tipo_sensor". Após isso, o AWS IoT Core encaminha as mensagens para o DynamoDB.
3. O DynamoDB armazena as mensagens recebidas do IoT Core.

#### 2. Processamento e Visualização de Dados
1. O Amazon EKS estará integrado ao EC2 e, com a configuração adequada, o Kubernetes irá gerenciar os serviços do cluster e provisionar novos pods conforme necessário. Assim, o EC2 hospedará os nós do Kubernetes e seus respectivos pods.
2. Dentro dos serviços e pods, estarão armazenadas e executando as imagens do Grafana e do Prometheus, permitindo a visualização dos dados armazenados no DynamoDB.
3. O grafana, por sua vez, estará integrado ao data source Athena, que por sua vez estará integrado ao AWS Glue - Data Catalog, permitindo a visualização dos dados armazenados no DynamoDB.
4. Já dentro do Grafana, será possível visualizar os dados armazenados no DynamoDB, por meio de dashboards divididos por região e gráficos por tipo de sensor. Além de um dashboard geral, que exibirá todos os dados sobre o consumo e desempenho dos pods e serviços do cluster do Amazon EKS.

### Conclusão

A solução proposta, apesar da sua primeira mudança, já cumpre os requisitos do projeto e oferece a possibilidade de evolução do sistema durante as sprints. Esta arquitetura é escalável, segura e se integra facilmente aos serviços da AWS, facilitando tanto a implementação quanto a manutenção. Sua flexibilidade também permite a adição de novos serviços e recursos da AWS conforme as demandas do projeto evoluem. Todo o gerenciamento da arquitetura é feito por meio do Terraform, que permite a criação, atualização e exclusão de recursos da AWS de forma programática e automatizada. A arquitetura proposta é, portanto, uma base sólida para o desenvolvimento do projeto e para a implementação de novas funcionalidades e melhorias.