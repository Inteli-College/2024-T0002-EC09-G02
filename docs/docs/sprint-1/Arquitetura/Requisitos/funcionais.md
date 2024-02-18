---
sidebar_position: 1
slug: '/sprint_1/arquitetura/requisitos/funcionais'
label: "Funcionais"
---
# Requisitos Funcionais


Requisitos funcionais descrevem as funções específicas, comportamentos e serviços que um sistema deve oferecer para atender às necessidades e expectativas dos usuários. Eles detalham o que o sistema deve fazer, as ações que deve ser capaz de executar e as respostas esperadas em diversas situações. Esses requisitos são orientados pelas funcionalidades do sistema, cobrindo aspectos como processamento de dados, operações de entrada e saída, manipulação de informações e interações com o usuário.

## Descrição

Os requisitos funcionais foram inicialmente definidos com base em entrevistas com os clientes e os stakeholders da "Prodan". As contribuições desses entrevistados foram essenciais, sobretudo para os requisitos funcionais que dizem respeito às funcionalidades envolvendo a interação da arquitetura, a interface do usuário e os dispositivos de hardware (sensores).

Os demais requisitos funcionais, voltados para a estruturação do projeto, foram elaborados durante discussões entre os membros do grupo. Essas discussões ocorreram após a análise do documento fornecido pelo orientador, conhecido como TAPI, e também durante o processo de integração e orientação sobre o problema em questão.

Em resumo, a definição dos requisitos funcionais, detalhados a seguir, emergiu de discussões entre os membros do grupo em reuniões presenciais de desenvolvimento do projeto, apoiadas em nosso conhecimento prévio sobre modelagem de sistemas e experiência do usuário. É importante destacar que os responsáveis pela solução são:

### Tabela Descritiva

| Código | Requisito Funcional                                                                                                 |
|--------|---------------------------------------------------------------------------------------------------------------------|
| RF 01  | O dashboard deve oferecer a funcionalidade de exportar relatórios dos dados coletados em formato CSV, incluindo a filtragem por data, sensor e tipo de dados. |
| RF 02  | O sistema deve manter um armazenamento histórico das entradas de dados dos sensores, garantindo a retenção de dados por no mínimo 5 anos para facilitar análises retrospectivas e auditorias. |
| RF 03  | O sistema deve possuir a implementação de um módulo administrativo capaz de gerenciar usuários, configurar sensores, e controlar as permissões de acesso às informações, com logs de atividades para auditoria. |
| RF 04  | O dashboard deve possuir um módulo de visualização pública, disponibilizando informações atualizadas sobre condições marítimas, acessível sem necessidade de autenticação. |
| RF 05  | O dashboard deve integrar gráficos dinâmicos e interativos, como gráficos de linha, barra e mapa de calor, para aprimorar a compreensão das informações coletadas. |
| RF 06  | O sistema deve incluir um processo de normalização para os dados recebidos dos sensores, garantindo que estejam em um formato padrão e consistente antes de serem armazenados ou processados. |
| RF 07  | O sistema deve possuir a capacidade de integrar dados de sensores com sistemas externos e plataformas de terceiros via API, facilitando o compartilhamento e análise de dados em diferentes aplicações. |
| RF 08  | O sistema deve fornecer alertas em tempo real baseados em critérios pré-definidos (ex.: condições meteorológicas adversas, falhas de sensores), enviando notificações para os administradores e usuários relevantes. |
| RF 09  | O sistema deve possuir a funcionalidade de filtragem e pesquisa avançada que permitam aos usuários localizar rapidamente informações específicas baseadas em múltiplos critérios (ex.: data, tipo de sensor, localização). |
| RF 10  | A arquitetura do sistema deve possuir uma estratégia de backup e recuperação para garantir a integridade e disponibilidade dos dados históricos em caso de falha de sistema ou desastres. |


## Planejamento de Validação dos Requisitos

Para garantir o cumprimento dos requisitos funcionais (RFs) listados, é necessário elaborar planos de teste detalhados que abordem diversos cenários e condições. Vamos detalhar testes para cada requisito funcional:

### RF 01: Exportação de Relatórios em CSV

**Objetivo do Teste:** Verificar a funcionalidade de exportação de relatórios com filtragem por data, sensor e tipo de dados.

1. **Teste de Exportação Básica**
   - **Descrição:** Exportar relatórios sem aplicar nenhum filtro.
   - **Resultado Esperado:** O relatório deve ser exportado em formato CSV, contendo todos os dados disponíveis.

2. **Teste de Filtragem por Data**
   - **Descrição:** Aplicar filtro por uma faixa de datas específica e exportar o relatório.
   - **Resultado Esperado:** O relatório exportado deve conter apenas os dados dentro da faixa de datas especificada.

3. **Teste de Filtragem por Sensor**
   - **Descrição:** Aplicar filtro por um tipo específico de sensor e exportar o relatório.
   - **Resultado Esperado:** O relatório deve incluir apenas dados do sensor especificado.

4. **Teste de Filtragem por Tipo de Dados**
   - **Descrição:** Aplicar filtro por um tipo específico de dados (ex.: temperatura, pressão) e exportar o relatório.
   - **Resultado Esperado:** O relatório deve conter apenas os dados do tipo especificado.

### RF 02: Armazenamento Histórico de Dados

**Objetivo do Teste:** Garantir a retenção de dados dos sensores por no mínimo 5 anos.

1. **Teste de Retenção de Dados**
   - **Descrição:** Verificar se os dados estão disponíveis e acessíveis após 5 anos.
   - **Resultado Esperado:** Dados de até 5 anos atrás devem estar acessíveis e íntegros.

