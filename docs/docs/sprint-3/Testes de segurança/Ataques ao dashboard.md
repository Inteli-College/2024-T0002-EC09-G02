---
sidebar_position: 4
slug: '/sprint_3/Testes de Segurança/Ataques ao dashboard'
label: 'Ataques ao dashboard'
---

# Ataques ao dashboard

A segurança do dashboard é crítica, pois ele atua como a interface visual para o monitoramento e análise de dados em tempo real do nosso ecossistema IoT. A seguir, detalhamos ameaças específicas para a confidencialidade, integridade e disponibilidade do dashboard Grafana hospedado no Amazon EKS.

## Ataque à Confidencialidade: Cross-Site Scripting (XSS)

### Pré-condição:
Para efetuar um ataque de Cross-Site Scripting (XSS) contra o Grafana, um atacante necessita de um entendimento profundo de desenvolvimento web, incluindo conhecimento em JavaScript, HTML e técnicas de engenharia social. O atacante deve ser capaz de identificar falhas de segurança no Grafana onde o input fornecido pelo usuário não é corretamente sanitizado ou escapado, permitindo a injeção de scripts maliciosos. Essa exploração requer a habilidade de criar scripts que sejam capazes de executar no navegador da vítima sem detecção, além de métodos para induzir os usuários a acessarem o conteúdo infectado, como através de engenharia social ou links aparentemente legítimos.

### Passo a Passo:
1. **Identificação de Vulnerabilidades:** O atacante analisa as funcionalidades do Grafana, focando em áreas onde o input do usuário é inserido e renderizado pela interface. Isso inclui campos de pesquisa, configurações de usuário e painéis personalizados. O atacante procura por pontos onde o input não é adequadamente sanitizado, permitindo a execução de scripts.

2. **Criação de Script Malicioso:** Uma vez identificada a vulnerabilidade, o atacante desenvolve um script malicioso especificamente projetado para explorar essa falha. O script pode ser configurado para realizar ações como roubar cookies de sessão, capturar teclas pressionadas ou extrair tokens de autenticação.

3. **Distribuição e Engajamento:** O atacante embute o script malicioso em um link, imagem ou página web e usa técnicas de engenharia social para distribuí-lo entre os usuários do Grafana. Isso pode ser feito por meio de emails phishing, mensagens em fóruns ou redes sociais, ou manipulando páginas web frequentadas pelos usuários.
   
4. **Execução do Script:** Quando um usuário clica no link malicioso ou visita a página contaminada, o script é executado no contexto do navegador da vítima. O navegador, acreditando que o script faz parte do site legítimo, executa o código, resultando na extração e transmissão das informações sensíveis para o atacante.
   
### Pós-condição:
A execução bem-sucedida de um ataque XSS pode resultar na comprometimento da confidencialidade dos dados do usuário. Informações sensíveis, incluindo cookies de sessão, tokens de autenticação e dados pessoais, podem ser exfiltrados, permitindo ao atacante acessar o Grafana como se fosse o usuário vítima. Isso pode levar a ações maliciosas adicionais dentro do sistema, como a alteração de dashboards, a extração de dados sigilosos ou o lançamento de outros ataques a partir da posição de confiança obtida. O impacto desse ataque não se limita apenas à perda de dados; ele também mina a confiança na segurança do ambiente de monitoramento e pode ter repercussões regulatórias, dependendo da natureza dos dados acessados.

## Ataque que à Integridade: Manipulação de Dashboards via CSRF

### Pré-condição:
Para executar com sucesso um ataque de Cross-Site Request Forgery (CSRF) ao Grafana, um atacante precisa inicialmente identificar uma vulnerabilidade CSRF na aplicação. Isso geralmente requer um entendimento profundo das medidas de segurança específicas implementadas pelo Grafana para prevenir tais ataques, incluindo tokens de proteção CSRF e políticas de mesma origem. O atacante também necessita da habilidade de criar solicitações HTTP maliciosas que possam ser mascaradas como ações legítimas dentro da aplicação e de engajar usuários legítimos, especialmente aqueles com permissões administrativas, para que inadvertidamente executem essas ações.

### Passo a Passo:
1. **Criação do Payload Malicioso:** O atacante constrói cuidadosamente um pedido de ação HTTP (por exemplo, uma requisição POST ou GET) que realiza uma ação específica no Grafana, como modificar um dashboard existente ou alterar configurações de segurança. Esse pedido é projetado para parecer como uma solicitação legítima do servidor do Grafana.
2. **Disseminação e Engajamento do Usuário:** O atacante então dissemina o payload malicioso por meio de emails de phishing, mensagens em redes sociais, ou outras técnicas de engenharia social, visando usuários autenticados do Grafana. O objetivo é fazer com que o usuário clique em um link ou visite um site controlado pelo atacante, onde o pedido malicioso está embutido.
3. **Execução Involuntária da Ação:** Quando um usuário autenticado, especialmente um com permissões de administrador, clica no link malicioso ou visita o site preparado pelo atacante, o navegador do usuário executa involuntariamente a ação embutida no contexto da sessão autenticada do Grafana. Como o Grafana recebe a solicitação como sendo originada do usuário legítimo, a ação maliciosa é realizada sem o conhecimento ou consentimento do usuário.

