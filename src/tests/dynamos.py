import boto3

print('hi')
dynamodb = boto3.resource('dynamodb')

# Specify the table name
table_name = 'sensorTest'

# Access the DynamoDB table
table = dynamodb.Table(table_name)

# Example: Scan all items in the table
response = table.scan()

# Print all items
items = response.get('Items', [])
for item in items:
    print(item)