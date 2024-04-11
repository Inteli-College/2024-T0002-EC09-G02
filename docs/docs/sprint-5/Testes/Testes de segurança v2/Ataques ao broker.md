---
sidebar_position: 2
slug: '/sprint_5/Testes de Segurança/Ataques ao broker'
label: 'Ataques ao broker'
---

# Ataques ao broker

Um atacante com sofisticadas habilidades em criptografia e programação tem a intenção de comprometer a confidencialidade das comunicações entre os dispositivos IoT e o HiveMQ. Para tal, ele deve ter à disposição ferramentas capazes de gerar certificados digitais que aparentam ser legítimos. O atacante também necessita de um meio de inserir esses certificados falsificados no ciclo de confiança dos dispositivos IoT ou do sistema que os verifica, como o HiveMQ. Isso pode envolver técnicas avançadas de engenharia social ou exploração de vulnerabilidades de segurança nas interfaces de gerenciamento de dispositivos ou no próprio serviço.


## Ataque à Confidencialidade: Força Bruta e Rainbow Tables


### Pré-condição:
O atacante possui acesso à interface de login do HiveMQ e está determinado a obter acesso não autorizado ao sistema.

### Passo a Passo:

1. **Coleta de Informações:** O atacante identifica a interface de login do HiveMQ e obtém informações sobre possíveis usuários válidos.
2. **Ataque de Força Bruta:** O atacante utiliza ferramentas automatizadas para realizar tentativas repetidas de login, tentando diferentes combinações de usuários e senhas em um esforço para encontrar credenciais válidas.
3. **Uso de Rainbow Tables:** Para acelerar o processo de quebra de senhas, o atacante pode usar rainbow tables, que são pré-computações de hashes de senhas comuns. Isso permite que ele compare rapidamente os hashes das senhas tentadas com os hashes pré-computados para encontrar correspondências.
4. **Acesso Não Autorizado:** Uma vez que o atacante obtém sucesso na quebra de uma senha válida, ele ganha acesso não autorizado ao sistema HiveMQ, podendo comprometer a confidencialidade e integridade dos dados.

### Pós-condição:
O atacante pode acessar o sistema HiveMQ de forma não autorizada, comprometendo a confidencialidade e a integridade dos dados armazenados e transmitidos pelo sistema.


## Ataque à Integridade: Comprometimento do Broker MQTT

### Pré-condição:
Para comprometer o Broker HiveMQ, o atacante necessita de um conhecimento especializado em segurança de redes e sistemas distribuídos, além de ter habilidades para identificar e explorar vulnerabilidades não divulgadas, conhecidas como zero-days. Esse nível de conhecimento implica uma compreensão profunda dos protocolos de comunicação IoT, da arquitetura de serviços de nuvem e das práticas de segurança associadas. O atacante também precisa ter a capacidade de desenvolver ou adquirir um exploit que tire proveito dessas vulnerabilidades zero-day, o que requer acesso a comunidades de hacking, fóruns na dark web ou redes de contatos que possam fornecer tais informações.


### Passo a Passo:
1. **Identificação de Vulnerabilidades:** Através de pesquisa e análise de segurança, o atacante identifica uma vulnerabilidade zero-day no HiveMQ que possa ser explorada para manipular mensagens MQTT em trânsito. Isso pode envolver técnicas avançadas de engenharia reversa, testes de penetração ou o monitoramento de comunicações de rede para descobrir falhas não documentadas.

2. **Desenvolvimento do Exploit:** Com a vulnerabilidade identificada, o atacante desenvolve um exploit capaz de tirar proveito dessa falha. O exploit seria projetado para ser discretamente injetado em um ponto de entrada vulnerável do serviço HiveMQ, permitindo ao atacante manipular as mensagens MQTT que passam pelo broker sem ser detectado.

3. **Execução e Manipulação de Mensagens:** Utilizando o exploit desenvolvido, o atacante executa o ataque contra o Broker, injetando ou modificando as mensagens MQTT em trânsito. Isso pode envolver a inserção de dados falsos, alteração de mensagens legítimas ou redirecionamento de mensagens para endpoints maliciosos. O objetivo é manipular os dados que são eventualmente armazenados no MongoDB ou processados por outros componentes do sistema.

   
### Pós-condição:
Um ataque bem-sucedido ao broker MQTT do HiveMQ tem consequências significativas para a integridade dos dados do sistema IoT. As mensagens manipuladas podem levar à inserção de dados incorretos ou maliciosos no MongoDB, comprometendo a precisão e a veracidade dos dados armazenados. Isso pode afetar adversamente os processos de tomada de decisão baseados em dados, análises de desempenho, e operações automatizadas que dependem da integridade dos dados. Além disso, a confiança na segurança do ecossistema IoT fica seriamente abalada, potencialmente expondo a organização a riscos operacionais, regulatórios e reputacionais.


