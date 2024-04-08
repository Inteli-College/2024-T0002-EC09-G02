package main

import (
	"os"

	// "os/exec"

	mqtt "github.com/eclipse/paho.mqtt.golang"
)

var Client mqtt.Client

var co2Sensor = SensorStruct{mean: 400, sensorType: "CO", volatility: 90, mean_reversion_rate: 0.1}

var coSensor = SensorStruct{mean: 5, sensorType: "CO2", volatility: 2, mean_reversion_rate: 0.1}

var no2Sensor = SensorStruct{mean: 100, sensorType: "NO2", volatility: 20, mean_reversion_rate: 0.1}

var pm10_sensor_params = SensorStruct{mean: 50, sensorType: "PM10", volatility: 5, mean_reversion_rate: 0.1}

var pm25_sensor_params = SensorStruct{mean: 25, sensorType: "PM25", volatility: 2.5, mean_reversion_rate: 0.1}

var solar_sensor_params = SensorStruct{mean: 5, sensorType: "Solar", volatility: 2, mean_reversion_rate: 0.1}

var noise_sensor_params = SensorStruct{mean: 65, sensorType: "Noise", volatility: 10, mean_reversion_rate: 0.1}

func main() {
	region := os.Args[1]
	Client = Publisher()
	Generator([]SensorStruct{co2Sensor, coSensor, no2Sensor}, "29088", Client, "AirQuality", region)
	Generator([]SensorStruct{pm10_sensor_params, pm25_sensor_params}, "29088", Client, "ParticulateMatter", region)
	Generator([]SensorStruct{solar_sensor_params}, "29088", Client, "Solar", region)
	Generator([]SensorStruct{noise_sensor_params}, "29088", Client, "Noise", region)
}

// func RunMetabase() {
// 	cmd := exec.Command("docker", "run", "-d", "-p", "3000:3000", "--name" ,"metabase","metabase/metabase")
// 	err := cmd.Run()
// 	if err != nil {
// 		panic(err)
// 	}
// }
