---
sidebar_position: 1
slug: 'Arquitetura da solução'
---
# Mudanças na Arquitetura

A solução anterior proposta é uma arquitetura IoT robusta que utiliza serviços gerenciados da AWS para coletar, processar e visualizar dados provenientes de dispositivos IoT simulados. Essa solução é composta por vários componentes interconectados, cada um desempenhando um papel fundamental no fluxo de dados. Vamos explorar brevemente as mudanças propostas na arquitetura da solução ao longo da sprint 4.

## Proposta Inicial na Sprint 4

A solução inicial proposta para o projeto, foi de utilização parcila dos serviços da AWS, com o intuito de aproveitar sua escalabilidade e a facilidade de implementação por meio de ferramentas como Terraform e GitHub Actions. A arquitetura proposta era baseada em serviços gerenciados da AWS, como o AWS IoT Core, Amazon EC2, Amazon RDS e Amazon S3, para coletar, processar e armazenar dados provenientes de dispositivos IoT simulados. A escolha desses serviços foi motivada pela sua confiabilidade, escalabilidade e integração com outras ferramentas da AWS. Abaixo, temos o diagrama de blocos da arquitetura proposta na Sprint 4.

### Diagrama de Blocos da Arquitetura - v4.0

![alt text](<../../static/img/Diagrama de blocos - Cloud-v5.png>)

#### Descrição dos Componentes Anteriores

- **Cliente MQTT**: Dispositivo que publica mensagens em tópicos MQTT. No contexto do projeto, o cliente MQTT é um simulador de um dispositivo IoT.
- **Broker MQTT**: Servidor que gerencia a comunicação entre os clientes MQTT. No contexto do projeto, o broker MQTT é o serviço AWS IoT Core. A escolha do Iot Core se deu pela sua escalabilidade, segurança e integração com outros serviços da AWS, ao qual no próprio processo de configuração de um dispositivo, é possível criar regras para processar mensagens e armazená-las em outros serviços.
- **AWS IoT Core**: Serviço da AWS que gerencia a comunicação entre dispositivos IoT e a nuvem. O AWS IoT Core permite a conexão segura de dispositivos com a nuvem, além de oferecer recursos para processar e armazenar mensagens.
- **Amazon EC2**: Serviço da AWS que fornece capacidade de computação na nuvem. O EC2 foi escolhido para hospedar o nosso novo dashboard através de um contâiner Docker juntamente com um Load Balance.

#### Novos Componentes
- **Amazon Simple Queue Service (SQS)**: Serviço de mensagens gerenciado da AWS que permite a comunicação entre diferentes partes de um sistema. O SQS foi escolhido para criar uma fila de mensagens entre o AWS IoT Core e o AWS Lambda para garantir a entrega de mensagens.
- **AWS Lambda**: Serviço da AWS que permite a execução de código sem a necessidade de provisionar ou gerenciar servidores. O Lambda foi escolhido para processar as mensagens recebidas pelo AWS IoT Core e enviá-las para o Confluent Cloud.
- **Confluent Cloud**: Serviço de streaming de dados gerenciado que permite a ingestão, transformação e armazenamento de dados em tempo real. O Confluent Cloud foi escolhido para processar e armazenar os dados coletados dos dispositivos IoT.
- **MongoDB Atlas**: Serviço de banco de dados gerenciado que permite o armazenamento de dados em nuvem. O MongoDB Atlas foi escolhido para armazenar os dados processados pelo Confluent Cloud.
- **Amazon Elastic Load Balancer(ELB)**: Serviço de distribuição de tráfego de rede para aprimorar a escalabilidade da aplicação(nosso dashboard). O Load Balancer foi escolhido para melhorar a escalabilidade e estabilidade do nosso dashboard com uma grande quantidade de acessos simultâneos.

### Diagrama de Implantação - v3.0

Um Diagrama UML (Unified Modeling Language ou Linguagem Unificada de Modelagem) é uma forma padronizada de visualizar o design de um sistema. UML é uma linguagem de modelagem de sistemas que permite a representação gráfica de um sistema por meio de diferentes tipos de diagramas. Com a UML, os desenvolvedores e stakeholders podem entender, alterar, construir e documentar aspectos de um sistema de software.

![alt text](<../../static/img/Diagrama UML - Implatação-v3.jpeg>)

## Proposta Final na Sprint 4

