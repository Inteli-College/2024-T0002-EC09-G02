---
sidebar_position: 2
slug: 'Escalabilidade'
---

# Testes de escalabilidade

## Teste de Integridade de Dados sob Alto Volume de Requisições

O sistema deve manter a integridade dos dados, definida pela inexistência de corrupção ou perda de dados, mesmo quando processando um mínimo de 10.000 transações por segundo.

### Precondição
- Configuração de um ambiente de teste de carga que replica a arquitetura de produção, incluindo dispositivos IoT simulados, HiveMQ, Kafka Confluent, MongoDB e Metabase.
- Implementação de um conjunto de dados de teste estruturados conforme \{value, sensor, unit, region}.
- Ferramentas de teste de carga como JMeter ou Locust configuradas para gerar e enviar mensagens ao HiveMQ.

### Passo a Passo

1. Geração de Dados de Teste: Desenvolver um script que cria mensagens de teste seguindo o padrão \{value, sensor, unit, region}. Assegurar que cada mensagem tenha um identificador único para validação posterior.
2. Simulação de Alto Volume: Configurar a ferramenta de teste de carga para simular o envio de mensagens ao HiveMQ a uma taxa de 10.000 mensagens por segundo Iniciar a simulação e monitorar o desempenho do sistema, verificando a latência e o throughput.
3. Monitoramento de Integridade: Utilizar ferramentas de monitoramento, como Wireshark ou similar, para capturar o tráfego de rede e verificar a transmissão segura de mensagens via TLS. Configurar um consumidor no Kafka Confluent que subscreva ao tópico específico e que valide a integridade de cada mensagem recebida, comparando com os dados enviados.
4. Validação no MongoDB: Elaborar um script que consulta o MongoDB para verificar se todos os dados recebidos estão presentes e consistentes.
O script deve reportar quaisquer discrepâncias ou dados faltantes.
5. Análise Final: Comparar o número de mensagens enviadas com as mensagens recebidas e armazenadas no MongoDB. Gerar um relatório final detalhando a taxa de sucesso, as falhas detectadas e as métricas de desempenho.
   
### Pós-condição
- Os dados no MongoDB devem refletir exatamente os dados enviados, confirmando a integridade e a resiliência do sistema.
- Os resultados do teste devem ser registrados em um relatório, fornecendo evidências da integridade dos dados e identificando possíveis áreas para melhoria do sistema.

### Exemplo de código de teste

O script Python fornecido realiza um teste automatizado de integração entre um broker MQTT (HiveMQ), um servidor Kafka e um banco de dados MongoDB. Ele publica uma mensagem estruturada em JSON no HiveMQ e verifica se essa mensagem é corretamente passada para o Kafka e, por fim, armazenada no MongoDB sem perdas ou alterações. O teste conecta-se ao HiveMQ, publica a mensagem, consome-a do Kafka, checa-a no MongoDB e, finalmente, confirma a sua integridade comparando a mensagem armazenada com a mensagem original. O sucesso das operações é reportado passo a passo no console, fornecendo uma forma rápida e confiável de verificar a integridade do fluxo de dados no sistema.

```python
import json
import time
from paho.mqtt import client as mqtt_client
from kafka import KafkaConsumer, KafkaProducer
from pymongo import MongoClient

broker = 'endereco_do_servidor_hivemq'
port = 1883
topic = 'seu/topico/mqtt'
client_id = 'test_mqtt_client_id'
kafka_topic = 'seu_topico_kafka'
kafka_server = 'endereco_do_servidor_kafka'
mongo_conn_str = 'string_de_conexao_mongo'
mongo_db_name = 'nome_do_banco_de_dados'
mongo_collection_name = 'nome_da_colecao_de_teste'

mongo_client = MongoClient(mongo_conn_str)
mongo_db = mongo_client[mongo_db_name]
mongo_collection = mongo_db[mongo_collection_name]

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT Broker!")
    else:
        print(f"Failed to connect, return code {rc}\n")

mqtt_client = mqtt_client.Client(client_id)
mqtt_client.on_connect = on_connect
mqtt_client.connect(broker, port)
mqtt_client.loop_start()

kafka_consumer = KafkaConsumer(
    kafka_topic,
    bootstrap_servers=kafka_server,
    auto_offset_reset='earliest',
    enable_auto_commit=True,
    group_id='my-group',
    value_deserializer=lambda x: json.loads(x.decode('utf-8'))
)

test_message = {"value": 25.5, "sensor": "sensor-123", "unit": "Celsius", "region": "eu-central-1"}
mqtt_client.publish(topic, json.dumps(test_message))
print(f"Mensagem enviada para o MQTT: {test_message}")

for message in kafka_consumer:
    print(f"Mensagem recebida do Kafka: {message.value}")
    if message.value == test_message:
        print("A mensagem do MQTT foi recebida pelo Kafka com sucesso.")
        break
    else:
        print("Mensagem não corresponde, aguardando a próxima mensagem...")

mongo_stored_document = mongo_collection.find_one({"sensor": "sensor-123"})
if mongo_stored_document and mongo_stored_document == test_message:
    print(f"A mensagem foi verificada no MongoDB com sucesso: {mongo_stored_document}")
else:
    print("A mensagem não foi encontrada ou não corresponde no MongoDB.")

mqtt_client.loop_stop()
mqtt_client.disconnect()

kafka_consumer.close()

```

