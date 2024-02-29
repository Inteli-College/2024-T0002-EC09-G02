# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0.

from awscrt import mqtt, http
from awsiot import mqtt_connection_builder
import sys
import threading
import time
import json
import uuid
import argparse



class Configuration:
    def __init__(self, unit, transmission_rate_hz,
                 region, sensor_type, qos):
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.region = region
        self.sensor_type = sensor_type
        self.qos = qos


class Data:
    def __init__(self, value, unit, transmission_rate_hz, region,
                 sensor_type, timestamp, qos):
        self.value = value
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.region = region
        self.sensor_type = sensor_type
        self.timestamp = str(time.time())
        self.qos = qos
        self.sensor_id: uuid.uuid4()


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

        # Cannot synchronously wait for resubscribe result because we're on the connection's event-loop thread,
        # evaluate result with a callback instead.
        resubscribe_future.add_done_callback(on_resubscribe_complete)


def on_resubscribe_complete(resubscribe_future):
    resubscribe_results = resubscribe_future.result()
    print("Resubscribe results: {}".format(resubscribe_results))

    for topic, qos in resubscribe_results['topics']:
        if qos is None:
            sys.exit("Server rejected resubscribe to topic: {}".format(topic))


# Callback when the subscribed topic receives a message
def on_message_received(topic, payload, dup, qos, retain, **kwargs):
    print("Received message from topic '{}': {}".format(topic, payload))

# Callback when the connection successfully connects
def on_connection_success(connection, callback_data):
    assert isinstance(callback_data, mqtt.OnConnectionSuccessData)
    print("Connection Successful with return code: {} session present: {}".format(callback_data.return_code, callback_data.session_present))

# Callback when a connection attempt fails
def on_connection_failure(connection, callback_data):
    assert isinstance(callback_data, mqtt.OnConnectionFailureData)
    print("Connection failed with error code: {}".format(callback_data.error))

# Callback when a connection has been disconnected or shutdown successfully
def on_connection_closed(connection, callback_data):
    print("Connection closed")

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    

    parser.add_argument('--clientid', required=True, help='Client ID')
    parser.add_argument('--endpoint', required=True, help='Endpoint URL')
    parser.add_argument('--cert', help='Path to the certificate file')
    parser.add_argument('--key', help='Path to the key file')
    parser.add_argument('--ca', help='Path to the CA file')
    parser.add_argument('--config', required=True, help='Path to the configuration file')
    parser.add_argument('--csv', required=True, help='Path to the CSV file')

    args = parser.parse_args()
    port = 8883
    clientid = args.clientid
    endpoint = args.endpoint
    cert_path = args.cert
    key_path = args.key
    ca_cert = args.ca
    config_path = args.config
    csv_path = args.csv
    

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
                topic=f'sensor/{config.region}/{config.sensor}',
                payload=message,
                qos=mqtt.QoS.AT_LEAST_ONCE)

        time.sleep(interval)

    # Disconnect
    print("Disconnecting...")
    disconnect_future = mqtt_connection.disconnect()
    disconnect_future.result()
    print("Disconnected!")
