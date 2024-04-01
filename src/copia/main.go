package main

import (
	"encoding/json"
	// "os/exec"
	"time"

	mqtt "github.com/eclipse/paho.mqtt.golang"
)

var Client mqtt.Client
var Date = time.Date(2024, 1, 1, 0, 0, 0, 0, time.UTC) 

var co2Sensor =  SensorStruct{mean: 400, sensorType: "CO", volatility:90, mean_reversion_rate: 0.1}

var coSensor =  SensorStruct{mean: 5, sensorType: "CO2", volatility:2, mean_reversion_rate: 0.1}

var no2Sensor =  SensorStruct{mean: 100, sensorType: "NO2", volatility:20, mean_reversion_rate: 0.1}

var pm10_sensor_params =  SensorStruct{mean: 50, sensorType: "PM10", volatility:5, mean_reversion_rate: 0.1}

var pm25_sensor_params =  SensorStruct{mean: 25, sensorType: "PM25", volatility:2.5, mean_reversion_rate: 0.1}

var solar_sensor_params =  SensorStruct{mean: 500, sensorType: "Solar", volatility:100, mean_reversion_rate: 0.1}

var noise_sensor_params =  SensorStruct{mean: 65, sensorType: "Noise", volatility:10, mean_reversion_rate: 0.1}

func main() {

	Client = Publisher()
	Generator([]SensorStruct{co2Sensor, coSensor, no2Sensor}, "2448", Callback,"AirQuality")
	Generator([]SensorStruct{pm10_sensor_params, pm25_sensor_params}, "2448", Callback,"ParticulateMatter")
	Generator([]SensorStruct{solar_sensor_params}, "2448", Callback,"Solar")
	Generator([]SensorStruct{noise_sensor_params}, "2448", Callback,"Noise")
}

// func RunMetabase() {
// 	cmd := exec.Command("docker", "run", "-d", "-p", "3000:3000", "--name" ,"metabase","metabase/metabase")
// 	err := cmd.Run()
// 	if err != nil {
// 		panic(err)
// 	}
// }

func Callback(vals []float64, sensors []SensorStruct, sensorType string) {
	
	values := make(map[string]float64)
	for i:= range sensors {
		values[sensors[i].sensorType] = vals[i]
	}
	datajson,_ :=  json.Marshal(map[string]interface{}{ "sensorType": sensorType, "values": values, "date": Date})
	Client.Publish("sensors/", 0, false, datajson)
	Date = Date.Add(time.Minute)
	time.Sleep(2 * time.Second)
}