#### Considerações

1. O endereço do servidor HiveMQ, o tópico MQTT, o servidor Kafka e os detalhes de conexão do MongoDB devem ser atualizados para corresponder ao ambiente de teste.
2. Este código assume que as mensagens do MQTT são automaticamente encaminhadas para o Kafka, que é uma configuração que o broker HiveMQ ou uma ponte configurada para esse fim deve ter.
3. Devem existir permissões apropriadas e a estrutura de tópicos configurada corretamente em ambos os sistemas de mensagens.
4. O consumidor Kafka começa a ouvir as mensagens a partir do início do tópico (auto_offset_reset='earliest'). Para um teste em tempo real, pode ser necessário reajustar isso.
5. Os dados inseridos no MongoDB são verificados ao final para confirmar se a mensagem recebida é exatamente aquela que foi enviada pelo MQTT.

## Teste de Tempo de Resposta sob Alto Volume de Requisições

O sistema deve manter um tempo de resposta dentro dos limites aceitáveis, mesmo quando submetido a um alto volume de requisições. Para este requisito não funcional, definimos que o tempo de resposta da API não deve exceder 200 milissegundos por requisição para um volume de tráfego de até 10.000 requisições por segundo.

### Precondições
- Um ambiente de teste que imita o ambiente de produção está configurado e operacional.
- O endpoint de API que será testado está funcionando e acessível.
- A ferramenta de teste de carga locust está instalada e configurada.

### Passo a Passo
1. Configuração do Locust: Escrever um script locustfile.py que define o comportamento do usuário simulado que interage com o sistema. O script deverá especificar as requisições a serem feitas e os dados a serem enviados.
2. Execução do Locust: Rodar o locust com o script criado, especificando o número de usuários simultâneos (concorrência) e a taxa de geração de novos usuários para simular o alto volume de tráfego.
3. Monitoramento: Observar em tempo real o dashboard do locust, que exibe estatísticas como o número de requisições por segundo, o tempo de resposta médio e o número de falhas.
4. Avaliação dos Resultados: Após a execução do teste, analisar os resultados fornecidos pelo locust, focando no tempo de resposta e na taxa de falhas.
5. Documentação e Análise: Documentar os resultados do teste e, se o tempo de resposta exceder o limite especificado, realizar uma análise para identificar gargalos e propor soluções.

### Pós-condições
- O sistema deve ter processado todas as requisições dentro do tempo de resposta estipulado.
- Um relatório de teste deve estar disponível, detalhando o desempenho do sistema sob carga e quaisquer recomendações para melhorias, se necessário.

### Exemplo de código de teste

Este código demonstra como utilizar a ferramenta locust para simular um alto volume de requisições, especificamente 10.000 por segundo, a um endpoint de publicação de mensagens, visando avaliar o desempenho e a capacidade de resposta de um sistema sob condições de carga extrema. Utilizando um payload definido e headers de requisição, o script automatiza o envio de dados JSON para simular o comportamento de dispositivos IoT que interagem com o sistema, oferecendo insights críticos sobre a escalabilidade e estabilidade do endpoint testado. Este teste é crucial para garantir que o sistema mantenha um tempo de resposta adequado, mesmo quando submetido a um fluxo intenso de dados.


```python
from locust import HttpUser, task, between

class MQTTAPITest(HttpUser):
    wait_time = between(0.0001, 0.0001)  # Para atingir aproximadamente 10.000 requisições por segundo

    @task
    def publish_message(self):
        payload = {"value": 25.5, "sensor": "sensor-123", "unit": "Celsius", "region": "eu-central-1"}
        headers = {'content-type': 'application/json'}
        self.client.post("/publish", json=payload, headers=headers)

```

 Para rodar este teste, utilize o comando:


```
 locust -f locustfile.py --headless -u 10000 -r 10000 --run-time 1m --stop-timeout 99
```

#### Considerações

