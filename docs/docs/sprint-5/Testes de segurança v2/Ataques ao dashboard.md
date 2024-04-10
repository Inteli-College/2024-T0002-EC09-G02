---
sidebar_position: 4
slug: '/sprint_5/Testes de Segurança/Ataques ao dashboard'
label: 'Ataques ao dashboard'
---

# Ataques ao dashboard

A segurança do dashboard é crítica, pois ele atua como a interface visual para o monitoramento e análise de dados em tempo real do nosso ecossistema IoT. A seguir, detalhamos ameaças específicas para a confidencialidade, integridade e disponibilidade do dashboard Metabase hospedado no Amazon EC2.

## Ataque à Confidencialidade: Cross-Site Scripting (XSS)

### Pré-condição:
Para efetuar um ataque de Cross-Site Scripting (XSS) contra o Metabase, um atacante necessita de um entendimento profundo de desenvolvimento web, incluindo conhecimento em JavaScript, HTML e técnicas de engenharia social. O atacante deve ser capaz de identificar falhas de segurança no Metabase onde o input fornecido pelo usuário não é corretamente sanitizado ou escapado, permitindo a injeção de scripts maliciosos. Essa exploração requer a habilidade de criar scripts que sejam capazes de executar no navegador da vítima sem detecção, além de métodos para induzir os usuários a acessarem o conteúdo infectado, como através de engenharia social ou links aparentemente legítimos.

### Passo a Passo:
1. **Identificação de Vulnerabilidades:** O atacante analisa as funcionalidades do Metabase, focando em áreas onde o input do usuário é inserido e renderizado pela interface. Isso inclui campos de pesquisa, configurações de usuário e painéis personalizados. O atacante procura por pontos onde o input não é adequadamente sanitizado, permitindo a execução de scripts.

2. **Criação de Script Malicioso:** Uma vez identificada a vulnerabilidade, o atacante desenvolve um script malicioso especificamente projetado para explorar essa falha. O script pode ser configurado para realizar ações como roubar cookies de sessão, capturar teclas pressionadas ou extrair tokens de autenticação.

3. **Distribuição e Engajamento:** O atacante embute o script malicioso em um link, imagem ou página web e usa técnicas de engenharia social para distribuí-lo entre os usuários do Metabase. Isso pode ser feito por meio de emails phishing, mensagens em fóruns ou redes sociais, ou manipulando páginas web frequentadas pelos usuários.
   
4. **Execução do Script:** Quando um usuário clica no link malicioso ou visita a página contaminada, o script é executado no contexto do navegador da vítima. O navegador, acreditando que o script faz parte do site legítimo, executa o código, resultando na extração e transmissão das informações sensíveis para o atacante.
   
### Pós-condição:
A execução bem-sucedida de um ataque XSS pode resultar na comprometimento da confidencialidade dos dados do usuário. Informações sensíveis, incluindo cookies de sessão, tokens de autenticação e dados pessoais, podem ser exfiltrados, permitindo ao atacante acessar o Metabase como se fosse o usuário vítima. Isso pode levar a ações maliciosas adicionais dentro do sistema, como a alteração de dashboards, a extração de dados sigilosos ou o lançamento de outros ataques a partir da posição de confiança obtida. O impacto desse ataque não se limita apenas à perda de dados; ele também mina a confiança na segurança do ambiente de monitoramento e pode ter repercussões regulatórias, dependendo da natureza dos dados acessados.

## Ataque que à Integridade: Manipulação de Dashboards via CSRF

### Pré-condição:
Para executar com sucesso um ataque de Cross-Site Request Forgery (CSRF) ao Metabase, um atacante precisa inicialmente identificar uma vulnerabilidade CSRF na aplicação. Isso geralmente requer um entendimento profundo das medidas de segurança específicas implementadas pelo Metabase para prevenir tais ataques, incluindo tokens de proteção CSRF e políticas de mesma origem. O atacante também necessita da habilidade de criar solicitações HTTP maliciosas que possam ser mascaradas como ações legítimas dentro da aplicação e de engajar usuários legítimos, especialmente aqueles com permissões administrativas, para que inadvertidamente executem essas ações.

### Passo a Passo:
1. **Criação do Payload Malicioso:** O atacante constrói cuidadosamente um pedido de ação HTTP (por exemplo, uma requisição POST ou GET) que realiza uma ação específica no Metabase, como modificar um dashboard existente ou alterar configurações de segurança. Esse pedido é projetado para parecer como uma solicitação legítima do servidor do Metabase.
2. **Disseminação e Engajamento do Usuário:** O atacante então dissemina o payload malicioso por meio de emails de phishing, mensagens em redes sociais, ou outras técnicas de engenharia social, visando usuários autenticados do Metabase. O objetivo é fazer com que o usuário clique em um link ou visite um site controlado pelo atacante, onde o pedido malicioso está embutido.
3. **Execução Involuntária da Ação:** Quando um usuário autenticado, especialmente um com permissões de administrador, clica no link malicioso ou visita o site preparado pelo atacante, o navegador do usuário executa involuntariamente a ação embutida no contexto da sessão autenticada do Metabase. Como o Metabase recebe a solicitação como sendo originada do usuário legítimo, a ação maliciosa é realizada sem o conhecimento ou consentimento do usuário.

