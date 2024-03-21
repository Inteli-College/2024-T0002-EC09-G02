import os
from pymongo import MongoClient
from dotenv import load_dotenv
from kafka import KafkaConsumer

load_dotenv()

mongodb = os.environ.get("MONGODB_URI")
topic_name = 'vtnc_gustavo'
consumer = KafkaConsumer(topic_name, auto_offset_reset='earliest', bootstrap_servers=['kafka2:9092'], api_version=(0, 10), consumer_timeout_ms=1000)

if mongodb is None:
    raise ValueError("A URI do Mongo não foi setada corretamente na env!")

client = MongoClient(host=mongodb)

def listen():
    for msg in consumer:
        print(msg.value)

def lambda_handler(event, context):
    return client.db.command("ping")

def main():
    listen()

if __name__ == '__main__':
    main()