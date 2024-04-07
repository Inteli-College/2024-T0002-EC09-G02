from confluent_kafka import Producer, Consumer
import json
from dotenv import load_dotenv
import os

load_dotenv()

def lambda_handler(event, context):
    print(f'Lendo variáveis de ambiente...')
    kafka_conf = {
        'bootstrap.servers': os.getenv('BOOTSTRAP_SERVERS'),
        'security.protocol': 'SASL_SSL',
        'sasl.mechanisms': 'PLAIN',
        'sasl.username': os.getenv('SASL_USERNAME'),
        'sasl.password': os.getenv('SASL_PASSWORD')
    }

    producer = Producer(kafka_conf)
    topic = os.getenv('KAFKA_TOPIC')
    print(f'Conectado ao tópico {topic}...')

    print(f'Received event!')

    def delivery_report(err, msg):
        if err is not None:
            print(f'Message delivery failed: {err}')
        else:
            print(f'Message delivered to {msg.topic()} [{msg.partition()}]')

    # Loop through the IoT messages
    for record in event['Records']:
        print(f'Received message: {record["body"]}')
        message = json.dumps(record['body']).encode('utf-8')
        print(f'Parsed message: {message}')
        producer.produce(topic, message, callback=delivery_report)
    
    producer.flush()

    return {
        'statusCode': 200,
        'body': json.dumps('Mensagens enviadas para o Kafka com sucesso!')
    }