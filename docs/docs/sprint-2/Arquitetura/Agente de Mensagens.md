sidebar_position: 2
slug: '/sprint_2/arquitetura/agente_de_mensagens'
label: "Agente de Mensagens"
---

Quando iniciamos um projeto de implementação de smart cities, é fundamental escolher uma plataforma eficiente para o monitoramento dos diversos parâmetros que visam garantir transparência e qualidade de vida aos cidadãos. Nesse contexto, optamos por adotar o AWS IoT Core como nosso agente de mensagens.

Ao explorar o AWS IoT Core, entendemos uma plataforma robusta e dinâmica, projetada para facilitar a comunicação entre dispositivos conectados em tempo real. Nesta seção introdutória, exploraremos não apenas o que esse serviço oferece, mas também como ele será integrado em nosso projeto, destacando suas funcionalidades chave e seu papel essencial na construção de cidades inteligentes.

# Infraestrutura Escolhida

Ao optarmos por uma infraestrutura em nuvem para nosso projeto, consideramos uma série de fatores cruciais alinhados aos objetivos e requisitos específicos delineados. Aqui estão algumas razões fundamentais que nos levaram a essa escolha:

## **1. Escalabilidade e Flexibilidade**: 
Com uma infraestrutura em nuvem, podemos dimensionar nossos recursos de acordo com as demandas do projeto. Como nosso objetivo é monitorar uma rede abrangente e heterogênea de sensores, que podem variar em quantidade e complexidade, a capacidade de dimensionamento automático da nuvem é essencial para garantir que possamos lidar com o crescimento dos dados e dos dispositivos de forma eficiente.

## **2. Confiabilidade e Disponibilidade**: 
A AWS é conhecida por sua confiabilidade e disponibilidade de serviços. Ao utilizar sua infraestrutura, podemos garantir alta disponibilidade para os dados coletados pelos sensores, garantindo que os insights gerados estejam sempre acessíveis para gestores urbanos, pesquisadores e cidadãos. Isso é crucial para a tomada de decisões informadas e o desenvolvimento de políticas públicas eficazes.

## **3. Segurança Avançada**: 
A AWS oferece uma gama de serviços e recursos de segurança para proteger os dados em trânsito e em repouso. Dado o caráter sensível dos dados ambientais que estamos coletando, é imperativo garantir que todas as medidas de segurança necessárias estejam em vigor. A AWS IoT Core, por exemplo, fornece recursos avançados de segurança para comunicação entre os dispositivos e a nuvem.

## **4. Integração com Outros Serviços**: 
A AWS oferece um vasto ecossistema de serviços que podem ser integrados facilmente. Isso nos permite aproveitar uma variedade de ferramentas e recursos para análise de dados, visualização, processamento em tempo real e muito mais. Essa integração simplificada nos permite construir uma solução completa e robusta para atender às necessidades do projeto.

## **5. Economia de Custos**: 
Embora os custos possam variar dependendo do uso e da escala, a infraestrutura em nuvem muitas vezes oferece vantagens econômicas em comparação com a construção e manutenção de uma infraestrutura local. Além disso, a AWS oferece modelos de precificação flexíveis que nos permitem pagar apenas pelos recursos que utilizamos, o que pode ser mais econômico a longo prazo.

# AWS IoT Core
O AWS IoT Core é um serviço de nuvem para Internet das Coisas que visa conectar e gerenciar dispositivos. Com ele, conseguimos processar e rotear trilhões de mensagens para endpoints da AWS e/ou outros dispositivos de forma confiável e segura.

## Vantagens
### 1. Suporte para Ecossistema de Parceiros e Ferramentas:
 Ao adotar o AWS IoT Core, temos a vantagem de acessar um vasto ecossistema de parceiros e ferramentas complementares. Isso nos permite integrar facilmente soluções de terceiros, como plataformas de análise de dados especializadas em IoT ou serviços de automação, enriquecendo nossa solução com funcionalidades adicionais sem a necessidade de desenvolvimento interno extensivo.
 ### 2. Facilidade de Integração com Protocolos de Comunicação Padrão: 
 O AWS IoT Core suporta uma ampla variedade de protocolos de comunicação padrão da indústria, como MQTT e HTTP, facilitando a integração com uma ampla gama de dispositivos IoT existentes. Isso nos permite aproveitar a flexibilidade e a interoperabilidade para agregar dados de diferentes fontes de forma eficiente.

## Desvantagens
### 1. Complexidade de Configuração e Gerenciamento: 
Embora o AWS IoT Core ofereça uma variedade de recursos poderosos, configurá-los e gerenciá-los adequadamente pode ser complexo, especialmente para equipes sem experiência prévia em IoT ou na plataforma AWS. Isso pode exigir tempo e esforço adicionais para aprender e implementar corretamente as melhores práticas.

### 2. Possíveis Limitações de Personalização e Flexibilidade: 
Embora o AWS IoT Core ofereça uma ampla gama de recursos, pode haver casos em que precisamos de funcionalidades altamente personalizadas ou específicas do domínio que não são diretamente suportadas pelo serviço. Nesses casos, pode ser necessário desenvolver soluções personalizadas ou recorrer a serviços adicionais da AWS para atender aos requisitos específicos do projeto.

# Funcionamento do Broker
## Protocolo de comunicação
O protocolo MQTT (Message Queuing Telemetry Transport) desempenha um papel fundamental no nosso projeto de monitoramento ambiental usando o AWS IoT Core. É um protocolo leve e eficiente projetado para a comunicação entre dispositivos IoT e a nuvem.

Basicamente, no MQTT, os dispositivos sensores enviam mensagens para a nuvem através de "tópicos". Cada tipo de sensor tem seu próprio tópico, como "sensor/temperatura" ou "sensor/umidade". Os clientes na nuvem, como o AWS IoT Core, se inscrevem nesses tópicos para receber as mensagens relevantes.

O MQTT oferece diferentes níveis de garantia de entrega das mensagens, garantindo que os dados dos sensores sejam transmitidos de forma confiável. Além disso, ele suporta assinaturas selvagens, o que permite aos clientes assinar vários tópicos usando padrões específicos.

No nosso projeto, os dispositivos sensores enviarão dados como qualidade do ar, umidade do solo e ruído urbano por meio de mensagens MQTT para o AWS IoT Core. Esses dados serão processados e armazenados na nuvem para análise e visualização, contribuindo para a tomada de decisões informadas sobre questões ambientais e urbanas.
## Tópicos

## Monitoramento

# Segurança
## Autenticação
## Políticas
