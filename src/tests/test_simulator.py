from simulator.generic_sensor import publisher
from awscrt import mqtt, http
import time
import json
import pytest
import boto3


global received_message
received_message = {'message': 'no message received'}

def test_connect():
    endpoint = 'a32jmg845uczmw-ats.iot.us-east-1.amazonaws.com'
    port = 8883
    cert_path = './authentication-keys/test_cert.pem'
    key_path = './authentication-keys/test_key.pem'
    ca_cert = './authentication-keys/root-CA.crt'
    client_id = 'test_pub'
    connection, result = publisher.connect_mqtt(endpoint, port, cert_path, key_path, ca_cert, client_id)
    
    assert result['session_present']

def test_publish():
    global received_message
    received_message = {'message': 'no message received'}
    endpoint = 'a32jmg845uczmw-ats.iot.us-east-1.amazonaws.com'
    port = 8883

    cert_path = './authentication-keys/test_cert.pem'
    key_path = './authentication-keys/test_key.pem'
    ca_cert = './authentication-keys/root-CA.crt'
    client_id = 'test_sub'
    mqtt_connection, _ = publisher.connect_mqtt(endpoint, port, cert_path, key_path, ca_cert, client_id)
    topic = 'test/test'
    message = {'test': 'this is the test message'}

    publisher.publish_message(mqtt_connection, topic, json.dumps(message))

    subscribe_future, _ = mqtt_connection.subscribe(
    topic=topic,
    qos=mqtt.QoS.AT_LEAST_ONCE,
    callback=on_message_received
    )

    subscribe_result = subscribe_future.result()

    time.sleep(1)
    assert received_message == message

def test_authenticate():
    endpoint = 'a32jmg845uczmw-ats.iot.us-east-1.amazonaws.com'
    port = 8883
    cert_path = './authentication-keys/test_cert.pem'
    key_path = './authentication-keys/test_key.pem'
    ca_cert = './authentication-keys/root-CA.crt'
    empty_cert_path = './authentication-keys/empty_cert.pem'
    empty_key_path = './authentication-keys/empty_key.pem'
    empty_ca_cert = './authentication-keys/empty_root-CA.crt'

    client_id = 'test_pub'
    _, result = publisher.connect_mqtt(endpoint, port, cert_path, key_path, ca_cert, client_id)
    assert result['session_present']

    with pytest.raises(Exception):
        _, result = publisher.connect_mqtt(endpoint, port, empty_cert_path, key_path, ca_cert, client_id)
        assert not result['session_present']

    with pytest.raises(Exception):
        _, result = publisher.connect_mqtt(endpoint, port, cert_path, empty_key_path, ca_cert, client_id)
        assert not result['session_present']

    with pytest.raises(Exception):
        _, result = publisher.connect_mqtt(endpoint, port, cert_path, key_path, empty_ca_cert, client_id)
        assert not result['session_present']


def test_publishing_topic_authorization():
    global received_message
    received_message = {'message': 'no message received'}
    endpoint = 'a32jmg845uczmw-ats.iot.us-east-1.amazonaws.com'
    port = 8883

    cert_path = './authentication-keys/test_cert.pem'
    key_path = './authentication-keys/test_key.pem'
    ca_cert = './authentication-keys/root-CA.crt'
    client_id = 'test_pubsub'
    mqtt_connection, _ = publisher.connect_mqtt(endpoint, port, cert_path, key_path, ca_cert, client_id)
    wrong_topic = 'wrong_topic'
    correct_topic = 'test/publishing_topic_authorization'
    message = {'test': 'this is the test message'}

    subscribe_future, _ = mqtt_connection.subscribe(
    topic=correct_topic,
    qos=mqtt.QoS.AT_LEAST_ONCE,
    callback=on_message_received
    )

    subscribe_result = subscribe_future.result()

    publisher.publish_message(mqtt_connection, wrong_topic, json.dumps(message))

    time.sleep(1)
   
    assert not received_message == message
        

def test_subscribing_topic_authorization():
    global received_message
    received_message = {'message': 'no message received'}
    endpoint = 'a32jmg845uczmw-ats.iot.us-east-1.amazonaws.com'
    port = 8883

    cert_path = './authentication-keys/test_cert.pem'
    key_path = './authentication-keys/test_key.pem'
    ca_cert = './authentication-keys/root-CA.crt'
    client_id = 'test_sub'
    mqtt_connection, _ = publisher.connect_mqtt(endpoint, port, cert_path, key_path, ca_cert, client_id)
    correct_topic = 'test/test'
    wrong_topic = 'wrong_topic'
    message = {'test': 'this is the test message'}

    subscribe_future, _ = mqtt_connection.subscribe(
    topic=correct_topic,
    qos=mqtt.QoS.AT_LEAST_ONCE,
    callback=on_message_received
    )

    subscribe_result = subscribe_future.result()
    assert subscribe_result['topic'] == correct_topic

    subscribe_future, _ = mqtt_connection.subscribe(
    topic=wrong_topic,
    qos=mqtt.QoS.AT_LEAST_ONCE,
    callback=on_message_received
    )
    time.sleep(1)
    assert not subscribe_future.done()
    

def on_message_received(topic, payload, **kwargs):
    print("Received message from topic '{}': {}".format(topic, payload))
    decoded = payload.decode('utf-8')
    payload = json.loads(decoded)
    global received_message
    received_message = payload

