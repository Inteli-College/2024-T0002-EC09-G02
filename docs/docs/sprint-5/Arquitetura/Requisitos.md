---
sidebar_position: 3
slug: 'requisitos'
label: "Requisitos"
---

# Requisitos

Aqui estão as listas de requisitos funcionais e não funcionais descritos na [sprint 1](https://inteli-college.github.io/2024-T0002-EC09-G02/category/requisitos) que foram atendidos com a arquiteutra dessa solução.

## Requisitos funcionais

| Código | Requisito Funcional                                                                                                 |
|--------|---------------------------------------------------------------------------------------------------------------------|
| RF 02  | O sistema deve manter um armazenamento histórico das entradas de dados dos sensores, garantindo a retenção de dados por no mínimo 5 anos para facilitar análises retrospectivas e auditorias. |
| RF 03  | O sistema deve possuir a implementação de um módulo administrativo capaz de gerenciar usuários, configurar sensores, e controlar as permissões de acesso às informações, com logs de atividades para auditoria. |
| RF 04  | O dashboard deve possuir um módulo de visualização pública, disponibilizando informações atualizadas sobre condições regionais de São Paulo, acessível sem necessidade de autenticação. |
| RF 05  | O dashboard deve integrar gráficos dinâmicos e interativos, como gráficos de linha, barra e alertas, para aprimorar a compreensão das informações coletadas. |
| RF 06  | O sistema deve incluir um processo de normalização para os dados recebidos dos sensores, garantindo que estejam em um formato padrão e consistente antes de serem armazenados ou processados. |
| RF 09  | O sistema deve possuir a funcionalidade de filtragem e pesquisa avançada que permitam aos usuários localizar rapidamente informações específicas baseadas em múltiplos critérios (ex.: data, tipo de sensor). |

### Contemplação dos requisitos funcionais:

- **RF02:** O [mongoDB Atlas](https://www.mongodb.com) que utilizamos como armazenamento dos dados garante a retenção dos dados, apenas aplicando custos quando há uma quantidade acima do free tier.
- **RF03:** O [metabase](https://www.metabase.com) possui um acesso administrativo que contempla esse requisito.
- **RF04:** O [metabase](https://www.metabase.com) também permite acesso público aos dashboards.
- **RF06:** O [Confluent](https://confluent.cloud) com seus sistemas de filas envia os dados normalizados para o banco de dados.
- **RF09:** As visualizações no [metabase](https://www.metabase.com) permitem filtragem e pesquisa de dados nos dashboards.

## Requisitos não funcionais


| Código  | Requisito Não Funcional                                                                                                                                                                    |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RNF 01  | O Sistema deve garantir a segurança das informações pessoais dos usuários registrados no sistema, encriptando os dados sensíveis com JWT ou SHA-256.                                        |
| RNF 02  | O dashboard deve possuir ao menos, autenticação e autorização de usuários admin que possam editar o dashboard, assegurando que apenas usuários com as permissões adequadas possam acessar informações restritas. |
| RNF 04  | O design da interface do dashboard deve ser intuitivo e acessível, seguindo as heurísticas de Nielsen para usabilidade e incluindo suporte para usuários com deficiência.                     |
| RNF 05  | O sistema deve assegurar alta confiabilidade nas informações coletadas e armazenadas, aderindo a padrões de identificação, qualidade de dados estabelecidos e conformidade com leis de proteção de dados LGPD e GDPR. |
| RNF 06  | Capacidade inicial de armazenar até 20GB de dados, com arquitetura projetada para facilitar a escalabilidade, permitindo um aumento no volume de operações sem degradação significativa do desempenho.                |
| RNF 09  | O design da interface do usuário deve ser responsivo, se adaptando pelo menos a telas de tamanho de 540px, garantindo uma experiência de usuário otimizada em dispositivos móveis como smartphones e tablets.           |
| RNF 11   | O sistema deve ser capaz de receber os dados enviados pelos 3 sensores lidando com mais de 100 mil requisições |
| RNF 12   | O sistema deve ser capaz de armazenar esses dados de forma que qualquer consulta não tome mais que 10 segundos|
| RNF 14   | A aplicação deve gerar pelo menos 3 dashboards validados pelo parceiro|
| RNF 16   | Os dados devem ser disponibilizados em uma plataforma pública que aguente mais de mil acessos|
| RNF 17  | Os dados devem ser coletados em tempo real com menos de 10 segundos de delay de envio|
| RNF 18   | O sistema deve aguentar grande volumetria de dados sendo capaz de armazenar mais 4 anos de dados|
| RNF 19  | O sistema deve tratar os dados em menos de 10 segundos|

### Contemplação dos requisitos não funcionais:

- **RNF01:** O [metabase](https://www.metabase.com) com o serviço RDS da AWS garantem a segurança das informações pessoais dos usuários.
- **RNF02:** O [metabase](https://www.metabase.com) possui autenticação de usuários admin.
- **RNF04:** O dashboard foi construído baseando-se nas heurísticas de Nielsen e contemplando alguns dos requisitos da [WCAG Cards](https://guia-wcag.com/).
- **RNF05:** O [metabase](https://www.metabase.com) com o serviço RDS da AWS garantem a segurança das informações pessoais dos usuários.
- **RNF06:** Arquitetura escalável garantida pelos serviços da AWS e pelo Load Balancer utilizado.
- **RNF09:** O [metabase](https://www.metabase.com) já cria dashboards responsivos por natureza.
- **RNF11:** O [hiveMQ](https://www.hivemq.com.) e o [Confluent](https://confluent.cloud) asseguram o envio dos dados em larga escala.
- **RNF12:** A utilização de um banco não relacional ([mongoDB](https://www.mongodb.com)) garante o rápido acesso aos dados.
- **RNF14:** Há mais de 3 dashboards validados.
- **RNF16:** O [metabase], junto com a utilização do serviço EC2 da AWS, garantem o acesso livre à plataforma.
- **RNF17:** A integração do [hiveMQ](https://www.hivemq.com.) e o [Confluent](https://confluent.cloud) garantem a velocidade de envio dos dados.
- **RNF18:**  O [mongoDB Atlas](https://www.mongodb.com) que utilizamos como armazenamento dos dados garante a retenção dos dados, apenas aplicando custos quando há uma quantidade acima do free tier.
- **RNF19:** A integração do [hiveMQ](https://www.hivemq.com.) e o [Confluent](https://confluent.cloud) garantem o tratamento de envio dos dados.