## Ataque à Disponibilidade: DDoS no Broker MQTT

### Pré-condição:
Para efetuar um ataque DDoS (Distributed Denial of Service) contra o HiveMQ, o atacante precisa ter sob seu controle uma rede substancial de máquinas comprometidas, conhecida como botnet. Isso geralmente é alcançado infiltrando-se em sistemas vulneráveis espalhados globalmente e utilizando essas máquinas como zumbis para gerar tráfego mal-intencionado. O atacante também deve possuir um entendimento avançado das capacidades de infraestrutura do HiveMQ, incluindo limites de escala, mecanismos de balanceamento de carga e estratégias de mitigação de DDoS da HiveMQ, para planejar um ataque que possa efetivamente sobrecarregar o serviço.

### Passo a Passo
1. **Mobilização e Coordenação da Botnet:** O atacante coordena a botnet, distribuindo comandos específicos para que cada dispositivo comprometido inicie solicitações de conexão ao HiveMQ. Essa etapa envolve a seleção de vetores de ataque que possam gerar o maior impacto, como inundações SYN ou solicitações MQTT malformadas.
2. **Ajuste Dinâmico do Ataque:** Uma vez que o ataque está em andamento, o atacante monitora de perto o desempenho e a resposta do HiveMQ, utilizando qualquer feedback disponível - seja através da observação de mudanças no desempenho do serviço ou de comunicações da HiveMQ sobre o estado do ataque. O atacante ajusta a taxa de solicitações, muda o tipo de vetor de ataque, ou alterna entre diferentes sub-redes da botnet para otimizar a eficácia do ataque e evitar ser completamente mitigado pelas defesas automáticas do HiveMQ.
3. **Estratégias de Contorno de Mitigação:** Com o progresso do ataque, o atacante busca ativamente maneiras de contornar as medidas de mitigação de DDoS implementadas pelo HiveMQ. Isso pode incluir a variação do tráfego gerado pela botnet, a exploração de vulnerabilidades específicas para amplificar o ataque, ou a simulação de tráfego legítimo para dificultar a distinção entre tráfego malicioso e legítimo.

### Pós-condição
Um ataque DDoS bem-sucedido ao HiveMQ pode levar a uma série de consequências graves para as operações IoT dependentes desse serviço. A incapacidade de gerenciar efetivamente o tráfego entrante pode resultar em latência significativa ou na indisponibilidade total do broker MQTT, interrompendo a comunicação entre dispositivos IoT e o Broker em nuvem. Isso não apenas compromete a visibilidade e o controle sobre dispositivos IoT em tempo real, mas também pode afetar negativamente a integridade dos dados e a execução de processos operacionais críticos. Em casos de paralisação prolongada, pode haver um impacto direto na confiança do usuário e na reputação do produto.

## Mitigações

Para mitigar os riscos, é fundamental adotar uma abordagem multifacetada que englobe tanto medidas preventivas quanto reativas. Aqui estão algumas delas:

- Implementar políticas de senha robustas, exigindo senhas fortes e atualização regular.
- Implementar mecanismos de bloqueio de conta após um número especificado de tentativas de login malsucedidas.
- Utilizar autenticação de dois fatores para adicionar uma camada adicional de segurança ao processo de login.
- Manter o software do broker MQTT e os dispositivos IoT atualizados com os últimos patches de segurança. Isso ajuda a proteger contra vulnerabilidades conhecidas que poderiam ser exploradas por atacantes.
- Implementar soluções de monitoramento contínuo e sistemas de detecção de intrusão para identificar padrões de tráfego anormais ou atividades suspeitas. A rápida identificação de um aumento inesperado no tráfego pode ser indicativa de um ataque DDoS em andamento.
- Configurar o HiveMQ e os dispositivos IoT para aplicar limites de taxa e throttling de mensagens, ajudando a prevenir sobrecargas acidentais ou maliciosas.
- Empregar serviços especializados em mitigação de DDoS, que oferecem proteção automatizada contra ataques de larga escala, garantindo que o broker MQTT permaneça acessível mesmo sob condições adversas.
- Assegurar que existam políticas de backup e recuperação de dados robustas para permitir a rápida restauração dos serviços em caso de comprometimento de dados ou interrupção do serviço.

Adotando essas medidas, as organizações podem reforçar significativamente a segurança de seus brokers MQTT e a resiliência de seus sistemas de IoT contra 