### RF 03: Módulo Administrativo

**Objetivo do Teste:** Verificar a funcionalidade do módulo administrativo em gerenciar usuários, configurar sensores e controlar permissões.

1. **Teste de Gerenciamento de Usuários**
   - **Descrição:** Criar, editar e excluir usuários no sistema.
   - **Resultado Esperado:** As operações de gerenciamento de usuários devem ser realizadas com sucesso e refletidas no sistema.

2. **Teste de Configuração de Sensores**
   - **Descrição:** Adicionar, modificar e remover configurações de sensores.
   - **Resultado Esperado:** As alterações nas configurações dos sensores devem ser aplicadas corretamente.

3. **Teste de Controle de Permissões**
   - **Descrição:** Atribuir e modificar permissões de acesso para diferentes usuários.
   - **Resultado Esperado:** As permissões devem ser efetivamente controladas e refletidas nas funcionalidades acessíveis pelos usuários.

### RF 04: Módulo de Visualização Pública

**Objetivo do Teste:** Confirmar que informações atualizadas sobre condições marítimas são acessíveis publicamente.

1. **Teste de Acesso Público**
   - **Descrição:** Acessar o módulo de visualização pública sem autenticação.
   - **Resultado Esperado:** Informações atualizadas sobre condições marítimas devem ser exibidas sem necessidade de login.

### RF 05: Gráficos Dinâmicos e Interativos

**Objetivo do Teste:** Verificar a integração e funcionalidade dos gráficos dinâmicos.

1. **Teste de Gráficos de Linha**
   - **Descrição:** Verificar a exibição e interatividade dos gráficos de linha.
   - **Resultado Esperado:** Gráficos de linha devem exibir dados corretamente e permitir interações como zoom e filtragem.

2. **Teste de Gráficos de Barra**
   - **Descrição:** Avaliar a exibição de gráficos de barra com diferentes conjuntos de dados.
   - **Resultado Esperado:** Gráficos de barra devem representar os dados de forma clara e permitir comparação entre categorias.

3. **Teste de Mapa de Calor**
   - **Descrição:** Avaliar a funcionalidade e a apresentação do mapa de calor com base nos dados coletados.
   - **Resultado Esperado:** O mapa de calor deve visualizar corretamente a distribuição e intensidade dos dados, com interatividade para detalhamento.

### RF 06: Normalização dos Dados dos Sensores

**Objetivo do Teste:** Assegurar que os dados recebidos dos sensores são normalizados para um formato padrão e consistente.

1. **Teste de Normalização de Dados**
   - **Descrição:** Inserir dados em formatos variados provenientes de diferentes sensores e verificar o processo de normalização.
   - **Resultado Esperado:** Independentemente do formato original, os dados devem ser convertidos para o formato padrão definido pelo sistema.

### RF 07: Integração com Sistemas Externos

**Objetivo do Teste:** Confirmar a capacidade de integração de dados com sistemas externos e plataformas de terceiros via API.

1. **Teste de Integração de API**
   - **Descrição:** Configurar uma integração com uma plataforma de terceiros e enviar dados dos sensores.
   - **Resultado Esperado:** Os dados devem ser transmitidos corretamente para a plataforma externa, conforme as especificações da API.

### RF 08: Alertas em Tempo Real

**Objetivo do Teste:** Verificar a eficácia do sistema em gerar e enviar alertas com base em critérios pré-definidos.

1. **Teste de Geração de Alertas**
   - **Descrição:** Simular condições que atendam aos critérios de alerta (ex.: condições meteorológicas adversas).
   - **Resultado Esperado:** Alertas devem ser gerados e enviados aos administradores e usuários relevantes imediatamente.

### RF 09: Filtragem e Pesquisa Avançada

**Objetivo do Teste:** Avaliar a funcionalidade de pesquisa e filtragem avançada no sistema.

1. **Teste de Filtragem por Múltiplos Critérios**
   - **Descrição:** Realizar pesquisas utilizando múltiplos critérios simultaneamente (ex.: data, tipo de sensor, localização).
   - **Resultado Esperado:** Os resultados da pesquisa devem corresponder exatamente aos critérios especificados.

### RF 10: Estratégia de Backup e Recuperação

**Objetivo do Teste:** Confirmar a eficácia da estratégia de backup e recuperação de dados.

1. **Teste de Backup de Dados**
   - **Descrição:** Realizar um backup dos dados do sistema conforme a estratégia definida.
   - **Resultado Esperado:** O backup deve ser completado com sucesso e os dados devem ser integralmente preservados.

2. **Teste de Recuperação de Dados**
   - **Descrição:** Simular uma falha de sistema e realizar o processo de recuperação de dados a partir do backup mais recente.
   - **Resultado Esperado:** Os dados devem ser recuperados com sucesso e o sistema deve retornar ao estado operacional anterior à falha.

Para cada teste, é importante documentar o procedimento, os dados de entrada, o resultado esperado e o resultado obtido. Além disso, testes adicionais podem ser necessários para cobrir aspectos específicos de implementação, segurança, desempenho e usabilidade, garantindo uma avaliação completa da conformidade com os requisitos funcionais.

## Conclusão

Os requisitos funcionais são uma componente essencial da engenharia de software, desempenhando um papel vital em praticamente todas as fases do desenvolvimento de software, desde a concepção inicial até a implementação, teste e manutenção. Uma definição clara e abrangente de requisitos funcionais é um investimento que se traduz em eficiência de desenvolvimento, satisfação do usuário e sucesso do projeto a longo prazo.