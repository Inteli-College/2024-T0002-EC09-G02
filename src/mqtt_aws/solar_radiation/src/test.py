import json

# Specify the path to your JSON file
file_path = '/home/elisa/Documents/2024-T0002-EC09-G02/src/mqtt_aws/solar_radiation/src/config.json'

# Open the JSON file in read mode
with open(file_path, 'r') as file:
    # Load the JSON data into a Python dictionary
    data = json.load(file)

# Now you can work with the 'data' dictionary
# For example, print the contents of the JSON file
print(data)