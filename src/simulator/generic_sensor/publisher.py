"""
Overview:
This script connects to AWS IoT Core, reads sensor configuration from a JSON file,
reads sensor data from a CSV file, and publishes the data to an MQTT topic.

Dependencies:
- Python packages: awscrt, awsiot, sys, threading, time, json, uuid, argparse

Usage:
Run the script with command-line arguments '--sensor' and '--region'.

"""

from awscrt import mqtt
from awsiot import mqtt_connection_builder
import sys
import time
import json
import uuid
import argparse
from dataclasses import dataclass
import numpy as np

class Configuration:
    def __init__(self, unit, transmission_rate_hz, region, sensor_type, qos):
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.region = region
        self.sensor_type = sensor_type
        self.qos = qos

@dataclass
class Data:
    def __init__(self, value, unit, transmission_rate_hz, region, sensor_type, timestamp,qos):
        self.value = value
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.region = region
        self.sensor_type = sensor_type
        self.timestamp = timestamp
        self.qos = qos
        self.sensor_id = uuid.uuid4().bytes.hex()

def read_config(filename):
    with open(filename, 'r') as file:
        config_json = json.load(file)
        config = Configuration(**config_json)
    return config

def read_csv(path):
    with open(path, 'r') as csv:
        data = [float(line.strip()) for line in csv]
    return data

def create_json_message(config, rounded_value):
    timestamp = generate_timestamp()
    data = Data(rounded_value, config.unit, config.transmission_rate_hz,
                config.region, config.sensor_type, timestamp, config.qos)
    return json.dumps(data.__dict__)

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--sensor', required=True, help='Sensor type')
    parser.add_argument('--region', required=True, help='Region')
    args = parser.parse_args()
    return args

def connect_mqtt(endpoint, port, cert_path, key_path, ca_cert, client_id):
    mqtt_connection = mqtt_connection_builder.mtls_from_path(
        endpoint=endpoint,
        port=port,
        cert_filepath=cert_path,
        pri_key_filepath=key_path,
        ca_filepath=ca_cert,
        on_connection_interrupted=on_connection_interrupted,
        on_connection_resumed=on_connection_resumed,
        client_id=client_id,
        clean_session=False,
        keep_alive_secs=30,
        on_connection_success=on_connection_success,
        on_connection_failure=on_connection_failure,
        on_connection_closed=on_connection_closed)
    
    print(f"Connecting to {endpoint} with client ID '{client_id}'...")
    connect_future = mqtt_connection.connect()
    connect_future.result()
    return mqtt_connection, connect_future.result()

def on_connection_interrupted(connection, error, **kwargs):
    print("Connection interrupted. error: {}".format(error))

def on_connection_resumed(connection, return_code, session_present, **kwargs):
    print("Connection resumed. return_code: {} session_present: {}".format(return_code, session_present))
    if return_code == mqtt.ConnectReturnCode.ACCEPTED and not session_present:
        print("Session did not persist. Resubscribing to existing topics...")
        resubscribe_future, _ = connection.resubscribe_existing_topics()
        resubscribe_future.add_done_callback(on_resubscribe_complete)

def on_resubscribe_complete(resubscribe_future):
    resubscribe_results = resubscribe_future.result()
    print("Resubscribe results: {}".format(resubscribe_results))
    for topic, qos in resubscribe_results['topics']:
        if qos is None:
            sys.exit("Server rejected resubscribe to topic: {}".format(topic))

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

def publish_message(mqtt_connection, topic, message):
    mqtt_connection.publish(
        topic=topic,
        payload=message,
        qos=mqtt.QoS.AT_LEAST_ONCE)
    
def generate_timestamp(InitialYear=2021, InitialMonth=1, FinalYear=2024, FinalMonth=12):
    year = np.random.randint(InitialYear, FinalYear)
    month = np.random.randint(InitialMonth, FinalMonth)
    day = np.random.randint(1, 28)
    hour = np.random.randint(0, 23)
    minute = np.random.randint(0, 59)
    second = np.random.randint(0, 59)
    return f"{year}-{month}-{day} {hour}:{minute}:{second}"

if __name__ == '__main__':
    args = get_args()

    sensor_type = args.sensor
    region = args.region
    port = 8883
    client_id = f'{region}_{sensor_type}'
    cert_path = f'./../../authentication-keys/{region}_cert.pem'
    key_path = f'./../../authentication-keys/{region}_key.pem'
    ca_cert = './../../authentication-keys/root-CA.crt'
    endpoint = 'a43y9mlv8sc26-ats.iot.us-east-1.amazonaws.com'

    mqtt_connection, _ = connect_mqtt(endpoint, port, cert_path, key_path, ca_cert, client_id)

    config_path = f'./../data/{region}/{sensor_type}.json'
    config = read_config(config_path)
    csv_path = f'./../data/{region}/{sensor_type}.csv'
    data = read_csv(csv_path)
    print(f'Topic: sensor/{config.region}/{config.sensor_type}')

    for value in data:
        rounded_value = round(value, 2)
        
        message = create_json_message(config, rounded_value)
        topic = f'sensor/{config.region}/{config.sensor_type}'
        publish_message(mqtt_connection, topic, message)
        print(f"Published message: {message}")
        time.sleep(2)

    # Disconnect
    print("Disconnecting...")
    disconnect_future = mqtt_connection.disconnect()
    disconnect_future.result()
    print("Disconnected!")