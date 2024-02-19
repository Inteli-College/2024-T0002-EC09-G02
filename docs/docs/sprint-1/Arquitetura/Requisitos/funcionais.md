---
sidebar_position: 1
slug: '/sprint_1/arquitetura/requisitos/funcionais'
label: "Funcionais"
---
# Requisitos Funcionais

## Descrição

Os Requisitos Funcionais foram inicialmente concebidos com base em entrevistas com os clientes, os stakeholders da “Prodan”. Suas contribuições foram diretrizes cruciais, principalmente para os requisitos funcionais relacionados às funcionalidades que envolvem a interação do robô, a interface do usuário e os dispositivos de hardware correspondentes.

Os demais Requisitos Funcionais, relacionados à estruturação do projeto, foram desenvolvidos durante discussões entre os membros do grupo. Essas discussões aconteceram após a análise do documento disponibilizado pelo orientador, conhecido como TAPI, bem como durante o processo de integração e orientação ministrado pelo orientador sobre o problema em questão.

Em resumo, a elaboração dos Requisitos Funcionais, apresentados abaixo, resultou de discussões entre os membros do grupo durante reuniões presenciais de desenvolvimento do projeto, fundamentadas em nosso conhecimento acumulado em modelagem de sistemas e experiência do usuário. É válido ressaltar que os autores da solução são:

### Tabela Descritiva 

| N°  | Requisito | Descrição                                                                              |
| --- | --------- | -------------------------------------------------------------------------------------- |
| 1   | Funcional | O dashboard deve oferecer a funcionalidade de exportar relatórios dos dados coletados em formato CSV, incluindo a filtragem por data, sensor e tipo de dados.|
| 2   | Funcional | O sistema deve manter um armazenamento histórico das entradas de dados dos sensores, garantindo a retenção de dados por no mínimo 5 anos para facilitar análises retrospectivas e auditorias.|
| 3   | Funcional | O sistema deve possuir a implementação de um módulo administrativo capaz de gerenciar usuários, configurar sensores, e controlar as permissões de acesso às informações, com logs de atividades para auditoria.|
| 4  | Funcional | O sistema deve incluir um processo de normalização para os dados recebidos dos sensores, garantindo que estejam em um formato padrão e consistente antes de serem armazenados ou processados.|
| 5   | Funcional | O sistema deve possuir a capacidade de integrar dados de sensores com sistemas externos e plataformas de terceiros via API, facilitando o compartilhamento e análise de dados em diferentes aplicações.|
| 6   | Funcional | O sistema deve fornecer alertas em tempo real baseados em critérios pré-definidos (ex.: condições meteorológicas adversas, falhas de sensores), enviando notificações para os administradores e usuários relevantes.|
| 7   | Funcional |O sistema deve possuir a funcionalidade de filtragem e pesquisa avançada que permitam aos usuários localizar rapidamente informações específicas baseadas em múltiplos critérios (ex.: data, tipo de sensor, localização).|
| 8  | Funcional | A arquitetura do sistema deve possuir uma estratégia de backup e recuperação para garantir a integridade e disponibilidade dos dados históricos em caso de falha de sistema ou desastres.|

## Planejamento de Validação dos Requisitos

Para cada requisito estabelecido, é necessário desenvolver planos de teste detalhados que visem validar tanto os requisitos funcionais quanto os não funcionais, assegurando a conformidade com as especificações definidas anteriormente. Esses planos de teste devem abranger diversos tipos de avaliação, como:

1. Testes de Funcionalidade: Para verificar se cada função do sistema opera de acordo com os requisitos especificados. Isso inclui testar a criação de relatórios em CSV, a funcionalidade de alertas em tempo real, a eficácia da filtragem e pesquisa avançada, entre outros.
2. Testes de Usabilidade: Para avaliar a facilidade de uso do sistema, garantindo que a interface seja intuitiva e acessível, conforme os critérios de design de interação e as heurísticas de usabilidade.
3. Testes de Segurança: Para identificar vulnerabilidades de segurança no sistema, incluindo testes de penetração, validação da criptografia de dados, e a efetividade dos mecanismos de autenticação e autorização.
4. Testes de Desempenho: Para assegurar que o sistema e suas integrações suportem o volume esperado de operações e requisições simultâneas dentro dos tempos de resposta estabelecidos, sem comprometer a estabilidade.
5. Testes de Compatibilidade: Para garantir que o sistema funcione corretamente em diferentes ambientes, sistemas operacionais, navegadores e dispositivos, incluindo otimizações para dispositivos móveis.
6. Testes de Integração: Para verificar a comunicação e a operação efetiva entre diferentes módulos do sistema e com sistemas externos, assegurando que os dados sejam corretamente compartilhados e processados.
7. Testes de Recuperação de Desastres e Backup: Para confirmar que os mecanismos de backup e recuperação funcionam adequadamente, permitindo a restauração rápida e eficiente dos dados em caso de falhas ou desastres.
8. Testes de Acessibilidade: Para assegurar que o sistema esteja acessível a usuários com diversas necessidades especiais, cumprindo diretrizes internacionais de acessibilidade.
9. Testes de Escalabilidade: Para verificar a capacidade do sistema de se expandir e acomodar o crescimento em termos de usuários, dados e carga de trabalho, mantendo a performance.

Esses testes devem ser acompanhados de critérios claros de aceitação, procedimentos de execução detalhados e registros de resultados, facilitando a identificação de áreas que requerem ajustes ou melhorias. A implementação de um ciclo de feedback contínuo, baseado nos resultados dos testes, é essencial para o refinamento e a otimização contínua do sistema.
