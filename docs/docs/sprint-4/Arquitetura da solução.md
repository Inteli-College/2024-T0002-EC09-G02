---
sidebar_position: 1
slug: 'Arquitetura da solução'
---
# Mudanças na arquitetura

Ao avançarmos na jornada de desenvolvimento do nosso projeto colaborativo entre o Instituto de Tecnologia e Liderança (INTELI) e a PRODAM, chegamos a um ponto crítico durante a Sprint 4 que nos levou a repensar fundamentalmente nossa abordagem arquitetônica. A necessidade de adaptação não apenas ressaltou nossa capacidade de inovação diante dos desafios, mas também enfatizou nossa dedicação em oferecer uma solução tecnológica robusta e confiável para o monitoramento da degradação ambiental urbana.

Inicialmente, nossa arquitetura era amplamente baseada em serviços da AWS, com o intuito de aproveitar sua escalabilidade e a facilidade de implementação por meio de ferramentas como Terraform e GitHub Actions. Esta abordagem, embora promissora, começou a revelar complexidades crescentes, especialmente com a introdução de um sistema de event streaming baseado em disco, como o Kafka. Esta adição foi inicialmente vista como uma melhoria essencial para o processamento e análise de dados em tempo real.

Entretanto, a integração do Kafka, juntamente com o HiveMQ para a comunicação entre dispositivos IoT e o MongoDB para armazenamento de dados, embora poderosa, introduziu uma complexidade que começou a contrariar nossos objetivos de eficiência e simplicidade. As limitações encontradas com a AWS Academy, especialmente a indisponibilidade do Amazon MSK (Kafka Managed Service) como uma oferta gratuita, nos obrigaram a considerar alternativas que resultaram em uma arquitetura significativamente mais complexa, envolvendo integrações complicadas com serviços externos e a substituição de ferramentas de visualização de dados, como a transição do Grafana para o Metabase.

Diante desses desafios e da crescente complexidade, tomamos a decisão consciente de simplificar nossa arquitetura. Esta pivotagem estratégica do nosso stack tecnológico foi motivada pelo reconhecimento de que uma solução mais confiável e menos complexa poderia ser alcançada através da redução de dependências externas e da escolha de ferramentas e serviços que oferecessem maior integração e simplicidade operacional. Assim, optamos por revisitar e refinar nossa abordagem, concentrando-nos em soluções que mantivessem a robustez e a escalabilidade, mas com uma ênfase renovada na confiabilidade e na facilidade de manutenção.

Essa decisão de simplificar não foi tomada levianamente, mas sim como resultado de uma avaliação cuidadosa dos trade-offs envolvidos. Acreditamos firmemente que, ao reduzir a complexidade do nosso sistema, poderemos não apenas melhorar a confiabilidade e a eficiência operacional, mas também facilitar a interação com os usuários finais e os gestores públicos, mantendo o foco na nossa missão de promover um impacto positivo no enfrentamento da degradação ambiental urbana.

## A nova arquitetura


Em resposta aos desafios enfrentados e às necessidades identificadas nas fases anteriores do nosso projeto colaborativo entre o Instituto de Tecnologia e Liderança (INTELI) e a PRODAM, implementamos uma nova arquitetura que visa simplificar o desenvolvimento e operação, ao mesmo tempo em que reduz os custos. Esta reformulação da nossa estrutura tecnológica reflete um compromisso com a eficiência, a escalabilidade e a acessibilidade, fundamentos essenciais para o sucesso de nossa iniciativa de monitoramento ambiental urbano.

**Broker HiveMQ para IoT:** Optamos pelo uso do broker HiveMQ para a gestão de comunicações MQTT entre os dispositivos IoT. A escolha por HiveMQ, especialmente com autenticação via usuário e senha, representa uma alternativa simplificada e econômica comparada ao uso do AWS IoT Core. Essa decisão não apenas facilita o uso, por sua compatibilidade e facilidade de integração com diversos dispositivos e sistemas, mas também permite uma redução significativa de custos, eliminando a necessidade de investir em soluções mais caras sem comprometer a segurança e a confiabilidade das comunicações IoT.

**Kafka da Confluent:** A adoção do Kafka, oferecido pela Confluent, como nosso sistema de event streaming é fundamental para o processamento eficiente e em tempo real dos dados coletados. O Kafka se destaca pela sua capacidade de gerenciar grandes volumes de dados, fornecendo uma solução robusta para o processamento e análise de informações ambientais. Esta escolha nos permite construir uma arquitetura capaz de suportar a alta demanda de dados, com a flexibilidade e escalabilidade necessárias para o nosso projeto.

**MongoDB Atlas:** Para o armazenamento de dados, optamos pelo MongoDB Atlas, uma plataforma de banco de dados como serviço (DBaaS) que oferece alta disponibilidade, automação de backup e recuperação de desastres, entre outras características. O uso do MongoDB Atlas simplifica a gestão do banco de dados, permitindo uma escalabilidade fácil e um desempenho confiável, tudo isso com custos previsíveis e competitivos. Esta escolha reflete nosso compromisso com a eficiência e a segurança no armazenamento dos dados coletados.

