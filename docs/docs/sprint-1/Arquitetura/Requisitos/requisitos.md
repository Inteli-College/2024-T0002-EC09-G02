---
sidebar_position: 3 
label: "Requisitos"
slug: '/sprint_1/arquitetura/requisitos/'
---

# Requisitos Funcionais & Não Funcionais

Os Requisitos Não Funcionais e Funcionais foram inicialmente delineados com base em consultas aos clientes, os stakeholders da “Prodan”. Suas perspectivas desempenharam um papel fundamental, especialmente na definição dos requisitos não funcionais relacionados a aspectos como desempenho, segurança e usabilidade.

Os demais Requisitos, que dizem respeito à arquitetura e infraestrutura do projeto, foram concebidos por meio de deliberações entre os membros da equipe. Essas deliberações ocorreram após a análise do documento fornecido pelo orientador, denominado TAPI, e durante o processo de integração e orientação oferecido pelo orientador em relação ao problema específico.

Resumindo, a formulação dos Requisitos apresentados a seguir, emergiu de debates entre os integrantes da equipe durante encontros presenciais de desenvolvimento do projeto, embasados em nossa experiência acumulada em questões de escalabilidade, segurança e outras dimensões não funcionais.

## Requisitos

A seguir, estão algumas delas listadas:

<div style={{display: "flex"}}>

<div style={{width:"50%"}}>

| N°  | Requisito | Descrição                                                                              |
| --- | --------- | -------------------------------------------------------------------------------------- |
| 1   | Funcional | O dashboard deve oferecer a funcionalidade de exportar relatórios dos dados coletados em formato CSV, incluindo a filtragem por data, sensor e tipo de dados.|
| 2   | Funcional | O sistema deve manter um armazenamento histórico das entradas de dados dos sensores, garantindo a retenção de dados por no mínimo 5 anos para facilitar análises retrospectivas e auditorias.|
| 3   | Funcional | O sistema deve possuir a implementação de um módulo administrativo capaz de gerenciar usuários, configurar sensores, e controlar as permissões de acesso às informações, com logs de atividades para auditoria.|
| 4   | Funcional | O dashboard deve possuir um módulo de visualização pública, disponibilizando informações atualizadas sobre condições marítimas, acessível sem necessidade de autenticação.|
| 5   | Funcional | O dashboard deve integrar gráficos dinâmicos e interativos, como gráficos de linha, barra e mapa de calor, para aprimorar a compreensão das informações coletadas.|
| 6   | Funcional | O sistema deve incluir um processo de normalização para os dados recebidos dos sensores, garantindo que estejam em um formato padrão e consistente antes de serem armazenados ou processados.|
| 7   | Funcional | O sistema deve possuir a capacidade de integrar dados de sensores com sistemas externos e plataformas de terceiros via API, facilitando o compartilhamento e análise de dados em diferentes aplicações.|
| 8   | Funcional | O sistema deve fornecer alertas em tempo real baseados em critérios pré-definidos (ex.: condições meteorológicas adversas, falhas de sensores), enviando notificações para os administradores e usuários relevantes.|
| 9   | Funcional |O sistema deve possuir a funcionalidade de filtragem e pesquisa avançada que permitam aos usuários localizar rapidamente informações específicas baseadas em múltiplos critérios (ex.: data, tipo de sensor, localização).|
| 10  | Funcional | A arquitetura do sistema deve possuir uma estratégia de backup e recuperação para garantir a integridade e disponibilidade dos dados históricos em caso de falha de sistema ou desastres.|

</div>

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
</div>

## Testes

Para testar os requisitos não-funcionais, foram preparados testes unitários (neste caso, _scripts_ em *_Python_*) que auxiliassem na validação das funcionalidades. Todos os testes podem ser encontrados na pasta _test_ do [repositório no Github](hhttps://github.com/Inteli-College/2024-T0002-EC09-G02) (testes ainda estão sendo desenvolvido).

| N° | Teste | Status | Procedimento | Resultados | Observação |
|:--:|:-----:|:------:|:------------:|:----------:|:----------:|
| 1  | O sistema deve ser capaz de receber os dados enviados pelos 3 sensores lidando com mais de 100 mil requisições | ❔ Ainda não testado |-| - |-   |
| 2  | O sistema deve ser capaz de armazenar esses dados de forma que qualquer consulta não tome mais que 10 segundos| ❔ Ainda não testado | -| -| - |
| 3  | O sistema deve permitir monitoramento em tempo real notificando problemas em menos de 1 hora| ❔ Ainda não testado | - | - | -   |
| 4  | A aplicação deve gerar pelo menos 3 dashboards validados pelo parceiro| ❔ Ainda não testado | -| - |-|
| 5  | O sistema deve emitir notificações e alertas sobre disastres ambientais em menos de 1 hora| ❔ Ainda não testado | - | -| - |
| 6  | Os dados devem ser disponibilizados em uma plataforma pública que aguente mais de mil acessos | ❔ Ainda não testado  | -| -| - |
| 7  | A aplicação deve ser capaz de parar o robô em menos de 10 segundo após a solicitação | ❔ Ainda não testado | - | - | - |
| 8  | Os dados devem ser coletados em tempo real com menos de 10 segundos de delay de envio|❔ Ainda não testado |- | -|
| 9  | O sistema deve aguentar grande volumetria de dados sendo capaz de armazenar mais 4 anos de dados|❔ Ainda não testado | - |  -  | - |
| 10  | O sistema deve tratar os dados em menos de 10 segundos | ❔ Ainda não testado  | - |-|

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
