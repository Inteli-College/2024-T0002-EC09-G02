import paho.mqtt.client as mqtt

# Caminhos para o certificado e a chave privada
cert_path = "north.pem.crt"
key_path = "private-north.pem.key"

def on_message(client, userdata, message):
    print(f"Recebido: {message.payload.decode()} no tópico {message.topic}")

def on_connect(client, userdata, flags, reason_code, properties):
    print("test/topic")
    if reason_code == 0:
        print("Conexão bem sucedida!")
    else:
        print(f"Conexão falhou! Código {reason_code}")
        exit(reason_code)

client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2, "iotconsole-3075b2fb-1e46-45f3-bba1-45cc055597a7")
client.tls_set(ca_certs="public.pem", certfile=cert_path, keyfile=key_path)


client.on_connect = on_connect
client.on_message = on_message


# Configuração do cliente MQTT

# Conectar ao endpoint do AWS IoT Core
client.connect("a3ru784j6s0pfl-ats.iot.us-east-1.amazonaws.com", 8883)

# Subscrição ou publicação em tópicos, etc.
client.subscribe("seu/topico")
client.publish("seu/topico", "sua mensagem")
print("published")


client.loop_forever()