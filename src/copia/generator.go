package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"os/exec"
	"strconv"
)

type CallbackFunction func([]float64,[]SensorStruct,string)

type SensorStruct struct {
	mean float64
	sensorType string
	volatility float64
	mean_reversion_rate float64
} 

func Generator(sensors []SensorStruct,amount string, callback CallbackFunction, sensorType string)  {
	size := len(sensors)
	lineslist := make([][][]string, size)
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
		lineslist = append(lineslist, lines)
	}
	amountValues,_ := strconv.ParseInt(amount, 10,64)
	
	for i := 0; i < int(amountValues); i++ {
		for j := 0; j < size; j++ {
			floatList := make([]float64, size)
			for k := 0; k < size; k++ {
				temp,_ :=  strconv.ParseFloat(lineslist[i][j][k], 64) 
				floatList = append(floatList, temp)
			}
			callback(floatList,sensors,sensorType)
		}
	}
}