Ao avançarmos na jornada de desenvolvimento do nosso projeto colaborativo entre o Instituto de Tecnologia e Liderança (INTELI) e a PRODAM, chegamos a um ponto crítico durante a Sprint 4 que nos levou a repensar fundamentalmente nossa abordagem arquitetônica. A necessidade de adaptação não apenas ressaltou nossa capacidade de inovação diante dos desafios, mas também enfatizou nossa dedicação em oferecer uma solução tecnológica robusta e confiável para o monitoramento da degradação ambiental urbana.

Inicialmente, nossa arquitetura era amplamente baseada em serviços da AWS, com o intuito de aproveitar sua escalabilidade e a facilidade de implementação por meio de ferramentas como Terraform e GitHub Actions. Esta abordagem, embora promissora, começou a revelar complexidades crescentes, especialmente com a introdução de um sistema de event streaming baseado em disco, como o Kafka. Esta adição foi inicialmente vista como uma melhoria essencial para o processamento e análise de dados em tempo real.

Entretanto, a integração do Kafka, juntamente com o HiveMQ para a comunicação entre dispositivos IoT e o MongoDB para armazenamento de dados, embora poderosa, introduziu uma complexidade que começou a contrariar nossos objetivos de eficiência e simplicidade. As limitações encontradas com a AWS Academy, especialmente a indisponibilidade do Amazon MSK (Kafka Managed Service) como uma oferta gratuita, nos obrigaram a considerar alternativas que resultaram em uma arquitetura significativamente mais complexa, envolvendo integrações complicadas com serviços externos e a substituição de ferramentas de visualização de dados, como a transição do Grafana para o Metabase.

Diante desses desafios e da crescente complexidade, tomamos a decisão consciente de simplificar nossa arquitetura. Esta pivotagem estratégica do nosso stack tecnológico foi motivada pelo reconhecimento de que uma solução mais confiável e menos complexa poderia ser alcançada através da redução de dependências externas e da escolha de ferramentas e serviços que oferecessem maior integração e simplicidade operacional. Assim, optamos por revisitar e refinar nossa abordagem, concentrando-nos em soluções que mantivessem a robustez e a escalabilidade, mas com uma ênfase renovada na confiabilidade e na facilidade de manutenção.

Essa decisão de simplificar não foi tomada levianamente, mas sim como resultado de uma avaliação cuidadosa dos trade-offs envolvidos. Acreditamos firmemente que, ao reduzir a complexidade do nosso sistema, poderemos não apenas melhorar a confiabilidade e a eficiência operacional, mas também facilitar a interação com os usuários finais e os gestores públicos, mantendo o foco na nossa missão de promover um impacto positivo no enfrentamento da degradação ambiental urbana.

### Diagrama de Blocos da Arquitetura - v5.0

![alt text](<../../static/img/Diagrama de blocos v5.0 - MQTT.png>)

Em resposta aos desafios enfrentados e às necessidades identificadas nas fases anteriores do nosso projeto colaborativo entre o Instituto de Tecnologia e Liderança (INTELI) e a PRODAM, implementamos uma nova arquitetura que visa simplificar o desenvolvimento e operação, ao mesmo tempo em que reduz os custos. Esta reformulação da nossa estrutura tecnológica reflete um compromisso com a eficiência, a escalabilidade e a acessibilidade, fundamentos essenciais para o sucesso de nossa iniciativa de monitoramento ambiental urbano.

**Broker HiveMQ para IoT:** Optamos pelo uso do broker HiveMQ para a gestão de comunicações MQTT entre os dispositivos IoT. A escolha por HiveMQ, especialmente com autenticação via usuário e senha, representa uma alternativa simplificada e econômica comparada ao uso do AWS IoT Core. Essa decisão não apenas facilita o uso, por sua compatibilidade e facilidade de integração com diversos dispositivos e sistemas, mas também permite uma redução significativa de custos, eliminando a necessidade de investir em soluções mais caras sem comprometer a segurança e a confiabilidade das comunicações IoT.

**Kafka da Confluent:** A adoção do Kafka, oferecido pela Confluent, como nosso sistema de event streaming é fundamental para o processamento eficiente e em tempo real dos dados coletados. O Kafka se destaca pela sua capacidade de gerenciar grandes volumes de dados, fornecendo uma solução robusta para o processamento e análise de informações ambientais. Esta escolha nos permite construir uma arquitetura capaz de suportar a alta demanda de dados, com a flexibilidade e escalabilidade necessárias para o nosso projeto.

