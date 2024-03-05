---
sidebar_position: 4
slug: '/sprint_2/MQTT/testes-mqtt'
label: "Testes do MQTT"
---

# Testes
Este documento fornece detalhes sobre a suite de testes para o módulo publisher do sistema, que interage com o AWS IoT Core usando MQTT para publicar e inscrever-se em tópicos. A suite de testes foi projetada para validar funcionalidades críticas do sistema, incluindo conexão, publicação, autenticação, autorização de tópicos e inserção de dados no DynamoDB. Uma "Thing" dedicada, uma regra e uma tabela no DynamoDB foram criadas especificamente para estes testes.

### Dependências

**Pacotes Python:** time, json, pytest, boto3, uuid

**Módulos Externos:** simulator.generic_sensor.publisher, awscrt.mqtt, awscrt.http

**Certificados:** Certificados e chaves de teste são necessários para autenticação no AWS IoT Core.

### Constantes
- IOT_ENDPOINT: Endpoint específico do AWS IoT Core.
- PORT: Porta MQTT padrão para conexões seguras (8883).
= CERT_PATH, KEY_PATH, CA_CERT: Caminhos para os arquivos de certificado e chave.
- CLIENT_ID_PUB, CLIENT_ID_SUB, CLIENT_ID_PUBSUB, CLIENT_ID_DYNAMO: Identificadores únicos de cliente MQTT para diferentes casos de teste.
- TEST_TOPIC, AUTH_TOPIC, WRONG_TOPIC: Tópicos MQTT utilizados nos testes.

### Variáveis Globais
received_message: Dicionário utilizado para armazenar mensagens MQTT recebidas durante os testes.

### Funções de Teste
- test_connect: Valida a conexão com o AWS IoT Core.
- test_publish: Verifica a capacidade de publicar e receber mensagens em um tópico.
- test_authenticate: Testa a autenticação com várias configurações de certificados.
- test_publishing_topic_authorization: Confirma se a autorização de tópico está funcionando conforme esperado ao publicar.
- test_subscribing_topic_authorization: Assegura que a autorização de tópico está em vigor ao inscrever-se.
- test_inset_into_dynamodb: Avalia a inserção de dados no DynamoDB após a publicação em um tópico MQTT.

## Uso
Para executar os testes, utilize o comando pytest -v no diretório do projeto onde os testes estão localizados.

### Detalhes dos Testes

**test_connect**

```python
def test_connect():
    connection, result = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, KEY_PATH, CA_CERT, CLIENT_ID_PUB)
    assert result['session_present']
```

Este teste confirma a capacidade do cliente de estabelecer uma conexão MQTT com o AWS IoT Core usando as credenciais fornecidas. Ele assegura que a session_present na resposta seja verdadeira, indicando uma conexão bem-sucedida.

**test_publish**

```python
def test_publish():
    global received_message
    received_message = {'message': 'no message received'}

    mqtt_connection, _ = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, KEY_PATH, CA_CERT, CLIENT_ID_SUB)
    message_id = str(uuid.uuid4())
    message = {'test': 'this is the test message', 'id': message_id}

    publisher.publish_message(mqtt_connection, TEST_TOPIC, json.dumps(message))

    subscribe_future, _ = mqtt_connection.subscribe(
        topic=TEST_TOPIC,
        qos=mqtt.QoS.AT_LEAST_ONCE,
        callback=on_message_received
    )

    subscribe_result = subscribe_future.result()

    time.sleep(1)
    assert received_message == message
```

A função test_publish envia uma mensagem para um tópico e inscreve-se nesse mesmo tópico esperando receber a mensagem. O teste verifica se a mensagem recebida é idêntica à mensagem enviada.

**test_authenticate**

```python
def test_authenticate():
    _, result = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, KEY_PATH, CA_CERT, CLIENT_ID_PUB)
    assert result['session_present']

    with pytest.raises(Exception):
        _, result = publisher.connect_mqtt(IOT_ENDPOINT, PORT, './authentication-keys/empty_cert.pem', KEY_PATH, CA_CERT, CLIENT_ID_PUB)
        assert not result['session_present']

    with pytest.raises(Exception):
        _, result = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, './authentication-keys/empty_key.pem', CA_CERT, CLIENT_ID_PUB)
        assert not result['session_present']

    with pytest.raises(Exception):
        _, result = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, KEY_PATH, './authentication-keys/empty_root-CA.crt', CLIENT_ID_PUB)
        assert not result['session_present']
```

