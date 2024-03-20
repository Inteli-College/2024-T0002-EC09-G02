---
sidebar_position: 3
slug: '/sprint_3/Testes de Segurança/Ataques ao db'
label: 'Ataques ao banco de dados'
---

# Ataques ao banco de dados

Os ataques que visam o triângulo da segurança - Confidencialidade, Integridade e Disponibilidade (CIA) - no contexto de um banco de dados como o AWS DynamoDB podem assumir várias formas:

## Ataque à Confidencialidade: Exploração de Vazamento de Dados

### Pré-condição:
Para realizar um ataque efetivo, um atacante necessitaria ter um conhecimento profundo em métodos de exploração de vulnerabilidades específicas de bancos de dados e serviços de armazenamento em nuvem, como o AWS DynamoDB e o AWS S3. Essa expertise incluiria um entendimento sobre práticas comuns de configuração de segurança e como identificar configurações inadequadas ou permissões IAM excessivas. O atacante também precisaria de acesso a ferramentas de varredura e análise de segurança que possam detectar e explorar essas configurações para extrair informações sensíveis.

### Passo a Passo:
1. **Investigação e Varredura:** O atacante usa ferramentas de varredura automatizadas para procurar instâncias do DynamoDB e buckets do S3 que estejam mal configurados ou que tenham políticas de permissão demasiadamente permissivas. Esse processo incluiria a procura por ACLs (Access Control Lists) mal configuradas, políticas de bucket S3 que permitem acesso público ou políticas IAM que não seguem o princípio de menor privilégio.

2. **Exploração de Configurações:** Uma vez identificada uma configuração vulnerável, o atacante exploraria a falha para ganhar acesso ao bucket do S3 ou às tabelas do DynamoDB. Isso poderia envolver a injeção de comandos, manipulação de tokens de sessão ou uso de credenciais de acesso roubadas.

3. **Exfiltração de Dados:** Após obter acesso, o atacante extrai dados sensíveis.

### Pós-condição:
A concretização bem-sucedida desse tipo de ataque teria implicações sérias. Dados confidenciais e sensíveis poderiam ser acessados e exfiltrados, o que não só resultaria em perda de privacidade e confiança dos stakeholders mas também poderia levar a consequências legais e financeiras significativas devido à violação de regulamentos como o GDPR e o HIPAA.

## Ataque à Integridade: Injeção de SQL ou NoSQL

### Pré-condição:
Um agente de ameaças mirando a integridade do banco de dados precisa possuir habilidades avançadas em técnicas de injeção de código e estar familiarizado com as APIs e interfaces de programação que interagem com o AWS DynamoDB. Isso inclui compreender linguagens de consulta NoSQL, a lógica da aplicação e as práticas de validação de entrada de dados. O atacante também precisa identificar pontos fracos onde os comandos de consulta não são devidamente sanitizados ou validados pelo aplicativo, permitindo a injeção de comandos maliciosos.

### Passo a Passo:
1. **Reconhecimento:** O atacante mapeia a aplicação e identifica os endpoints que interagem com o DynamoDB, possivelmente usando técnicas como fuzzing ou análise de código para descobrir campos de entrada vulneráveis a injeções.
2. **Elaboração do Ataque:** Com base no conhecimento adquirido, o atacante elabora consultas maliciosas específicas do DynamoDB. Essas consultas são projetadas para serem camufladas como consultas legítimas mas incluem operações que o aplicativo não pretende permitir, como deletar tabelas ou modificar registros.
3. **Execução e Exploração:** O atacante injeta as consultas maliciosas por meio de campos de entrada vulneráveis. Se o aplicativo não validar ou limpar adequadamente a entrada, o código injetado é executado pelo DynamoDB. Isso pode envolver diretamente inserir, atualizar ou excluir dados.

### Pós-condição:
A execução bem-sucedida de um ataque de injeção pode ter múltiplas consequências de longo alcance. Informações críticas podem ser alteradas ou apagadas, levando a um estado de dados inconsistente ou à perda de dados vitais. Por exemplo, a corrupção de tabelas de controle de acesso pode resultar em violações de segurança internas, enquanto a manipulação de dados financeiros pode causar prejuízos econômicos diretos. A integridade comprometida dos dados também afeta a confiança dos usuários e dos clientes na confiabilidade do sistema, o que pode ter implicações legais e regulatórias se os dados estiverem sujeitos a requisitos de conformidade. Além disso, a detecção e a recuperação de ataques de injeção podem exigir esforços significativos de auditoria e restauração de dados, resultando em custos adicionais e interrupções operacionais.

## Ataque à Disponibilidade: Ataques de Serviço de Negação Distribuída (DDoS)

### Pré-condição:
Para lançar um ataque de sobrecarga eficaz contra o AWS DynamoDB, o atacante precisaria ter acesso a recursos significativos capazes de gerar um volume de tráfego substancial. Isso poderia ser alcançado através da utilização de uma rede de computadores comprometidos (botnet) ou pelo abuso de recursos de cloud computing configurados de forma inadequada para gerar solicitações em massa. Além disso, o atacante necessitaria de um entendimento profundo sobre o modelo de precificação e os limites de throughput do DynamoDB, a fim de criar um plano de ataque que maximize o custo para a vítima enquanto esgota os recursos provisionados para o serviço de banco de dados.

### Passo a Passo:
1. **Preparação e Planejamento:** O atacante aluga uma botnet ou explora vulnerabilidades em configurações de cloud para obter controle sobre recursos computacionais. Em seguida, planeja uma estratégia para gerar um grande volume de operações de leitura e escrita que sejam custosas em termos de throughput para o DynamoDB.↳
2. **Lançamento do Ataque:** Utilizando os recursos sob seu controle, o atacante inicia uma onda de solicitações de leitura/gravação direcionadas às tabelas do DynamoDB visadas. O objetivo é gerar tráfego suficiente para ultrapassar os limites de throughput provisionados para essas tabelas, resultando em erros de throttling e aumentando os custos operacionais para a vítima.
3. **Ajuste e Sustentação do Ataque:** O atacante monitora as respostas do DynamoDB para identificar a eficácia do ataque, ajustando a taxa de solicitações conforme necessário para manter a pressão sobre os recursos do banco de dados. O ataque é mantido até que se observe uma degradação significativa na performance do serviço ou até que medidas de mitigação sejam implementadas pela vítima.

### Pós-condição:
Um ataque de sobrecarga bem-sucedido ao DynamoDB pode ter várias consequências negativas para a organização alvo. Primeiramente, a performance do banco de dados pode ser severamente degradada, resultando em tempos de resposta lentos ou na indisponibilidade completa do serviço para aplicações críticas que dependem do DynamoDB para operar. Isso pode afetar diretamente a experiência do usuário final e a operacionalidade de serviços dependentes do banco de dados. Adicionalmente, o custo associado ao throughput excedente pode ser significativo, gerando despesas inesperadas para a organização. Em casos extremos, a persistência do ataque pode levar à necessidade de escalar infraestrutura de forma emergencial ou realizar mudanças de arquitetura para contornar a sobrecarga, implicando em mais custos e esforços operacionais.