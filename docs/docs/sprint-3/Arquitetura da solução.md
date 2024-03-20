---
sidebar_position: 1
slug: 'Arquitetura da solução'

---

# Visão geral do sistema

A solução proposta é uma arquitetura IoT robusta que utiliza serviços gerenciados da AWS para coletar, processar e visualizar dados provenientes de dispositivos IoT simulados. Essa solução é composta por vários componentes interconectados, cada um desempenhando um papel fundamental no fluxo de dados. Vamos explorar brevemente cada componente para entender como a solução opera.

## Diagrama de Blocos da Arquitetura - v3.0

![alt text](<../../static/img/Diagrama de blocos - Cloud-v2.png>)

### Descrição dos Componentes Anteriores

- **Cliente MQTT**: Dispositivo que publica mensagens em tópicos MQTT. No contexto do projeto, o cliente MQTT é um simulador de um dispositivo IoT.
- **Broker MQTT**: Servidor que gerencia a comunicação entre os clientes MQTT. No contexto do projeto, o broker MQTT é o serviço AWS IoT Core. A escolha do Iot Core se deu pela sua escalabilidade, segurança e integração com outros serviços da AWS, ao qual no próprio processo de configuração de um dispositivo, é possível criar regras para processar mensagens e armazená-las em outros serviços.
- **AWS IoT Core**: Serviço da AWS que gerencia a comunicação entre dispositivos IoT e a nuvem. O AWS IoT Core permite a conexão segura de dispositivos com a nuvem, além de oferecer recursos para processar e armazenar mensagens.
- **DynamoDB**: Banco de dados NoSQL da AWS que armazena as mensagens recebidas do broker MQTT. O DynamoDB foi escolhido por sua escalabilidade, desempenho e integração com outros serviços da AWS.
- **Amazon EKS**: Serviço da AWS que gerencia clusters de contêineres. O EKS foi escolhido para hospedar a aplicação web por sua escalabilidade, segurança e integração com outros serviços da AWS.
- **EC2**: Serviço da AWS que fornece capacidade de computação na nuvem. O EC2 foi escolhido para estar acoplado ao EKS e hospedar os nós do Kubernetes e seus respectivos pods.
- **AWS Glue**: Serviço da AWS que oferece recursos para preparar e carregar dados para análise. O AWS Glue executa a rotina de tratamento e catalogação dos dados do DynamoDB por meio do AWS Glue ETL para o AWS Glue Data Catalog.
  - **AWS Glue ETL**: Serviço da AWS que oferece recursos para extrair, transformar e carregar dados para análise. O AWS Glue ETL foi escolhido para extrair, transformar e carregar os dados do DynamoDB para o AWS Glue Data Catalog.
  - **AWS Glue Data Catalog**: Serviço da AWS que oferece recursos para catalogar e armazenar metadados de dados. O AWS Glue Data Catalog foi escolhido para armazenar os metadados dos dados extraídos, transformados e carregados do DynamoDB.

**Observação:** nenhum componente novo foi adicionado nesta sprint.
  
## Diagrama de implantação

Um Diagrama UML (Unified Modeling Language ou Linguagem Unificada de Modelagem) é uma forma padronizada de visualizar o design de um sistema. UML é uma linguagem de modelagem de sistemas que permite a representação gráfica de um sistema por meio de diferentes tipos de diagramas. Com a UML, os desenvolvedores e stakeholders podem entender, alterar, construir e documentar aspectos de um sistema de software.

![alt text](../../static/img/implantacao.png)

### Dispositivo (Publisher)

- O dispositivo contém sensores para coletar dados ambientais como qualidade do ar e temperatura.
- A autenticação é garantida por meio de certificados SHA-256 e chaves (pública e privada) SHA-256 para comunicação segura.
- Os dados coletados são enviados para a AWS através do protocolo MQTT.
  
### Nuvem (AWS)
- No serviço AWS IoT Core, uma regra é definida para processar dados recebidos do tópico 'topic/region/+'.
- O AWS IoT Core atua como um ponto central para receber e encaminhar dados.
  
