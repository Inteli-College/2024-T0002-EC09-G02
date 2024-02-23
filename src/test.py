import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2, "iotconsole-4d58affb-44e6-4f28-9b5d-80a556f4a391")
client.on_connect = on_connect

client.connect("a3c4aqymr70mf1-ats.iot.us-east-1.amazonaws.com", 1883, 60)
client.loop_start()
