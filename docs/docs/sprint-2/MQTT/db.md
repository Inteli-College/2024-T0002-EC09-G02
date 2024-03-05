---
sidebar_position: 3
slug: '/sprint_2/MQTT/db'
label: "Banco de dados"

---

# Banco de dados

Para garantir a integridade e a acessibilidade dos dados provenientes dos dispositivos IoT, é imperativo contar com um sistema de armazenamento robusto e escalável. Optamos por integrar o Amazon DynamoDB para atender a essas necessidades específicas.

O DynamoDB oferece uma arquitetura flexível e altamente escalável, capaz de lidar com grandes volumes de dados sem comprometer o desempenho. Sua natureza NoSQL o torna ideal para lidar com os tipos de dados semi-estruturados comumente encontrados em ambientes de IoT. Além disso, sua capacidade de escala automática permite que o banco de dados se ajuste dinamicamente às demandas crescentes de dados, garantindo uma operação suave e eficiente mesmo em momentos de pico de atividade.

## IoT Rules
As IoT Rules, ou Regras IoT, desempenham um papel crucial na definição do fluxo de dados dentro do ecossistema de IoT. Elas servem como mecanismos para filtrar, transformar e encaminhar os dados recebidos dos dispositivos IoT para destinos específicos.

No nosso cenário, configuramos as IoT Rules para filtrar os tópicos com base em seus prefixos de região. Isso nos permite segmentar os dados com base na origem geográfica, facilitando a organização e análise posterior. Uma vez filtrados, os dados são direcionados para tabelas correspondentes no DynamoDB, onde são armazenados de forma estruturada e prontos para análise.

Além disso, adotamos uma abordagem onde o timestamp atua como a chave primária na tabela do DynamoDB. Essa decisão garante a ordenação temporal dos dados, possibilitando análises históricas e correlações temporais essenciais para entender padrões de comportamento e tendências.

Dessa forma, a combinação do Amazon DynamoDB com as IoT Rules proporciona uma solução completa e robusta para o armazenamento, organização e análise de dados IoT, permitindo insights valiosos para melhorar a eficiência operacional e impulsionar a inovação.
