"""
Overview:
This script defines and executes various tests for the 'publisher' module, which interacts with
AWS IoT Core using MQTT to publish and subscribe to topics. The tests cover connection, publishing,
authentication, topic authorization, and data insertion into DynamoDB.

Dependencies:
- Python packages: time, json, pytest, boto3, uuid
- External modules: simulator.generic_sensor.publisher, awscrt.mqtt, awscrt.http

Constants:
- IOT_ENDPOINT: AWS IoT Core endpoint
- PORT: MQTT port
- CERT_PATH, KEY_PATH, CA_CERT: Paths to certificate and key files
- CLIENT_ID_PUB, CLIENT_ID_SUB, CLIENT_ID_PUBSUB, CLIENT_ID_DYNAMO: MQTT client IDs
- TEST_TOPIC, AUTH_TOPIC, WRONG_TOPIC: MQTT topics for testing

Global Variables:
- received_message: Dictionary to store received MQTT messages during tests

Functions:
- test_connect: Test connection to AWS IoT Core
- test_publish: Test publishing a message and subscribing to the same topic
- test_authenticate: Test authentication with various certificate configurations
- test_publishing_topic_authorization: Test topic authorization for publishing
- test_subscribing_topic_authorization: Test topic authorization for subscribing
- test_insertion_into_dynamodb: Test insertion of data into DynamoDB

Callbacks:
- on_message_received: Callback when a message is received on a subscribed topic

Usage:
Run 'pytest -v' on the src directory to execute the tests.
"""

import time
import json
import pytest
import boto3
import uuid
from simulator.generic_sensor import publisher
from awscrt import mqtt, http

# Constants
IOT_ENDPOINT = 'a32jmg845uczmw-ats.iot.us-east-1.amazonaws.com'
PORT = 8883
CERT_PATH = './authentication-keys/test_cert.pem'
KEY_PATH = './authentication-keys/test_key.pem'
CA_CERT = './authentication-keys/root-CA.crt'
CLIENT_ID_PUB = 'test_pub'
CLIENT_ID_SUB = 'test_sub'
CLIENT_ID_PUBSUB = 'test_pubsub'
CLIENT_ID_DYNAMO = 'test_sub'
TEST_TOPIC = 'test/test'
AUTH_TOPIC = 'test/publishing_topic_authorization'
WRONG_TOPIC = 'wrong_topic'


# Global variables
received_message = {'message': 'no message received'}


def test_connect():
    connection, result = publisher.connect_mqtt(IOT_ENDPOINT, PORT, CERT_PATH, KEY_PATH, CA_CERT, CLIENT_ID_PUB)
    assert result['session_present']


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


def on_message_received(topic, payload, **kwargs):
    print("Received message from topic '{}': {}".format(topic, payload))
    decoded = payload.decode('utf-8')
    payload = json.loads(decoded)
    global received_message
    received_message = payload
