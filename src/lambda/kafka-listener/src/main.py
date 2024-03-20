import os
from pymongo import MongoClient
from dotenv import load_dotenv

load_dotenv()

mongodb = os.environ.get("MONGODB_URI")

if mongodb is None:
    raise ValueError("A URI do Mongo não foi setada corretamente na env!")

client = MongoClient(host=mongodb)

def lambda_handler(event, context):
    return client.db.command("ping")