### Pós-condição:
A execução bem-sucedida de um ataque CSRF contra o Grafana pode ter implicações significativas para a integridade dos dashboards e das configurações de segurança. Dashboards podem ser alterados, deletados ou corrompidos, o que pode levar à perda de visibilidade crítica sobre a infraestrutura monitorada ou sobre os dados analisados. Alterações maliciosas nas configurações podem comprometer ainda mais a segurança da aplicação, permitindo ataques subsequentes ou expondo dados sensíveis. Tal comprometimento não apenas afeta a funcionalidade e a confiabilidade do Grafana mas também mina a confiança dos usuários na segurança e na precisão das ferramentas de monitoramento que dependem fortemente da integridade dos dashboards configurados.

## Ataque à Disponibilidade: Ataques de Serviço de Negação Distribuída (DDoS)

### Pré-condição:
Para efetuar um ataque de DDoS contra o Grafana hospedado no Amazon EKS, o agressor precisa ter acesso a recursos significativos. Isso geralmente envolve uma rede de bots, conhecida como botnet, que pode ser composta por centenas ou milhares de dispositivos infectados com malware, controlados remotamente pelo atacante. Alternativamente, o agressor pode explorar serviços de cloud mal configurados para gerar um volume massivo de tráfego. Uma compreensão profunda das técnicas de amplificação e reflexão de DDoS também é necessária para maximizar o volume de tráfego gerado e a eficácia do ataque, bem como conhecimento sobre as configurações de rede e de segurança do ambiente de hospedagem do Grafana.

### Passo a Passo:
1. **Mobilização da Botnet:** O atacante prepara a botnet, coordenando os dispositivos infectados para iniciar o ataque ao sinal. Esta etapa envolve configurar os bots para direcionar seus esforços para o endpoint específico do Grafana hospedado no EKS.
2. **Geração de Tráfego Massivo:** Utilizando técnicas de amplificação, como o reflexo DNS, o atacante aumenta o volume do tráfego gerado pela botnet. Isso é feito fazendo com que os servidores de terceiros respondam a solicitações forjadas, enviando respostas significativamente maiores para o alvo do ataque, neste caso, o Grafana.
3. **Ajustes Táticos:** À medida que o ataque progride, o atacante monitora a eficácia do ataque em tempo real, ajustando a estratégia conforme necessário para contornar as medidas de mitigação implantadas pela AWS e pela equipe de operações do Grafana. Isso pode incluir a alteração dos vetores de ataque, a rotação de endereços IP dos bots, ou a intensificação do volume de tráfego.

### Pós-condição:
O resultado de um ataque de DDoS bem orquestrado pode ser devastador para a disponibilidade do Grafana. O serviço pode se tornar completamente inacessível para todos os usuários, interrompendo o monitoramento e análise de dados críticos em tempo real. Isso não só afeta a capacidade da equipe de TI de responder a incidentes de segurança ou operacionais mas também pode ter um impacto negativo em toda a operação da organização, prejudicando a tomada de decisão baseada em dados e a visibilidade operacional. A recuperação de um ataque de DDoS pode exigir esforços significativos de mitigação, ajustes na infraestrutura e, possivelmente, resultar em custos elevados devido ao aumento do uso de largura de banda e recursos de computação para combater o ataque.

## Mitigações

Para mitigar ataques direcionados ao dashboard, especialmente o Grafana hospedado no Amazon EKS, é essencial implementar uma combinação de medidas técnicas e procedimentos operacionais. Estas estratégias ajudam a proteger contra vulnerabilidades que possam comprometer a confidencialidade, integridade e disponibilidade do sistema:

- Higienização Rigorosa de Inputs: Para prevenir ataques de Cross-Site Scripting (XSS), é crucial garantir que todos os inputs do usuário sejam devidamente sanitizados antes de serem processados ou exibidos pelo dashboard. Isso envolve a implementação de filtros de entrada que removem ou escapam caracteres potencialmente maliciosos.
- Implementação de Políticas de Conteúdo Seguro: Utilizar políticas de segurança de conteúdo (Content Security Policy - CSP) que restrinjam os recursos que o navegador pode carregar para o dashboard. Políticas CSP bem definidas podem efetivamente prevenir a execução de scripts maliciosos.
- Uso de Tokens Anti-CSRF: Para combater ataques de Cross-Site Request Forgery (CSRF), é importante que o dashboard Grafana utilize tokens anti-CSRF em todas as solicitações críticas. Esses tokens garantem que cada solicitação seja validada de forma única, prevenindo ações não autorizadas em nome de um usuário autenticado.
  
Ao implementar essas medidas de mitigação, organizações podem fortalecer significativamente a segurança do dashboard Grafana contra ataques que visam a confidencialidade, integridade e disponibilidade, garantindo assim a continuidade e confiabilidade do monitoramento e análise de dados do ecossistema IoT.