**MongoDB Atlas:** Para o armazenamento de dados, optamos pelo MongoDB Atlas, uma plataforma de banco de dados como serviço (DBaaS) que oferece alta disponibilidade, automação de backup e recuperação de desastres, entre outras características. O uso do MongoDB Atlas simplifica a gestão do banco de dados, permitindo uma escalabilidade fácil e um desempenho confiável, tudo isso com custos previsíveis e competitivos. Esta escolha reflete nosso compromisso com a eficiência e a segurança no armazenamento dos dados coletados.

**Metabase em uma EC2 com Autoscaler:** A implementação do Metabase para visualização e análise de dados em uma instância EC2 da AWS com capacidade de autoscaling representa uma solução inovadora e custo-efetiva para a análise de dados. O Metabase, uma ferramenta open-source de business intelligence, combinado com a flexibilidade e a escalabilidade da infraestrutura AWS EC2, permite uma análise de dados poderosa e acessível. A funcionalidade de autoscaling garante que a plataforma possa se ajustar automaticamente à demanda, otimizando os custos e assegurando que o desempenho não seja comprometido durante picos de uso.

### Diagrama de Implantação - v4.0

Um diagrama de implantação é um tipo de diagrama UML (Unified Modeling Language) que representa a arquitetura física de um sistema, ou seja, como os seus componentes são distribuídos em hardware e software. Ele mostra como os diferentes elementos do sistema, como nós de processamento, dispositivos de armazenamento e software, estão interconectados e implantados em diversos nós físicos, como servidores, computadores pessoais, dispositivos móveis, entre outros.

A funcionalidade principal de um diagrama de implantação é fornecer uma visão geral da infraestrutura física do sistema, ajudando os desenvolvedores, arquitetos de sistemas e administradores a entender como os componentes do sistema são distribuídos e como eles se comunicam entre si. Isso é útil para planejar a implantação do sistema em um ambiente real, dimensionar os recursos necessários, identificar possíveis pontos de falha e otimizar a comunicação entre os componentes.

![Diagrama de Implantação 4](<../../static/img/DiagramaImplantacao4.png>)

### Diagrama de sequência

O diagrama ilustra o fluxo de dados de um dispositivo IoT até a apresentação em um dashboard de análise, utilizando uma arquitetura de processamento de dados baseada em eventos. 

Este fluxo assegura que os dados capturados pelos dispositivos IoT sejam transmitidos de maneira segura e eficiente para sistemas de armazenamento e análise, permitindo insights oportunos e a tomada de decisão baseada em dados. A integração do HiveMQ com o Kafka Confluent e MongoDB facilita o processamento e análise escaláveis de eventos em tempo real, enquanto o Metabase permite a visualização de dados de uma forma acessível para os usuários finais.

![Diagrama de Sequência 4](<../../static/img/sequence-sprint4.png>)

## Vantagens da nova arquitetura
Esta nova configuração arquitetônica oferece várias vantagens em termos de facilidade de uso, custo e eficiência. A escolha de tecnologias e plataformas líderes de mercado, conhecidas por sua robustez e escalabilidade, juntamente com uma estratégia de custo otimizado, permite-nos enfrentar os desafios de monitoramento ambiental de forma mais eficaz. A simplificação do stack tecnológico não apenas facilita a gestão e a operação do sistema como um todo, mas também assegura uma maior confiabilidade e disponibilidade dos serviços, essenciais para o sucesso de iniciativas de cidades inteligentes e sustentáveis. Através desta abordagem, estamos confiantes em nossa capacidade de fornecer uma solução de monitoramento ambiental que é não apenas tecnologicamente avançada, mas também acessível e sustentável a longo prazo.


## Conclusão

A nova arquitetura proposta para o projeto de monitoramento ambiental urbano representa uma evolução significativa em relação às versões anteriores, refletindo um compromisso renovado com a eficiência, a escalabilidade e a acessibilidade. A simplificação do stack tecnológico, a escolha de soluções líderes de mercado e a estratégia de custo otimizado são elementos-chave que nos permitem enfrentar os desafios de monitoramento ambiental de forma mais eficaz. Através desta abordagem, estamos confiantes em nossa capacidade de fornecer uma solução tecnológica robusta e confiável, capaz de promover um impacto positivo no enfrentamento da degradação ambiental urbana. Acreditamos que esta nova arquitetura nos coloca em uma posição forte para atender às necessidades dos usuários finais e dos gestores públicos, ao mesmo tempo em que mantemos o foco em nossa missão de promover cidades mais inteligentes e sustentáveis.