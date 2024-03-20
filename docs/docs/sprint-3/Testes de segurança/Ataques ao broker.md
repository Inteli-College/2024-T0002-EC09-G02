---
sidebar_position: 2
slug: '/sprint_3/Testes de Segurança/Ataques ao broker'
label: 'Ataques ao broker'
---

# Ataques ao broker

Este documento descreve potenciais ataques direcionados a brokers em sistemas de IoT, especificamente ao AWS IoT Core, abordando as vulnerabilidades em termos de confidencialidade, integridade e disponibilidade. Para cada tipo de ataque, detalhamos as pré-condições necessárias, os passos para a execução do ataque, e as possíveis pós-condições resultantes da ação maliciosa.

## Ataque à Confidencialidade: Forjamento de Certificados

### Pré-condição:
Um atacante com sofisticadas habilidades em criptografia e programação tem a intenção de comprometer a confidencialidade das comunicações entre os dispositivos IoT e o AWS IoT Core. Para tal, ele deve ter à disposição ferramentas capazes de gerar certificados digitais que aparentem ser legítimos. O atacante também necessita de um meio de inserir esses certificados falsificados no ciclo de confiança dos dispositivos IoT ou do sistema que os verifica, como o AWS IoT Core. Isso pode envolver técnicas avançadas de engenharia social ou exploração de vulnerabilidades de segurança nas interfaces de gerenciamento de dispositivos ou na própria AWS.

### Passo a Passo:

1. **Geração de Certificado Falso:** O atacante cria um par de chaves criptográficas (pública e privada) e forja um certificado digital imitando os padrões X.509 usados nos sistemas legítimos.
2. **Inserção do Certificado Falso:** Ele usa técnicas de engenharia social, como phishing, para persuadir um administrador do sistema a instalar o certificado forjado ou explora uma vulnerabilidade de segurança que permite a inserção direta no sistema sem autenticação adequada.
3. **Interceptação de Comunicação:** Uma vez que o certificado falso é aceito pelo AWS IoT Core como autêntico, o atacante estabelece uma conexão segura TLS, assumindo a identidade de um dispositivo IoT confiável.
4. **Captura de Dados:** Com a conexão estabelecida, ele pode interceptar, visualizar e potencialmente modificar os dados em trânsito que deveriam estar protegidos pela criptografia TLS.

### Pós-condição:
Com o sucesso do ataque, o atacante terá a capacidade de acessar os dados em trânsito entre os dispositivos IoT e o AWS IoT Core. A confidencialidade dos dados é severamente comprometida, permitindo que o atacante visualize informações sensíveis que podem incluir dados operacionais, pessoais ou de negócios. O ataque pode permanecer não detectado por algum tempo se a presença do certificado falso não for revelada por uma auditoria de segurança ou por mecanismos automatizados de detecção de anomalias. Como resultado, isso pode levar a um comprometimento prolongado da privacidade dos dados, violações de segurança, e possíveis danos financeiros ou de reputação para a organização afetada.

## Ataque à Integridade: Comprometimento do Broker MQTT

### Pré-condição:
Para comprometer o AWS IoT Core, o atacante necessita de um conhecimento especializado em segurança de redes e sistemas distribuídos, além de ter habilidades para identificar e explorar vulnerabilidades não divulgadas, conhecidas como zero-days. Esse nível de conhecimento implica uma compreensão profunda dos protocolos de comunicação IoT, da arquitetura de serviços de nuvem e das práticas de segurança associadas. O atacante também precisa ter a capacidade de desenvolver ou adquirir um exploit que tire proveito dessas vulnerabilidades zero-day, o que requer acesso a comunidades de hacking, fóruns na dark web ou redes de contatos que possam fornecer tais informações.

### Passo a Passo:
1. **Identificação de Vulnerabilidades:** Através de pesquisa e análise de segurança, o atacante identifica uma vulnerabilidade zero-day no AWS IoT Core que possa ser explorada para manipular mensagens MQTT em trânsito. Isso pode envolver técnicas avançadas de engenharia reversa, testes de penetração ou o monitoramento de comunicações de rede para descobrir falhas não documentadas.↳
2. **Desenvolvimento do Exploit:** Com a vulnerabilidade identificada, o atacante desenvolve um exploit capaz de tirar proveito dessa falha. O exploit seria projetado para ser discretamente injetado em um ponto de entrada vulnerável do serviço AWS IoT Core, permitindo ao atacante manipular as mensagens MQTT que passam pelo broker sem ser detectado.
3. **Execução e Manipulação de Mensagens:** Utilizando o exploit desenvolvido, o atacante executa o ataque contra o AWS IoT Core, injetando ou modificando as mensagens MQTT em trânsito. Isso pode envolver a inserção de dados falsos, alteração de mensagens legítimas ou redirecionamento de mensagens para endpoints maliciosos. O objetivo é manipular os dados que são eventualmente armazenados no DynamoDB ou processados por outros componentes do sistema.
   
