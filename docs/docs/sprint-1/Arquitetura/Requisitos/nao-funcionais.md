---
sidebar_position: 2
slug: '/sprint_1/arquitetura/requisitos/nao-funcionais'
label: "Não Funcionais"
---

# Requisitos não funcionais

### Descrição

Os Requisitos Não Funcionais foram inicialmente delineados com base em consultas aos clientes, os stakeholders da “Prodan”. Suas perspectivas desempenharam um papel fundamental, especialmente na definição dos requisitos não funcionais relacionados a aspectos como desempenho, segurança e usabilidade.

Os demais Requisitos Não Funcionais, que dizem respeito à arquitetura e infraestrutura do projeto, foram concebidos por meio de deliberações entre os membros da equipe. Essas deliberações ocorreram após a análise do documento fornecido pelo orientador, denominado TAPI, e durante o processo de integração e orientação oferecido pelo orientador em relação ao problema específico.

Resumindo, a formulação dos Requisitos Não Funcionais, apresentados a seguir, emergiu de debates entre os integrantes da equipe durante encontros presenciais de desenvolvimento do projeto, embasados em nossa experiência acumulada em questões de escalabilidade, segurança e outras dimensões não funcionais.

### Tabela Descritiva

<div style={{width:"50%", paddingLeft:"50px"}}>

| Nº  | Tipo          | Descrição |
| --- | ------------- | --------- |
| 1   | Não-funcional | O sistema deve ser capaz de receber os dados enviados pelos 3 sensores lidando com mais de 100 mil requisições |
| 2   | Não-funcional | O sistema deve ser capaz de armazenar esses dados de forma que qualquer consulta não tome mais que 10 segundos|
| 3   | Não-funcional | O sistema deve permitir monitoramento em tempo real notificando problemas em menos de 1 hora  |
| 4   | Não-funcional | A aplicação deve gerar pelo menos 3 dashboards validados pelo parceiro|
| 5   | Não-funcional | O sistema deve emitir notificações e alertas sobre disastres ambientais em menos de 1 hora|
| 6   | Não-funcional | Os dados devem ser disponibilizados em uma plataforma pública que aguente mais de mil acessos|
| 7   | Não-funcional | A aplicação deve ser capaz de parar o robô em menos de 10 segundo após a solicitação |
| 8   | Não-funcional | Os dados devem ser coletados em tempo real com menos de 10 segundos de delay de envio|
| 9   | Não-funcional | O sistema deve aguentar grande volumetria de dados sendo capaz de armazenar mais 4 anos de dados|
| 10  | Não-funcional | O sistema deve tratar os dados em menos de 10 segundos|

</div>

## Planejamento de Validação dos Requisitos

Para cada requisito estabelecido, é necessário desenvolver planos de teste detalhados que visem validar tanto os requisitos funcionais quanto os não funcionais, assegurando a conformidade com as especificações definidas anteriormente. Esses planos de teste devem abranger diversos tipos de avaliação, como:

1. Testes de Capacidade: Para verificar se o sistema é capaz de lidar com a quantidade de dados esperada, sem comprometer a performance. Isso inclui testar a capacidade de armazenamento, a capacidade de processamento e a capacidade de comunicação.
2. Testes de Desempenho: Para assegurar que o sistema atenda aos requisitos de tempo de resposta, tempo de processamento e tempo de disponibilidade, mesmo sob condições de carga máxima. Isso inclui testar a latência, a taxa de transferência e a escalabilidade.
3. Testes de Segurança: Para identificar vulnerabilidades de segurança no sistema, incluindo testes de penetração, validação da criptografia de dados, e a efetividade dos mecanismos de autenticação e autorização.
4. Testes de Usabilidade: Para avaliar a facilidade de uso do sistema, garantindo que a interface seja intuitiva e acessível, conforme os critérios de design de interação e as heurísticas de usabilidade.
5. Testes de Confiabilidade: Para verificar a capacidade do sistema de manter a disponibilidade e a integridade dos dados, mesmo em situações de falha ou desastre. Isso inclui testar a tolerância a falhas, a recuperação de desastres e a consistência dos dados.