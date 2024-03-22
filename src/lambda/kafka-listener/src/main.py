from confluent_kafka import Producer
import json
from dotenv import load_dotenv
import os

# Carrega variáveis de ambiente do arquivo .env
load_dotenv()

def lambda_handler(event, context):
    kafka_conf = {
        'bootstrap.servers': os.getenv('BOOTSTRAP_SERVERS'),
        'security.protocol': 'SASL_SSL',
        'sasl.mechanisms': 'PLAIN',
        'sasl.username': os.getenv('SASL_USERNAME'),
        'sasl.password': os.getenv('SASL_PASSWORD')
    }

    print(kafka_conf)
    producer = Producer(kafka_conf)
    topic = os.getenv('KAFKA_TOPIC')

    print(f'Topic: {event}')

    def delivery_report(err, msg):
        if err is not None:
            print(f'Message delivery failed: {err}')
        else:
            print(f'Message delivered to {msg.topic()} [{msg.partition()}]')

    # Loop through the IoT messages
    for record in event['Records']:
        message = json.loads(record['body'])
        producer.produce(topic, message.encode('utf-8'), callback=delivery_report)
    
    producer.flush()

    return {
        'statusCode': 200,
        'body': json.dumps('Mensagens enviadas para o Kafka com sucesso!')
    }
