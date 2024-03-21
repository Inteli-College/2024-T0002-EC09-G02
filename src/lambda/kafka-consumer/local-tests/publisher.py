from time import sleep

from kafka import KafkaProducer

# publish messages on topic
def publish_message(producer_instance, topic_name, key, value):
    try:
        key_bytes = bytes(key, encoding='utf-8')
        value_bytes = bytes(value, encoding='utf-8')
        producer_instance.send()
        producer_instance.flush()
        print('Message ' + key + ' published successfully.')
    except Exception as ex:
        print('Exception in publishing message')
        print(str(ex))

# establish kafka connection
def connect_kafka_producer():
    _producer = None
    try:
        _producer = KafkaProducer(bootstrap_servers=['kafka1:9092'])
    except Exception as ex:
        print('Exception while connecting Kafka')
        print(str(ex))
    finally:
        return _producer

if __name__ == '__main__':
    kafka_producer = connect_kafka_producer()
    x = 0
    while True:
        publish_message(kafka_producer, 'vtnc_gustavo', str(x), 'This is message ' + str(x))
        x += 1