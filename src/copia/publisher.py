import ssl
import paho.mqtt.client as paho
from paho import mqtt

broker = 'prodam-5plru7.a02.usw2.aws.hivemq.cloud'  # Example: 'broker.hivemq.com'
port = 8883  # Default port for MQTT over TLS
topic = "hi"
client_id = 'python-mqtt-client'

def on_connect(client, userdata, flags, rc):
    print('hi')
    if rc == 0:
        print("Connected to MQTT Broker!")
    else:
        print("Failed to connect, return code %d\n", rc)

def connect_mqtt():
    client = paho.Client(paho.CallbackAPIVersion.VERSION2, "Publisher",
                     protocol=paho.MQTTv5)
    client.on_connect = on_connect
    client.tls_set(
                   certfile="certificate/mqtt-client-cert.pem",
                   keyfile="certificate/mqtt-client-key.pem",
                   )  # Ensure the TLS version is compatible
    print('hi')
    client.connect(broker, port)
    return client

def main():
    client = connect_mqtt()
    client.loop_start()
    client.publish(topic, payload="Hello", qos=1)

    # Perform your MQTT operations here, e.g., subscribe or publish
    
if __name__ == "__main__":
    main()
