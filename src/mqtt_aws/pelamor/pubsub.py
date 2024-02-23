# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0.

from awscrt import mqtt, http
from awsiot import mqtt_connection_builder
import sys
import threading
import time
import json

endpoint = "a3ru784j6s0pfl-ats.iot.us-east-1.amazonaws.com"
port = 8883
certificate = "certificate.cert.pem"
private_key = "chave.private.key"
ca_cert = "root-CA.crt"
clientId = "elisa"

class Configuration:
    def __init__(self, unit, transmission_rate_hz,
                 region, sensor, qos):
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.region = region
        self.sensor = sensor
        self.qos = qos


class Data:
    def __init__(self, value, unit, transmission_rate_hz, region,
                 sensor, timestamp, qos):
        self.value = value
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.region = region
        self.sensor = sensor
        self.timestamp = timestamp
        self.qos = qos


def read_config(filename):
    with open(filename, 'r') as file:
        config_json = json.load(file)
        config = Configuration(**config_json)
    return config


def read_csv(path):
    with open(path, 'r') as csv:
        data = [float(line.strip()) for line in csv]
    return data


def connect_mqtt(node_name):
    client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2, node_name)
    try:
        client.connect("localhost", 1891, 60)
        return client
    except Exception:
        print("Erro ao conectar-se ao servidor MQTT")
        client.disconnect()
        return None


def create_json_message(config, rounded_value):
    timestamp = time.time()
    data = Data(rounded_value, config.unit, config.transmission_rate_hz,
                config.region, config.sensor,
                timestamp, config.qos)
    return data.__dict__

def on_connection_interrupted(connection, error, **kwargs):
    print("Connection interrupted. error: {}".format(error))

def on_connection_resumed(connection, return_code, session_present, **kwargs):
    print("Connection resumed. return_code: {} session_present: {}".format(return_code, session_present))

    if return_code == mqtt.ConnectReturnCode.ACCEPTED and not session_present:
        print("Session did not persist. Resubscribing to existing topics...")
        resubscribe_future, _ = connection.resubscribe_existing_topics()
        resubscribe_future.add_done_callback(on_resubscribe_complete)


def on_message_received(topic, payload, dup, qos, retain, **kwargs):
    print("Received message from topic '{}': {}".format(topic, payload))


def on_connection_success(connection, callback_data):
    assert isinstance(callback_data, mqtt.OnConnectionSuccessData)
    print("Connection Successful with return code: {} session present: {}".format(callback_data.return_code, callback_data.session_present))

def on_connection_failure(connection, callback_data):
    assert isinstance(callback_data, mqtt.OnConnectionFailureData)
    print("Connection failed with error code: {}".format(callback_data.error))

def on_connection_closed(connection, callback_data):
    print("Connection closed")

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 3:
        print("Usage: python publisher.py <config_path> <csv_path>")
        exit(1)

    config_path = sys.argv[1]
    csv_path = sys.argv[2]

    config = read_config(config_path)

    mqtt_connection = mqtt_connection_builder.mtls_from_path(
        endpoint=endpoint,
        port=port,
        cert_filepath=certificate,
        pri_key_filepath=private_key,
        ca_filepath=ca_cert,
        on_connection_interrupted=on_connection_interrupted,
        on_connection_resumed=on_connection_resumed,
        client_id=clientId,
        clean_session=False,
        keep_alive_secs=30,
        on_connection_success=on_connection_success,
        on_connection_failure=on_connection_failure,
        on_connection_closed=on_connection_closed)

    print(f"Connecting to {endpoint} with client ID '{clientId}'...")
    print(f'Topic: sensor/{config.region}/{config.sensor}')

    connect_future = mqtt_connection.connect()

    connect_future.result()
    print("Connected!")

    data = read_csv(csv_path)


    interval = 1/config.transmission_rate_hz
    for value in data:
        rounded_value = round(value, 2)
        message = create_json_message(config, rounded_value)
        message = json.dumps(message)
        mqtt_connection.publish(
        topic='sensor/{}/{}'.format(config.region, config.sensor),
        payload=message,
        qos=mqtt.QoS.AT_LEAST_ONCE)
        time.sleep(interval)

    # Disconnect
    print("Disconnecting...")
    disconnect_future = mqtt_connection.disconnect()
    disconnect_future.result()
    print("Disconnected!")