### Pós-condição:
Um ataque bem-sucedido ao broker MQTT do AWS IoT Core tem consequências significativas para a integridade dos dados do sistema IoT. As mensagens manipuladas podem levar à inserção de dados incorretos ou maliciosos no DynamoDB, comprometendo a precisão e a veracidade dos dados armazenados. Isso pode afetar adversamente os processos de tomada de decisão baseados em dados, análises de desempenho, e operações automatizadas que dependem da integridade dos dados. Além disso, a confiança na segurança do ecossistema IoT fica seriamente abalada, potencialmente expondo a organização a riscos operacionais, regulatórios e reputacionais. Medidas de mitigação, como a revisão de segurança e a implementação de patches ou atualizações de segurança, serão necessárias para restaurar a integridade do sistema e prevenir futuros ataques.

## Ataque à Disponibilidade: DDoS no Broker MQTT

### Pré-condição:
Para efetuar um ataque DDoS (Distributed Denial of Service) contra o AWS IoT Core, o atacante precisa ter sob seu controle uma rede substancial de máquinas comprometidas, conhecida como botnet. Isso geralmente é alcançado infiltrando-se em sistemas vulneráveis espalhados globalmente e utilizando essas máquinas como zumbis para gerar tráfego mal-intencionado. O atacante também deve possuir um entendimento avançado das capacidades de infraestrutura do AWS IoT Core, incluindo limites de escala, mecanismos de balanceamento de carga e estratégias de mitigação de DDoS da AWS, para planejar um ataque que possa efetivamente sobrecarregar o serviço.

### Passo a Passo
1. **Mobilização e Coordenação da Botnet:** O atacante coordena a botnet, distribuindo comandos específicos para que cada dispositivo comprometido inicie solicitações de conexão ao AWS IoT Core. Essa etapa envolve a seleção de vetores de ataque que possam gerar o maior impacto, como inundações SYN ou solicitações MQTT malformadas.
2. **Ajuste Dinâmico do Ataque:** Uma vez que o ataque está em andamento, o atacante monitora de perto o desempenho e a resposta do AWS IoT Core, utilizando qualquer feedback disponível - seja através da observação de mudanças no desempenho do serviço ou de comunicações da AWS sobre o estado do ataque. O atacante ajusta a taxa de solicitações, muda o tipo de vetor de ataque, ou alterna entre diferentes sub-redes da botnet para otimizar a eficácia do ataque e evitar ser completamente mitigado pelas defesas automáticas do AWS.
3. **Estratégias de Contorno de Mitigação:** Com o progresso do ataque, o atacante busca ativamente maneiras de contornar as medidas de mitigação de DDoS implementadas pela AWS. Isso pode incluir a variação do tráfego gerado pela botnet, a exploração de vulnerabilidades específicas para amplificar o ataque, ou a simulação de tráfego legítimo para dificultar a distinção entre tráfego malicioso e legítimo.

### Pós-condição
Um ataque DDoS bem-sucedido ao AWS IoT Core pode levar a uma série de consequências graves para as operações IoT dependentes desse serviço. A incapacidade de gerenciar efetivamente o tráfego entrante pode resultar em latência significativa ou na indisponibilidade total do broker MQTT, interrompendo a comunicação entre dispositivos IoT e a nuvem. Isso não apenas compromete a visibilidade e o controle sobre dispositivos IoT em tempo real, mas também pode afetar negativamente a integridade dos dados e a execução de processos operacionais críticos. Em casos de paralisação prolongada, pode haver um impacto direto na confiança do usuário e na reputação da empresa, além de potenciais perdas financeiras significativas devido à interrupção dos serviços. A recuperação de um ataque DDoS pode exigir esforços consideráveis de mitigação e revisão de arquitetura para fortalecer as defesas contra futuros ataques.

## Mitigações