- Configuração do Locust: Este exemplo utiliza a biblioteca locust para simular uma alta carga de requisições ao sistema, especificamente ao endpoint responsável por publicar mensagens de dispositivos IoT. A classe MQTTAPITest define o comportamento dos usuários simulados, que postam uma mensagem JSON em um intervalo praticamente inexistente (wait_time), para atingir a meta de 10.000 requisições por segundo.
- Ajuste de Parâmetros: Os parâmetros no comando locust são ajustáveis conforme a necessidade. O exemplo dado configura o teste para rodar em modo headless (sem interface gráfica) com 10.000 usuários (-u 10000), uma taxa de geração de usuários que alcança rapidamente o total desejado (-r 10000), e uma duração total de teste de um minuto (--run-time 1m).
- Endpoint de Teste: O endpoint /publish utilizado no script deve ser substituído pelo endpoint real que você deseja testar. Assegure-se de que este endpoint é capaz de processar as mensagens de acordo com o formato JSON especificado no payload.
- Monitoramento e Análise: Embora este teste gere uma grande quantidade de requisições, é fundamental monitorar não apenas o tempo de resposta, mas também a taxa de erros e o comportamento geral do sistema sob teste. Utilize os relatórios gerados pelo Locust e, se possível, outras ferramentas de monitoramento de desempenho para analisar o impacto da carga no sistema.
- Execução Segura: Certifique-se de que o teste seja realizado em um ambiente controlado, preferencialmente um ambiente de teste ou staging que simule a produção, para evitar impactos negativos em sistemas em produção.

## Avaliação da Alta Disponibilidade do Sistema sob Carga Elevada

A disponibilidade contínua de um sistema, especialmente sob condições de carga intensa, é crucial para manter a confiança dos usuários e a integridade dos processos de negócios. Para assegurar que o sistema atende a expectativas de alta disponibilidade, é essencial desenvolver e executar testes específicos. Neste contexto, a alta disponibilidade é quantificada pela capacidade do sistema de manter uma taxa de sucesso de resposta acima de 99.9% durante um período de teste sob uma carga de 10.000 requisições por segundo.

### Pré-condições
- Ambiente de Teste: Configuração de um ambiente que simula fielmente o ambiente de produção, incluindo a infraestrutura de rede, servidores e balanceadores de carga, se aplicável.
- Ferramentas de Teste: Instalação e configuração da ferramenta de teste de carga locust, além de sistemas de monitoramento e logging capazes de registrar taxas de resposta e falhas em tempo real.
- Endpoint Alvo: O endpoint ou serviço que será submetido ao teste deve estar claramente identificado e configurado para coletar métricas detalhadas de desempenho.

### Passo a Passo
- Definição do Cenário de Teste: Implementar um script locustfile.py que especifica o comportamento dos usuários simulados, direcionando a carga para o endpoint escolhido.
- Execução do Teste de Carga: Iniciar o locust com o script de teste, ajustando o número de usuários simulados e a taxa de hatch para alcançar o volume desejado de requisições por segundo.
- Monitoramento em Tempo Real: Utilizar ferramentas de monitoramento para acompanhar a saúde do sistema, incluindo uso de CPU, memória, largura de banda de rede e, mais importante, a taxa de respostas bem-sucedidas versus falhas.
- Coleta e Análise de Dados: Após a conclusão do teste, analisar os dados coletados para avaliar a disponibilidade do sistema. Isso inclui verificar logs, métricas de desempenho e quaisquer alertas de saúde do sistema.
- 
### Pós-condições
- Avaliação da Disponibilidade: O sistema deve ter mantido a taxa de disponibilidade acima de 99.9%, indicando sucesso no teste.
- Relatório de Teste: Produção de um relatório detalhado que documenta o desempenho do sistema durante o teste, incluindo qualquer incidente de degradação de serviço e as respectivas causas, se identificadas.


### Exemplo de código de teste

Este script de teste, criado com o uso da ferramenta locust, é projetado para avaliar a alta disponibilidade de um sistema sob uma carga significativa de requisições. O objetivo é simular um cenário em que 10.000 usuários fazem requisições simultaneamente a um endpoint específico, permitindo verificar se o sistema consegue manter uma taxa de disponibilidade acima de 99.9%, mesmo sob estas condições extremas de tráfego.


```python
from locust import HttpUser, task, between

class MQTTAPITest(HttpUser):
    wait_time = between(0.0001, 0.0001)  # Para atingir aproximadamente 10.000 requisições por segundo

    @task
    def publish_message(self):
        payload = {"value": 25.5, "sensor": "sensor-123", "unit": "Celsius", "region": "eu-central-1"}
        headers = {'content-type': 'application/json'}
        self.client.post("/publish", json=payload, headers=headers)

```

 Para rodar este teste, utilize o comando:


```
 locust -f locustfile.py --headless -u 10000 -r 10000 --run-time 1m --stop-timeout 99
```