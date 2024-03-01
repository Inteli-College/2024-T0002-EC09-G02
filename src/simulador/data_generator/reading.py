class Reading():
    def __init__(self, sensor_type, unit, min_value, max_value, average_value, outlier_probability):
        self.unit = unit
        self.min_value = min_value
        self.max_value = max_value
        self.average_value = average_value
        self.outlier_probability = outlier_probability
        self.sensor_type = sensor_type

# CO2 Sensor
co2_sensor_params = {
    'sensor_type': 'CO2',
    'unit': 'ppm',
    'min_value': 300,
    'max_value': 1000,
    'average_value': 400,
    'outlier_probability': 0.05
}

# CO Sensor
co_sensor_params = {
    'sensor_type': 'CO',
    'unit': 'ppm',
    'min_value': 0,
    'max_value': 10,
    'average_value': 1,
    'outlier_probability': 0.05
}

# NO2 Sensor
no2_sensor_params = {
    'sensor_type': 'NO2',
    'unit': 'ppb',
    'min_value': 0,
    'max_value': 200,
    'average_value': 20,
    'outlier_probability': 0.05
}

# Particulate Matter (PM10) Sensor
pm10_sensor_params = {
    'sensor_type': 'PM10',
    'unit': 'ug/m³',
    'min_value': 0,
    'max_value': 100,
    'average_value': 20,
    'outlier_probability': 0.05
}

# Particulate Matter (PM2.5) Sensor
pm25_sensor_params = {
    'sensor_type': 'PM2.5',
    'unit': 'ug/m³',
    'min_value': 0,
    'max_value': 50,
    'average_value': 10,
    'outlier_probability': 0.05
}

# Solar Intensity Sensor
solar_intensity_params = {
    'sensor_type': 'solar',
    'unit': 'W/m²',
    'min_value': 0,
    'max_value': 1000,
    'average_value': 500,
    'outlier_probability': 0.05
}

# Noise Sensor
noise_sensor_params = {
    'sensor_type': 'noise',
    'unit': 'dB',
    'min_value': 30,
    'max_value': 100,
    'average_value': 50,
    'outlier_probability': 0.05
}

co_sensor = Reading(**co_sensor_params)
co2_sensor = Reading(**co2_sensor_params)
no2_sensor = Reading(**no2_sensor_params)
pm10_sensor = Reading(**pm10_sensor_params)
pm25_sensor = Reading(**pm25_sensor_params)
solar_intensity_sensor = Reading(**solar_intensity_params)
noise_sensor = Reading(**noise_sensor_params)

sensors = [co_sensor, co2_sensor, no2_sensor, pm10_sensor, pm25_sensor, solar_intensity_sensor, noise_sensor]