test_authenticate avalia várias configurações de certificados para garantir que apenas clientes com certificados válidos possam se conectar ao AWS IoT Core. Espera-se que o teste lance exceções com certificados vazios ou inválidos, assegurando a segurança do sistema.

**test_publishing_topic_authorization**

```python
def test_publishing_topic_authorization():
    global received_message
    received_message = {'message': 'no message received'}

    mqtt_connection, _ = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, KEY_PATH, CA_CERT, CLIENT_ID_PUBSUB)

    subscribe_future, _ = mqtt_connection.subscribe(
        topic=AUTH_TOPIC,
        qos=mqtt.QoS.AT_LEAST_ONCE,
        callback=on_message_received
    )

    subscribe_result = subscribe_future.result()

    message_id = str(uuid.uuid4())
    message = {'test': 'this is the test message', 'id': message_id}

    publisher.publish_message(mqtt_connection, WRONG_TOPIC, json.dumps(message))

    time.sleep(1)

    assert not received_message == message
```

Este teste verifica se a autorização de tópico para publicação está corretamente configurada. O cliente tenta publicar em um tópico ao qual não deve ter acesso e verifica se a mensagem não é recebida.

**test_subscribing_topic_authorization**

```python
def test_subscribing_topic_authorization():
    global received_message
    received_message = {'message': 'no message received'}

    mqtt_connection, _ = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, KEY_PATH, CA_CERT, CLIENT_ID_SUB)

    subscribe_future, _ = mqtt_connection.subscribe(
        topic=TEST_TOPIC,
        qos=mqtt.QoS.AT_LEAST_ONCE,
        callback=on_message_received
    )

    subscribe_result = subscribe_future.result()
    assert subscribe_result['topic'] == TEST_TOPIC

    subscribe_future, _ = mqtt_connection.subscribe(
        topic=WRONG_TOPIC,
        qos=mqtt.QoS.AT_LEAST_ONCE,
        callback=on_message_received
    )
    time.sleep(1)
    assert not subscribe_future.done()
```

Similar ao teste de autorização de publicação, test_subscribing_topic_authorization verifica se o cliente pode se inscrever em tópicos para os quais tem permissão e não em outros.

**test_insertion_into_dynamodb**

```python
def test_insertion_into_dynamodb():
    mqtt_connection, _ = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, KEY_PATH, CA_CERT, CLIENT_ID_DYNAMO)
    message_id = str(uuid.uuid4())
    message = {'test': 'this is the test message', 'id': message_id}

    publisher.publish_message(mqtt_connection, TEST_TOPIC, json.dumps(message))


    dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
    table_name = 'sensorTest'
    table = dynamodb.Table(table_name)

    response = table.scan(FilterExpression=boto3.dynamodb.conditions.Attr('id').eq(message_id))
    assert len(response['Items']) >= 1
```

test_insertion_into_dynamodb publica uma mensagem e verifica se a mesma foi corretamente inserida na tabela DynamoDB de testes, assegurando a integração entre o MQTT e o banco de dados.

## Execução dos Testes
Antes de executar os testes, confirme se todos os recursos de testes, incluindo a Thing, regra e tabela DynamoDB, estão corretamente configurados e se as políticas de acesso estão devidamente aplicadas. Os testes podem ser executados em um ambiente de desenvolvimento local ou em um pipeline CI/CD para validação automatizada antes da implementação em produção. Atualmente, uma pipeline está disponível no GitHub Actions. O sucesso de todos os testes é essencial antes de qualquer implementação para garantir a integridade do sistema.

## Manutenção e Extensão
Os testes devem ser mantidos e estendidos conforme o sistema evolui. A adição de novas funcionalidades ou alterações na configuração do AWS IoT Core exigirá atualizações correspondentes na suite de testes. A cobertura de teste deve ser revista regularmente para garantir que todos os aspectos críticos do sistema sejam validados.