### Banco de Dados

![alt text](../../static/img/db.png)

- Os dados são armazenados no DynamoDB, um banco de dados NoSQL da AWS, para armazenamento e recuperação eficiente.
- O serviço AWS Glue é usado para realizar a catalogação dos dados armazenados, executando funções de um Crawler para identificar os dados e organizar as tabelas para consulta.

### Visualização (Dashboard)

- O serviço EKS (Elastic Kubernetes Service) gerencia os aplicativos de visualização de dados.
- Grafana e Prometheus são integrados para a monitorização e visualização em tempo real dos dados.
- O Amazon Athena é usado para consultas SQL diretamente no DynamoDB.
- O serviço EC2, com uma instância T3.Medium, é utilizado para hospedar e executar as aplicações necessárias para o funcionamento do dashboard.

## Segurança no banco de dados e dashboard
Para garantir a segurança nas conexões entre o banco de dados, o dashboard e o resto do sistema em nossa solução de arquitetura IoT baseada na AWS, implementamos diversas medidas de segurança. Abaixo estão os detalhes de como cada segmento da arquitetura contribui para a integridade, confidencialidade e disponibilidade dos dados e serviços.

![alt text](../../static/img/security.png)

### Segurança do Dispositivo ao AWS IoT Core
A segurança da comunicação entre dispositivos IoT e o AWS IoT Core é assegurada pelo uso do protocolo TLS (Transport Layer Security), o que garante uma conexão autenticada e segura. Cada dispositivo utiliza um certificado X.509 para estabelecer sua identidade, o qual é verificado pelo AWS IoT Core antes de qualquer comunicação. Além disso, políticas de autorização específicas são aplicadas para restringir o que cada dispositivo pode fazer (como publicar ou assinar tópicos MQTT específicos).

### Autorização e Controle de Acesso
Utilizamos o AWS Identity and Access Management (IAM) para gerenciar as permissões de acesso aos recursos da AWS. O IAM Role, ou papel do IAM, começa com a definição de políticas que especificam quais serviços e ações o usuário ou serviço tem permissão para usar. No caso do AWS Glue e outras integrações, isso significa acesso controlado para executar operações de ETL (Extrair, Transformar e Carregar) e consultar dados.

### Segurança no Banco de Dados
O AWS DynamoDB é protegido por padrão com criptografia em repouso. Isso garante que os dados estão seguros enquanto armazenados. Além disso, controles de acesso baseados em políticas do DynamoDB permitem que apenas usuários e serviços autorizados possam acessar ou modificar os dados.

### Segurança na Camada de Processamento e Análise de Dados
O AWS Glue como serviço de ETL utiliza o IAM Role para autorizar operações de transformação de dados. Com isso, somente processos de ETL com as credenciais adequadas podem acessar os dados do DynamoDB. O mesmo se aplica ao Athena, que é usado para realizar consultas SQL diretamente nos dados armazenados.

### Segurança no Dashboard e Visualização de Dados
Para o dashboard hospedado no Amazon EKS, o acesso é protegido através do controle de acesso ao Kubernetes, integrado ao IAM da AWS. Isso significa que apenas usuários com as credenciais corretas podem acessar o Grafana. Além disso, o login do Grafana é protegido por autenticação, que pode ser configurada para usar autenticação de múltiplos fatores (MFA) para uma camada adicional de segurança.

Adicionalmente, a comunicação entre serviços, como entre o Grafana e o Prometheus ou o Athena, é protegida por meio de políticas de segurança que asseguram que apenas tráfego autorizado possa fluir entre esses serviços, minimizando assim o risco de interceptação ou manipulação de dados.

### Conclusão
Essas medidas de segurança são projetadas para trabalhar em conjunto, formando uma cadeia de segurança ininterrupta desde a coleta de dados até a visualização. Com cada componente desempenhando seu papel específico, estamos comprometidos em fornecer uma arquitetura segura e confiável para o processamento e análise de dados IoT.






