from simulator.generic_sensor import publisher
from awscrt import mqtt, http
import time
import json
import pytest

global received_message
received_message = None

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
    endpoint = 'a32jmg845uczmw-ats.iot.us-east-1.amazonaws.com'
    port = 8883

    cert_path = './authentication-keys/test_cert.pem'
    key_path = './authentication-keys/test_key.pem'
    ca_cert = './authentication-keys/root-CA.crt'
    client_id = 'test_sub'
    mqtt_connection, _ = publisher.connect_mqtt(endpoint, port, cert_path, key_path, ca_cert, client_id)
    topic = 'test'
    message = {'test': 'this is the test message'}

    publisher.publish_message(mqtt_connection, topic, json.dumps(message))

    subscribe_future, _ = mqtt_connection.subscribe(
    topic=topic,
    qos=mqtt.QoS.AT_LEAST_ONCE,
    callback=on_message_received
    )

    subscribe_result = subscribe_future.result()

    time.sleep(1)
    assert json.loads(received_message) == message

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


def on_message_received(topic, payload, **kwargs):
    print("Received message from topic '{}': {}".format(topic, payload))
    global received_message
    received_message = payload

