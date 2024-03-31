package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"os/exec"
	"strconv"
)

type CallbackFunction func(float64)

type SensorStruct struct {
	mean float64
	sensorType string
	volatility float64
	mean_reversion_rate float64
} 

func Generator(sensors []SensorStruct,amount string, callback CallbackFunction)  {

	for _, sensor := range sensors {
		cmd := exec.Command("python3", "DataGenerator.py", sensor.sensorType, amount, fmt.Sprintf("%f",sensor.mean), fmt.Sprintf("%f",sensor.volatility) ,fmt.Sprintf("%f",sensor.mean_reversion_rate))
		err := cmd.Run()
		if err != nil {
			panic(err)
		}
	    // Open CSV file
		f, err := os.Open(sensor.sensorType + ".csv")
		if err != nil {
			panic(err)
		}
		defer f.Close()
		// Read File into a Variable
		lines, err := csv.NewReader(f).ReadAll()
		if err != nil {
			panic(err)
		}
		// Loop through lines & turn into object
		for _, line := range lines {
			//fmt.Println(line)
			val, err := strconv.ParseFloat(line[0], 64)
			throw(err)
			callback(val)
		}
	}
}