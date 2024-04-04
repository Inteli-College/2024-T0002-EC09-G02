---
sidebar_position: 2
slug: 'Arquitetura da solução'
---

# Testes de escalabilidade

## Teste de Integridade de Dados sob Alto Volume de Requisições

O sistema deve manter a integridade dos dados, definida pela inexistência de corrupção ou perda de dados, mesmo quando processando um mínimo de 10.000 transações por segundo.

### Precondição
- Configuração de um ambiente de teste de carga que replica a arquitetura de produção, incluindo dispositivos IoT simulados, HiveMQ, Kafka Confluent, MongoDB e Metabase.
- Implementação de um conjunto de dados de teste estruturados conforme {value, sensor, unit, region}.
- Ferramentas de teste de carga como JMeter ou Locust configuradas para gerar e enviar mensagens ao HiveMQ.

### Passo a Passo

1. Geração de Dados de Teste: Desenvolver um script que cria mensagens de teste seguindo o padrão {value, sensor, unit, region}. Assegurar que cada mensagem tenha um identificador único para validação posterior.
2. Simulação de Alto Volume: Configurar a ferramenta de teste de carga para simular o envio de mensagens ao HiveMQ a uma taxa de 10.000 mensagens por segundo Iniciar a simulação e monitorar o desempenho do sistema, verificando a latência e o throughput.
3. Monitoramento de Integridade: Utilizar ferramentas de monitoramento, como Wireshark ou similar, para capturar o tráfego de rede e verificar a transmissão segura de mensagens via TLS. Configurar um consumidor no Kafka Confluent que subscreva ao tópico específico e que valide a integridade de cada mensagem recebida, comparando com os dados enviados.
4. Validação no MongoDB: Elaborar um script que consulta o MongoDB para verificar se todos os dados recebidos estão presentes e consistentes.
O script deve reportar quaisquer discrepâncias ou dados faltantes.
5. Análise Final: Comparar o número de mensagens enviadas com as mensagens recebidas e armazenadas no MongoDB. Gerar um relatório final detalhando a taxa de sucesso, as falhas detectadas e as métricas de desempenho.
   
### Pós-condição
- Os dados no MongoDB devem refletir exatamente os dados enviados, confirmando a integridade e a resiliência do sistema.
- Os resultados do teste devem ser registrados em um relatório, fornecendo evidências da integridade dos dados e identificando possíveis áreas para melhoria do sistema.