**Metabase em uma EC2 com Autoscaler:** A implementação do Metabase para visualização e análise de dados em uma instância EC2 da AWS com capacidade de autoscaling representa uma solução inovadora e custo-efetiva para a análise de dados. O Metabase, uma ferramenta open-source de business intelligence, combinado com a flexibilidade e a escalabilidade da infraestrutura AWS EC2, permite uma análise de dados poderosa e acessível. A funcionalidade de autoscaling garante que a plataforma possa se ajustar automaticamente à demanda, otimizando os custos e assegurando que o desempenho não seja comprometido durante picos de uso.

### Vantagens da Nova Arquitetura
Esta nova configuração arquitetônica oferece várias vantagens em termos de facilidade de uso, custo e eficiência. A escolha de tecnologias e plataformas líderes de mercado, conhecidas por sua robustez e escalabilidade, juntamente com uma estratégia de custo otimizado, permite-nos enfrentar os desafios de monitoramento ambiental de forma mais eficaz. A simplificação do stack tecnológico não apenas facilita a gestão e a operação do sistema como um todo, mas também assegura uma maior confiabilidade e disponibilidade dos serviços, essenciais para o sucesso de iniciativas de cidades inteligentes e sustentáveis. Através desta abordagem, estamos confiantes em nossa capacidade de fornecer uma solução de monitoramento ambiental que é não apenas tecnologicamente avançada, mas também acessível e sustentável a longo prazo.



## Diagrama de Blocos da Arquitetura - v4.0

![alt text](<../../static/img/Diagrama de blocos - Cloud-v4.png>)

### Descrição dos Componentes Anteriores

- **Cliente MQTT**: Dispositivo que publica mensagens em tópicos MQTT. No contexto do projeto, o cliente MQTT é um simulador de um dispositivo IoT.
- **Broker MQTT**: Servidor que gerencia a comunicação entre os clientes MQTT. No contexto do projeto, o broker MQTT é o serviço AWS IoT Core. A escolha do Iot Core se deu pela sua escalabilidade, segurança e integração com outros serviços da AWS, ao qual no próprio processo de configuração de um dispositivo, é possível criar regras para processar mensagens e armazená-las em outros serviços.
- **AWS IoT Core**: Serviço da AWS que gerencia a comunicação entre dispositivos IoT e a nuvem. O AWS IoT Core permite a conexão segura de dispositivos com a nuvem, além de oferecer recursos para processar e armazenar mensagens.
- **Amazon EKS**: Serviço da AWS que gerencia clusters de contêineres. O EKS foi escolhido para hospedar a aplicação web por sua escalabilidade, segurança e integração com outros serviços da AWS.
- **EC2**: Serviço da AWS que fornece capacidade de computação na nuvem. O EC2 foi escolhido para estar acoplado ao EKS e hospedar os nós do Kubernetes e seus respectivos pods.

### Novos Componentes
- **Amazon Simple Queue Service (SQS)**: Serviço de mensagens gerenciado da AWS que permite a comunicação entre diferentes partes de um sistema. O SQS foi escolhido para criar uma fila de mensagens entre o AWS IoT Core e o AWS Lambda para garantir a entrega de mensagens.
- **Lambda**: Serviço da AWS que permite a execução de código sem a necessidade de provisionar ou gerenciar servidores. O Lambda foi escolhido para processar as mensagens recebidas pelo AWS IoT Core e enviá-las para o Confluent Cloud.
- **Confluent Cloud**: Serviço de streaming de dados gerenciado que permite a ingestão, transformação e armazenamento de dados em tempo real. O Confluent Cloud foi escolhido para processar e armazenar os dados coletados dos dispositivos IoT.
- **MongoDB Atlas**: Serviço de banco de dados gerenciado que permite o armazenamento de dados em nuvem. O MongoDB Atlas foi escolhido para armazenar os dados processados pelo Confluent Cloud.

## Diagrama de Implantação - v2.0

Um Diagrama UML (Unified Modeling Language ou Linguagem Unificada de Modelagem) é uma forma padronizada de visualizar o design de um sistema. UML é uma linguagem de modelagem de sistemas que permite a representação gráfica de um sistema por meio de diferentes tipos de diagramas. Com a UML, os desenvolvedores e stakeholders podem entender, alterar, construir e documentar aspectos de um sistema de software.

![alt text](<../../static/img/Diagrama UML - Implatação-v2.png>)

### Dispositivo (Publisher)

- O dispositivo contém sensores para coletar dados ambientais como qualidade do ar e temperatura.
- A autenticação é garantida por meio de certificados SHA-256 e chaves (pública e privada) SHA-256 para comunicação segura.
- Os dados coletados são enviados para a AWS através do protocolo MQTT.

### Nuvem (AWS)

