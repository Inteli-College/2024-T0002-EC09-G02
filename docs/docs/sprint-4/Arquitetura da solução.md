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

## Diagrama de Blocos da Arquitetura - v5.0


Em resposta aos desafios enfrentados e às necessidades identificadas nas fases anteriores do nosso projeto colaborativo entre o Instituto de Tecnologia e Liderança (INTELI) e a PRODAM, implementamos uma nova arquitetura que visa simplificar o desenvolvimento e operação, ao mesmo tempo em que reduz os custos. Esta reformulação da nossa estrutura tecnológica reflete um compromisso com a eficiência, a escalabilidade e a acessibilidade, fundamentos essenciais para o sucesso de nossa iniciativa de monitoramento ambiental urbano.

**Broker HiveMQ para IoT:** Optamos pelo uso do broker HiveMQ para a gestão de comunicações MQTT entre os dispositivos IoT. A escolha por HiveMQ, especialmente com autenticação via usuário e senha, representa uma alternativa simplificada e econômica comparada ao uso do AWS IoT Core. Essa decisão não apenas facilita o uso, por sua compatibilidade e facilidade de integração com diversos dispositivos e sistemas, mas também permite uma redução significativa de custos, eliminando a necessidade de investir em soluções mais caras sem comprometer a segurança e a confiabilidade das comunicações IoT.

**Kafka da Confluent:** A adoção do Kafka, oferecido pela Confluent, como nosso sistema de event streaming é fundamental para o processamento eficiente e em tempo real dos dados coletados. O Kafka se destaca pela sua capacidade de gerenciar grandes volumes de dados, fornecendo uma solução robusta para o processamento e análise de informações ambientais. Esta escolha nos permite construir uma arquitetura capaz de suportar a alta demanda de dados, com a flexibilidade e escalabilidade necessárias para o nosso projeto.

**MongoDB Atlas:** Para o armazenamento de dados, optamos pelo MongoDB Atlas, uma plataforma de banco de dados como serviço (DBaaS) que oferece alta disponibilidade, automação de backup e recuperação de desastres, entre outras características. O uso do MongoDB Atlas simplifica a gestão do banco de dados, permitindo uma escalabilidade fácil e um desempenho confiável, tudo isso com custos previsíveis e competitivos. Esta escolha reflete nosso compromisso com a eficiência e a segurança no armazenamento dos dados coletados.

**Metabase em uma EC2 com Autoscaler:** A implementação do Metabase para visualização e análise de dados em uma instância EC2 da AWS com capacidade de autoscaling representa uma solução inovadora e custo-efetiva para a análise de dados. O Metabase, uma ferramenta open-source de business intelligence, combinado com a flexibilidade e a escalabilidade da infraestrutura AWS EC2, permite uma análise de dados poderosa e acessível. A funcionalidade de autoscaling garante que a plataforma possa se ajustar automaticamente à demanda, otimizando os custos e assegurando que o desempenho não seja comprometido durante picos de uso.

## Diagrama de Implantação - v4.0

Um diagrama de implantação é um tipo de diagrama UML (Unified Modeling Language) que representa a arquitetura física de um sistema, ou seja, como os seus componentes são distribuídos em hardware e software. Ele mostra como os diferentes elementos do sistema, como nós de processamento, dispositivos de armazenamento e software, estão interconectados e implantados em diversos nós físicos, como servidores, computadores pessoais, dispositivos móveis, entre outros.

A funcionalidade principal de um diagrama de implantação é fornecer uma visão geral da infraestrutura física do sistema, ajudando os desenvolvedores, arquitetos de sistemas e administradores a entender como os componentes do sistema são distribuídos e como eles se comunicam entre si. Isso é útil para planejar a implantação do sistema em um ambiente real, dimensionar os recursos necessários, identificar possíveis pontos de falha e otimizar a comunicação entre os componentes.

![Diagrama de Implantação 4](<../../static/img/DiagramaImplantacao4.png>)

## Diagrama de sequência

O diagrama ilustra o fluxo de dados de um dispositivo IoT até a apresentação em um dashboard de análise, utilizando uma arquitetura de processamento de dados baseada em eventos. 

Este fluxo assegura que os dados capturados pelos dispositivos IoT sejam transmitidos de maneira segura e eficiente para sistemas de armazenamento e análise, permitindo insights oportunos e a tomada de decisão baseada em dados. A integração do HiveMQ com o Kafka Confluent e MongoDB facilita o processamento e análise escaláveis de eventos em tempo real, enquanto o Metabase permite a visualização de dados de uma forma acessível para os usuários finais.

![Diagrama de Sequência 4](<../../static/img/sequence-sprint4.png>)

## Vantagens da nova arquitetura
Esta nova configuração arquitetônica oferece várias vantagens em termos de facilidade de uso, custo e eficiência. A escolha de tecnologias e plataformas líderes de mercado, conhecidas por sua robustez e escalabilidade, juntamente com uma estratégia de custo otimizado, permite-nos enfrentar os desafios de monitoramento ambiental de forma mais eficaz. A simplificação do stack tecnológico não apenas facilita a gestão e a operação do sistema como um todo, mas também assegura uma maior confiabilidade e disponibilidade dos serviços, essenciais para o sucesso de iniciativas de cidades inteligentes e sustentáveis. Através desta abordagem, estamos confiantes em nossa capacidade de fornecer uma solução de monitoramento ambiental que é não apenas tecnologicamente avançada, mas também acessível e sustentável a longo prazo.
