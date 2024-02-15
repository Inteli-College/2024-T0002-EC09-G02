import bufio
import json
import fmt 
import math
import os
import time
import paho.mqtt.client as mqtt

class Configuration:
    def __init__(self, unit, transmission_rate_hz, longitude, latitude, sensor, qos):
        self.unit = unit
        self.transmission_rate_hz = transmission_rate_hz
        self.longitude = longitude
        self.latitude = latitude
        self.sensor = sensor
        self.qos = qos