- No serviço AWS IoT Core, uma regra é definida para processar dados recebidos do tópico 'topic/region/+'.
- O AWS IoT Core atua como um ponto central para receber e encaminhar dados.

### Processamento de Dados (AWS Lambda)
- O AWS Lambda é acionado pela SQS para processar os dados recebidos do AWS IoT Core.
- O AWS Lambda envia os dados para o Confluent Cloud para processamento e armazenamento.

### Processamento de Dados (Confluent Cloud)

- O Confluent Cloud é usado para processar e armazenar os dados recebidos do AWS Lambda.
- Esses dados são armazenados no MongoDB Atlas para consulta e análise.

### Banco de Dados (MongoDB)

- Os dados são armazenados no MongoDB, um banco de dados NoSQL, para armazenamento e recuperação eficiente.

### Visualização (Dashboard)

- O serviço EKS (Elastic Kubernetes Service) gerencia os aplicativos de visualização de dados.
- Grafana e Prometheus são integrados para a monitorização e visualização em tempo real dos dados.
- O MongoDB Atlas é consultado para obter dados para exibição no dashboard.
- O serviço EC2, com uma instância T3.Medium, é utilizado para hospedar e executar as aplicações necessárias para o funcionamento do dashboard.

## Segurança no banco de dados e dashboard

Para garantir a segurança nas conexões entre o banco de dados, o dashboard e o resto do sistema em nossa solução de arquitetura IoT baseada na AWS, implementamos diversas medidas de segurança. Abaixo estão os detalhes de como cada segmento da arquitetura contribui para a integridade, confidencialidade e disponibilidade dos dados e serviços.

![alt text](../../static/img/security.png)

### Segurança do Dispositivo ao AWS IoT Core

A segurança da comunicação entre dispositivos IoT e o AWS IoT Core é assegurada pelo uso do protocolo TLS (Transport Layer Security), o que garante uma conexão autenticada e segura. Cada dispositivo utiliza um certificado X.509 para estabelecer sua identidade, o qual é verificado pelo AWS IoT Core antes de qualquer comunicação. Além disso, políticas de autorização específicas são aplicadas para restringir o que cada dispositivo pode fazer (como publicar ou assinar tópicos MQTT específicos).

### Autorização e Controle de Acesso

Utilizamos o AWS Identity and Access Management (IAM) para gerenciar as permissões de acesso aos recursos da AWS. O IAM Role, ou papel do IAM, começa com a definição de políticas que especificam quais serviços e ações o usuário ou serviço tem permissão para usar. No caso do AWS Glue e outras integrações, isso significa acesso controlado para executar operações de ETL (Extrair, Transformar e Carregar) e consultar dados.

### Segurança no Banco de Dados

O MongoDB Atlas, como serviço de banco de dados gerenciado, oferece várias camadas de segurança para proteger os dados armazenados. Isso inclui criptografia de dados em repouso e em trânsito, autenticação baseada em certificados e controle de acesso baseado em funções. Além disso, o MongoDB Atlas oferece a capacidade de criar listas de permissões de IP para restringir o acesso ao banco de dados a partir de endereços IP específicos. Para o projeto, essas medidas de segurança são essenciais para garantir a integridade e confidencialidade dos dados armazenados.

#### Whitelisting e Segurança de Rede

Para o projeto, a configuração de listas de permissões de IP no MongoDB Atlas é uma camada adicional de segurança para restringir o acesso ao banco de dados a partir de endereços IP específicos. Isso significa que apenas os endereços IP autorizados podem se conectar ao banco de dados, minimizando assim o risco de acesso não autorizado. O acesso ao banco é liberado para todos os endereços IP da Internet, mas para a conexão com o banco de dados, é necessário um usuário e senha válidos. Isso ocorre porque o MongoDB Atlas é um serviço gerenciado e, por padrão, não permite conexões diretas sem autenticação, além do ambiente de produção ser protegido por um firewall.

### Segurança no Dashboard e Visualização de Dados

Para o dashboard hospedado no Amazon EKS, o acesso é protegido através do controle de acesso ao Kubernetes, integrado ao IAM da AWS. Isso significa que apenas usuários com as credenciais corretas podem acessar o Grafana. Além disso, o login do Grafana é protegido por autenticação, que pode ser configurada para usar autenticação de múltiplos fatores (MFA) para uma camada adicional de segurança.

Adicionalmente, a comunicação entre serviços, como entre o Grafana e o Prometheus ou o MongoDB, é protegida por meio de políticas de segurança que asseguram que apenas tráfego autorizado possa fluir entre esses serviços, minimizando assim o risco de interceptação ou manipulação de dados.

### Conclusão

Essas medidas de segurança são projetadas para trabalhar em conjunto, formando uma cadeia de segurança ininterrupta desde a coleta de dados até a visualização. Com cada componente desempenhando seu papel específico, estamos comprometidos em fornecer uma arquitetura segura e confiável para o processamento e análise de dados IoT.
