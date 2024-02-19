---
sidebar_position: 2
slug: '/sprint_1/arquitetura/requisitos/nao-funcionais'
label: "Não Funcionais"
---

# Requisitos Não Funcionais

Os requisitos não funcionais descrevem as qualidades, atributos e restrições gerais de um sistema, determinando como ele deve ser, ao invés de quais funções específicas ele deve executar. Eles abrangem aspectos como desempenho, segurança, usabilidade, confiabilidade, compatibilidade, e escalabilidade, estabelecendo padrões para a operação, manutenção e evolução do sistema. Enquanto os requisitos funcionais se concentram nas operações específicas do software, os requisitos não funcionais são cruciais para garantir a qualidade geral do sistema, influenciando diretamente a experiência do usuário, a eficiência operacional e a facilidade de integração com outros sistemas ou tecnologias.

## Descrição

Os Requisitos Não Funcionais foram inicialmente delineados com base em consultas aos clientes, os stakeholders da “Prodan”. Suas perspectivas desempenharam um papel fundamental, especialmente na definição dos requisitos não funcionais relacionados a aspectos como desempenho, segurança e usabilidade.

Os demais Requisitos Não Funcionais, que dizem respeito à arquitetura e infraestrutura do projeto, foram concebidos por meio de deliberações entre os membros da equipe. Essas deliberações ocorreram após a análise do documento fornecido pelo orientador, denominado TAPI, e durante o processo de integração e orientação oferecido pelo orientador em relação ao problema específico.

Resumindo, a formulação dos Requisitos Não Funcionais, apresentados a seguir, emergiu de debates entre os integrantes da equipe durante encontros presenciais de desenvolvimento do projeto, embasados em nossa experiência acumulada em questões de escalabilidade, segurança e outras dimensões não funcionais.

### Tabela Descritiva

| Código  | Requisito Não Funcional                                                                                                                                                                    |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RNF 01  | O Sistema deve garantir a segurança das informações pessoais dos usuários registrados no sistema, encriptando os dados sensíveis com JWT ou SHA-256.                                        |
| RNF 02  | O dashboard deve possuir ao menos, autenticação e autorização de usuários admin que possam editar o dashboard, assegurando que apenas usuários com as permissões adequadas possam acessar informações restritas. |
| RNF 03  | A integração entre os sensores e a API deve ser capaz de suportar múltiplas requisições simultâneas (mais de duas), com um tempo de resposta máximo de 5 segundos por requisição.           |
| RNF 04  | O design da interface do dashboard deve ser intuitivo e acessível, seguindo as heurísticas de Nielsen para usabilidade e incluindo suporte para usuários com deficiência.                     |
| RNF 05  | O sistema deve assegurar alta confiabilidade nas informações coletadas e armazenadas, aderindo a padrões de identificação, qualidade de dados estabelecidos e conformidade com leis de proteção de dados LGPD e GDPR. |
| RNF 06  | Capacidade inicial de armazenar até 20GB de dados, com arquitetura projetada para facilitar a escalabilidade, permitindo um aumento no volume de operações sem degradação significativa do desempenho.                |
| RNF 07  | Processamento e geração de arquivos CSV para relatórios de operações deve ser concluído em menos de 30 segundos, garantindo eficiência e rapidez na disponibilização de dados.               |
| RNF 08  | Implementação de ferramentas de monitoramento e diagnóstico para acompanhar o desempenho do sistema em tempo real e identificar proativamente possíveis problemas.                          |
| RNF 09  | O design da interface do usuário deve ser responsivo, se adaptando pelo menos a telas de tamanho de 540px, garantindo uma experiência de usuário otimizada em dispositivos móveis como smartphones e tablets.           |
| RNF 10  | A arquitetura deve ser capaz de deixar no mínimo um nó kubernetes rodando, em caso de demanda alta, novos nós deverão ser criados.                                                             |

| Nº  | Tipo          | Descrição |
| --- | ------------- | --------- |
| 1   | Não-funcional | O sistema deve ser capaz de receber os dados enviados pelos 3 sensores lidando com mais de 100 mil requisições |
| 2   | Não-funcional | O sistema deve ser capaz de armazenar esses dados de forma que qualquer consulta não tome mais que 10 segundos|
| 3   | Não-funcional | O sistema deve permitir monitoramento em tempo real notificando problemas em menos de 1 minuto  |
| 4   | Não-funcional | A aplicação deve gerar pelo menos 3 dashboards validados pelo parceiro|
| 5   | Não-funcional | O sistema deve emitir notificações e alertas sobre disastres ambientais em menos de 10 minutos|
| 6   | Não-funcional | Os dados devem ser disponibilizados em uma plataforma pública que aguente mais de mil acessos|
| 7  | Não-funcional | Os dados devem ser coletados em tempo real com menos de 10 segundos de delay de envio|
| 8   | Não-funcional | O sistema deve aguentar grande volumetria de dados sendo capaz de armazenar mais 4 anos de dados|
| 9  | Não-funcional | O sistema deve tratar os dados em menos de 10 segundos|


## Planejamento de Validação dos Requisitos

Para garantir o cumprimento dos requisitos não funcionais listados, é essencial elaborar um conjunto de testes abrangente que cubra as diversas facetas de qualidade, segurança, desempenho, usabilidade e escalabilidade do sistema. Abaixo estão os planos de teste para cada requisito não funcional:

### RNF 01: Segurança de Informações Pessoais

**Objetivo do Teste:** Verificar a eficácia da encriptação de dados sensíveis utilizando JWT ou SHA-256.
- **Teste de Encriptação de Dados**
  - **Descrição:** Inserir dados sensíveis e verificar se estão sendo encriptados corretamente no banco de dados.
  - **Resultado Esperado:** Os dados sensíveis devem ser armazenados de forma encriptada, utilizando JWT ou SHA-256.

### RNF 02: Autenticação e Autorização de Usuários Admin

**Objetivo do Teste:** Assegurar que apenas usuários com permissões adequadas possam editar o dashboard e acessar informações restritas.
- **Teste de Controle de Acesso**
  - **Descrição:** Tentar acessar e editar o dashboard com diferentes perfis de usuário (admin e não admin).
  - **Resultado Esperado:** Apenas usuários admin devem ter a capacidade de editar o dashboard e acessar informações restritas.

### RNF 03: Suporte a Múltiplas Requisições Simultâneas

**Objetivo do Teste:** Confirmar que a integração entre os sensores e a API suporta múltiplas requisições simultâneas com um tempo de resposta adequado.
- **Teste de Carga**
  - **Descrição:** Simular mais de duas requisições simultâneas à API e medir o tempo de resposta.
  - **Resultado Esperado:** A API deve suportar as requisições simultâneas e responder a cada uma dentro do tempo máximo estipulado de 5 segundos.

### RNF 04: Usabilidade do Dashboard

**Objetivo do Teste:** Avaliar a intuitividade e acessibilidade da interface do dashboard.
- **Teste de Usabilidade**
  - **Descrição:** Conduzir testes de usabilidade com usuários, incluindo aqueles com deficiência, para avaliar a interface seguindo as heurísticas de Nielsen.
  - **Resultado Esperado:** A interface deve ser considerada intuitiva e acessível pelos usuários, cumprindo as heurísticas de Nielsen.

### RNF 05: Confiabilidade das Informações

**Objetivo do Teste:** Garantir a confiabilidade das informações coletadas e armazenadas.
- **Teste de Conformidade com Padrões**
  - **Descrição:** Verificar a aderência do sistema aos padrões de identificação e qualidade de dados, e às leis de proteção de dados LGPD e GDPR.
  - **Resultado Esperado:** O sistema deve cumprir integralmente com os padrões estabelecidos e legislações aplicáveis.

### RNF 06: Escalabilidade de Armazenamento

**Objetivo do Teste:** Confirmar a capacidade inicial de armazenamento e a facilidade de escalabilidade.
- **Teste de Capacidade de Armazenamento**
  - **Descrição:** Avaliar a capacidade de armazenamento inicial e simular um aumento no volume de dados.
  - **Resultado Esperado:** O sistema deve iniciar com uma capacidade de 20GB e permitir escalabilidade sem degradação significativa do desempenho.

### RNF 07: Eficiência na Geração de Relatórios

**Objetivo do Teste:** Assegurar a rapidez no processamento e geração de arquivos CSV.
- **Teste de Desempenho de Geração de Relatórios**
  - **Descrição:** Gerar relatórios de operações em formato CSV e medir o tempo de processamento.
  - **Resultado Esperado:** A geração de relatórios deve ser concluída em menos de 30 segundos.

### RNF 08: Monitoramento e Diagnóstico do Sistema

**Objetivo do Teste:** Verificar a implementação de ferramentas de monitoramento e diagnóstico.
- **Teste de Monitoramento**
  - **Descrição:** Utilizar as ferramentas de monitoramento para identificar proativamente possíveis problemas de desempenho.
  - **Resultado Esperado:** As ferramentas devem fornecer dados em tempo real sobre o desempenho do sistema e alertar sobre potenciais problemas.

### RNF 09: Responsividade da Interface do Usuário

**Objetivo do Teste:** Confirmar que a interface do usuário é responsiva e se adapta a dispositivos móveis.
- **Teste de Responsividade**
  - **Descrição:** Acessar o dashboard em dispositivos com telas de diferentes tamanhos, incluindo um mínimo de 540px.
  - **Resultado Esperado:** A interface deve se adaptar adequadamente, proporcionando uma experiência otimizada em smartphones e tablets.

### RNF 10: Escalabilidade da Arquitetura

**Objetivo do Teste:** Avaliar a capacidade da arquitetura em manter a operacionalidade sob demanda alta e escalar conforme necessário.
- **Teste de Escalabilidade**
  - **Descrição:** Simular uma alta demanda no sistema e verificar a criação de novos nós kubernetes automaticamente.
  - **Resultado Esperado:** A arquitetura deve manter no mínimo um nó em funcionamento e escalar adicionando novos nós conforme a demanda aumenta.

Esses testes devem ser acompanhados de métricas específicas, documentação detalhada dos procedimentos, e critérios claros de aceitação para garantir uma avaliação rigorosa do cumprimento dos requisitos não funcionais.

## Conclusão

Os requisitos não funcionais são fundamentais para garantir a qualidade, segurança, desempenho e usabilidade do sistema, e devem ser tratados com a mesma importância que os requisitos funcionais. Através de um planejamento de validação abrangente, é possível garantir que o sistema atenda a esses requisitos de forma eficaz, proporcionando uma experiência de usuário satisfatória e garantindo a confiabilidade e escalabilidade do sistema.