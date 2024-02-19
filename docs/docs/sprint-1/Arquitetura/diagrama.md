---
sidebar_position: 2
slug: '/sprint_1/arquitetura/diagrama'
label: "Diagrama"
---
# Diagrama de Blocos

A arquitetura da solução define como os componentes do sistema se comunicam e interagem. Sua representação por meio de um diagrama de blocos é essencial para compreender o funcionamento do sistema e identificar possíveis problemas e melhorias. Vale ressaltar que o diagrama de blocos simplifica a arquitetura, omitindo detalhes de implementação e comunicação entre componentes. Além disso, ao utilizar o ambiente em nuvem da AWS Academy, a arquitetura está restrita aos serviços e recursos disponíveis na AWS, sendo necessário adaptá-la ao longo das sprints.

## Diagrama de Blocos da Arquitetura - v1.0

![alt text](<../../../static/img/Diagrama de blocos - Cloud.png>)

### Descrição dos Componentes

- **Cliente MQTT**: Dispositivo que publica mensagens em tópicos MQTT. No contexto do projeto, o cliente MQTT é um simulador de um dispositivo IoT.
- **Broker MQTT**: Servidor que gerencia a comunicação entre os clientes MQTT. No contexto do projeto, o broker MQTT é o serviço AWS IoT Core. A escolha do Iot Core se deu pela sua escalabilidade, segurança e integração com outros serviços da AWS, ao qual no próprio processo de configuração de um dispositivo, é possível criar regras para processar mensagens e armazená-las em outros serviços.
- **AWS IoT Core**: Serviço da AWS que gerencia a comunicação entre dispositivos IoT e a nuvem. O AWS IoT Core permite a conexão segura de dispositivos com a nuvem, além de oferecer recursos para processar e armazenar mensagens.
- **DynamoDB**: Banco de dados NoSQL da AWS que armazena as mensagens recebidas do broker MQTT. O DynamoDB foi escolhido por sua escalabilidade, desempenho e integração com outros serviços da AWS.
- **Amazon EKS**: Serviço da AWS que gerencia clusters de contêineres. O EKS foi escolhido para hospedar a aplicação web por sua escalabilidade, segurança e integração com outros serviços da AWS.
- **Amazon ECR**: Registro de contêineres da AWS que armazena as imagens da aplicação web. O ECR foi escolhido por sua integração com o EKS e outros serviços da AWS.
- **EC2**: Serviço da AWS que fornece capacidade de computação na nuvem. O EC2 foi escolhido para hospedar o Grafana Dashboard (serviço de dashboard) integrado ao prometheus (comunicação) por sua escalabilidade, segurança e integração com outros serviços da AWS.

### Descrição de Fluxo

#### 1. Input de Dados

1. O cliente MQTT publica mensagens em tópicos MQTT as informações de cada sensor.
2. O broker MQTT recebe as mensagens e as encaminha para o AWS IoT Core. Onde os tópicos são configurados para serem encaminhados primeiro pelo nome "sensor", região e por tipo de sensor, ficando na nomenclarura: "sensor/região/tipo_sensor". Após isso, o AWS IoT Core encaminha as mensagens para o DynamoDB.
3. O DynamoDB armazena as mensagens recebidas do IoT Core.

#### 2. Processamento e Visualização de Dados

1. O Amazon ECR armazena as imagens Docker do Grafana e do Prometheus. O Grafana é um serviço de dashboard para visualização de dados, enquanto o Prometheus é um serviço de captura de dados e gerenciamento de alertas.
2. O Amazon EKS estará integrado ao EC2 e, com a configuração adequada, o Kubernetes irá gerenciar os serviços do cluster e provisionar novos pods conforme necessário. Assim, o EC2 hospedará os nós do Kubernetes e seus respectivos pods.
3. Dentro dos serviços e pods, estarão armazenadas e executando as imagens do Grafana e do Prometheus, permitindo a visualização dos dados armazenados no DynamoDB.

### Conclusão

A solução proposta, apesar de estar em fase inicial, já cumpre os requisitos do projeto e oferece a possibilidade de evolução do sistema durante as sprints. Esta arquitetura é escalável, segura e se integra facilmente aos serviços da AWS, facilitando tanto a implementação quanto a manutenção. Sua flexibilidade também permite a adição de novos serviços e recursos da AWS conforme as demandas do projeto evoluem. Como estratégia de otimização, o grupo planeja empregar a tecnologia do Terraform para automatizar a criação e configuração dos recursos na AWS, o que promete agilizar a implantação e manutenção do sistema para o benefício do parceiro de projeto.