### Pós-condição:
Para realizar um ataque de DDoS (Distributed Denial of Service) eficaz contra o Metabase hospedado em uma instância EC2 da Amazon Web Services (AWS), o agressor necessita acessar uma quantidade significativa de recursos. Isso geralmente se traduz na formação de uma botnet, que é uma coleção de dispositivos infectados com malware e controlados à distância pelo atacante. Tais dispositivos podem variar de centenas a milhares e são usados para gerar um volume massivo de tráfego direcionado. Alternativamente, o atacante pode se aproveitar de configurações inadequadas em serviços de nuvem para amplificar o ataque. Uma compreensão aprofundada das técnicas de amplificação e reflexão de DDoS é crucial, pois permite maximizar tanto o volume de tráfego enviado quanto a eficácia geral do ataque, levando em consideração as configurações específicas de rede e segurança da infraestrutura AWS que hospeda o Metabase.
## Ataque à Disponibilidade: Ataques de Serviço de Negação Distribuída (DDoS)

### Pré-condição:
Para efetuar um ataque de DDoS contra o Grafana hospedado no Amazon EKS, o agressor precisa ter acesso a recursos significativos. Isso geralmente envolve uma rede de bots, conhecida como botnet, que pode ser composta por centenas ou milhares de dispositivos infectados com malware, controlados remotamente pelo atacante. Alternativamente, o agressor pode explorar serviços de cloud mal configurados para gerar um volume massivo de tráfego. Uma compreensão profunda das técnicas de amplificação e reflexão de DDoS também é necessária para maximizar o volume de tráfego gerado e a eficácia do ataque, bem como conhecimento sobre as configurações de rede e de segurança do ambiente de hospedagem do Grafana.

### Passo a Passo:
1. **Mobilização da Botnet:**O primeiro passo do atacante é preparar e coordenar a botnet. Os dispositivos infectados são configurados para atacar o Metabase na EC2 ao receberem um comando, concentrando esforços num alvo específico.

2. **Geração de Tráfego Massivo:** O agressor emprega técnicas de amplificação, como reflexo DNS, para aumentar exponencialmente o volume de tráfego. Isso é conseguido ao induzir servidores de terceiros a responderem a solicitações falsificadas, que são então direcionadas para o Metabase, sobrecarregando o serviço.
3. **Ajustes Táticos:** Durante o ataque, o agressor avalia sua eficácia em tempo real, fazendo ajustes para contornar qualquer medida de mitigação implementada pela equipe de segurança da AWS ou pelos administradores do Metabase. Isso pode incluir a mudança dos vetores de ataque, a substituição dos IPs usados pela botnet, ou o aumento do volume de tráfego dirigido ao serviço.

### Pós-condição:
Um ataque de DDoS bem-sucedido contra o Metabase hospedado em uma EC2 pode levar a uma interrupção total do serviço, tornando-o inacessível para os usuários. Isso interrompe as atividades de monitoramento e análise de dados, essenciais para as operações diárias e a tomada de decisões baseadas em dados dentro da organização. As consequências de tal ataque não se limitam apenas a perdas operacionais imediatas mas também podem afetar negativamente a visibilidade operacional a longo prazo. A recuperação de um ataque DDoS pode demandar esforços extensivos para mitigação, possíveis ajustes na infraestrutura de TI e, não raro, implica em custos adicionais decorrentes do uso intensificado de recursos de rede e computação na luta contra o ataque.

## Mitigações

Para mitigar ataques direcionados ao dashboard, especialmente o Metabase hospedado no Amazon EC2, é essencial implementar uma combinação de medidas técnicas e procedimentos operacionais. Estas estratégias ajudam a proteger contra vulnerabilidades que possam comprometer a confidencialidade, integridade e disponibilidade do sistema:

### Para Mitigar Ataques à Confidencialidade (XSS):
- **Implementação de Filtros de Sanitização de Input:** Reforce a sanitização de todos os inputs do usuário para remover ou escapar strings potencialmente perigosas antes de serem processadas ou exibidas pelo Metabase. Ferramentas e bibliotecas específicas de desenvolvimento web podem ajudar a implementar essa proteção de forma eficaz.

- **Utilização de Políticas de Segurança de Conteúdo (CSP):** Configure CSPs para limitar e especificar quais recursos o navegador web pode carregar e executar. Isso ajuda a prevenir a execução de scripts maliciosos, mesmo que um atacante consiga injetar código XSS no Metabase.

### Para Mitigar Ataques que Comprometem a Integridade (CSRF):
- **Tokens de Sessão e Autenticação Anti-CSRF:** Assegure que o Metabase implemente e valide tokens anti-CSRF para todas as solicitações sensíveis e transações que alterem o estado. Isso ajuda a garantir que as requisições sejam genuínas e autorizadas pelo usuário.

- **Verificação de Origem:** Implemente verificações de cabeçalhos HTTP para assegurar que todas as solicitações POST venham de origens confiáveis. Isso pode ajudar a prevenir ataques CSRF, assegurando que ações potencialmente prejudiciais sejam executadas apenas se originarem do domínio correto.

### Para Mitigar Ataques à Disponibilidade (DDoS):
**Proteção contra DDoS:** Utilize serviços de proteção contra DDoS oferecidos pela AWS, como o AWS Shield, especialmente a versão Advanced para uma proteção mais robusta que inclui mitigação automatizada de ataques e suporte de emergência.

**Escala e Balanceamento de Carga:** Implemente balanceamento de carga com o Elastic Load Balancer (ELB) e assegure que o Metabase possa escalar horizontalmente para lidar com aumentos inesperados no tráfego, distribuindo a carga entre várias instâncias EC2.

**Monitoramento e Alertas:** Estabeleça um sistema robusto de monitoramento e alertas usando o Amazon CloudWatch para detectar padrões de tráfego anormais ou aumento de carga que possam indicar um ataque DDoS em andamento. Configure alertas para notificar automaticamente a equipe de segurança.

Ao adotar e implementar essas estratégias de mitigação, você pode melhorar significativamente a segurança do Metabase contra os tipos de ataques descritos, protegendo a confidencialidade, integridade e disponibilidade dos seus dados e serviços de dashboard.

