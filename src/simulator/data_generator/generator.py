"""
Overview:
This script generates mock sensor values for different regions based on predefined sensor parameters.
It uses the 'generate_mock_sensor_value' function to create synthetic sensor readings, considering
min, max, average values, and outlier probability. The generated data is then saved in CSV files for
each sensor type and region. Additionally, JSON configuration files are created to store sensor details.

Dependencies:
- Python packages: csv, random, sys, numpy, json
- External module: reading (importing 'sensors' from 'reading' module)

Functions:
- generate_mock_sensor_value: Generates synthetic sensor values based on given parameters.

"""

import csv
import random
from reading import sensors
import numpy as np
import json

def generate_mock_sensor_value(min_value, max_value, average_value, outlier_probability):
    # Calculate interquartile range
    iqr = (max_value - min_value) / 2
    
    # Check if outlier should be generated
    if np.random.rand() < outlier_probability:
        # Generate outlier value outside the interquartile range
        outlier_value = np.random.normal(loc=average_value, scale=iqr * 1.5)
        
        # Ensure the outlier value does not exceed the bounds
        outlier_value = min(max_value, max(min_value, outlier_value))
        
        return outlier_value
    else:
        # Generate normal sensor value within the interquartile range
        normal_value = np.random.normal(loc=average_value, scale=iqr)
        
        # Ensure the normal value does not exceed the bounds
        normal_value = min(max_value, max(min_value, normal_value))
        
        return normal_value

# Generate mock sensor data for each sensor and region
for sensor in sensors:
    for region in ['east', 'west', 'north', 'south', 'center']:
        with open(f'../data/{region}/{sensor.sensor_type}.csv', "w", newline="") as csvfile:
            writer = csv.writer(csvfile)

            # Generate and write 100 mock sensor readings
            for _ in range(100):
                value = generate_mock_sensor_value(sensor.min_value, sensor.max_value, sensor.average_value, sensor.outlier_probability)
                writer.writerow([value])

        # Create JSON configuration files with sensor details
        config = {
            "sensor_type": sensor.sensor_type,
            "region": region,
            "transmission_rate_hz": 1,
            "unit": sensor.unit,
            "qos": 1
        }
        with open(f'../data/{region}/{sensor.sensor_type}.json', "w") as jsonfile:
            json.dump(config, jsonfile)
