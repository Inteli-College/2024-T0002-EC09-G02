import json
import math
import os
import time
import paho.mqtt.client as mqtt

class Configuration:
    def __init__(self, unit, transmission_rate_hz, longitude, latitude, sensor, qos):
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.longitude = longitude
        self.latitude = latitude
        self.sensor = sensor
        self.qos = qos

class Data:
    def __init__(self, value, unit, transmission_rate_hz, longitude, latitude, sensor, timestamp, qos):
        self.value = value
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.longitude = longitude
        self.latitude = latitude
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
    client = mqtt.Client(client_id=node_name)
    try:
        client.connect("localhost", 1891)
        return client
    except Exception as e:
        print("Erro ao conectar-se ao servidor MQTT")
        client.disconnect()
        return None
    
def create_json_message(config, rounded_value):
    timestamp = time.time()
    data = Data(rounded_value, config.unit, config.transmission_rate_hz, config.longitude, config.latitude, config.sensor, timestamp, config.qos)
    return data.__dict__

def publish_data(client, config, data):
    interval = 1/config.transmission_rate_hz
    for value in data:
        rounded_value = round(value, 2)
        message = create_json_message(config, rounded_value)
        client.publish("sensor/" + config.sensor, payload=json.dumps(message), qos=config.qos)
        time.sleep(interval)

def main():
    import sys
    if len(sys.argv) != 3:
        print("Usage: python publisher.py <config_path> <csv_path>")
        return
    
    config_path = sys.argv[1]
    csv_path = sys.argv[2]

    config = read_config(config_path)
    client = connect_mqtt("publisher")
    data = read_csv(csv_path)
    publish_data(client, config, data)
    client.disconnect()

if __name__== "__main__":
    main()