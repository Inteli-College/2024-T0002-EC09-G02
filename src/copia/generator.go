package main

import (
	"encoding/csv"
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"time"

	mqtt "github.com/eclipse/paho.mqtt.golang"
)

type CallbackFunction func([]float64, []SensorStruct, string, string)

type SensorStruct struct {
	mean                float64
	sensorType          string
	volatility          float64
	mean_reversion_rate float64
}

func Generator(sensors []SensorStruct, amount string, client mqtt.Client, sensorType string, region string) {
	var Date = time.Date(2024, 1, 1, 0, 0, 0, 0, time.UTC)

	pointerlist := make(map[int]*csv.Reader)
	fmt.Printf("sensors %v\n", sensors)
	for i, sensor := range sensors {
		cmd := exec.Command("python3", "DataGenerator.py", sensor.sensorType, amount, fmt.Sprintf("%f", sensor.mean), fmt.Sprintf("%f", sensor.volatility), fmt.Sprintf("%f", sensor.mean_reversion_rate))
		err := cmd.Run()
		if err != nil {
			panic(err)
		}
		// Open CSV file
		f, err := os.Open("./data/" + sensor.sensorType + ".csv")
		if err != nil {
			panic(err)
		}

		pointer := csv.NewReader(f)
		if pointer == nil {
			panic("Error opening file")
		}
		pointerlist[i] = pointer
	}
	numberValues, _ := strconv.ParseInt(amount, 10, 64)
	for j := 0; j < int(numberValues); j++ {
		values := make(map[string]float64)
		for i := 0; i < len(sensors); i++ {

			line, _ := pointerlist[i].Read()

			value, _ := strconv.ParseFloat(line[0], 64)
			values[sensors[i].sensorType] = value
		}

		datajson, _ := json.Marshal(map[string]interface{}{"sensorType": sensorType, "values": values, "date": Date, "region": region})
		client.Publish("north"+"/"+sensorType, 0, false, datajson)
		time.Sleep(time.Second / 100)
		Date = Date.Add(5 * time.Minute)
	}
}
