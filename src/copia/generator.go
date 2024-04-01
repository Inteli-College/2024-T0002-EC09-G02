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

type CallbackFunction func([]float64,[]SensorStruct,string, string)
var Date = time.Date(2024, 1, 1, 0, 0, 0, 0, time.UTC) 
type SensorStruct struct {
	mean float64
	sensorType string
	volatility float64
	mean_reversion_rate float64
} 

func Generator(sensors []SensorStruct,amount string, client mqtt.Client, sensorType string,region string)  {
	size := len(sensors)
	valueList := make([][]float64, size)
	fmt.Printf("sensors %v\n",sensors)
	for j, sensor := range sensors {
		cmd := exec.Command("python3", "DataGenerator.py", sensor.sensorType, amount, fmt.Sprintf("%f",sensor.mean), fmt.Sprintf("%f",sensor.volatility) ,fmt.Sprintf("%f",sensor.mean_reversion_rate))
		err := cmd.Run()
		if err != nil {
			panic(err)
		}
	    // Open CSV file
		f, err := os.Open("./data/"+sensor.sensorType + ".csv")
		if err != nil {
			panic(err)
		}
		defer f.Close()
		// Read File into a Variable
		lines, err := csv.NewReader(f).ReadAll()
		if err != nil {
			panic(err)
		}
		
		sensorValueList := make([]float64, len(lines))
		for i, line:= range lines {
			value,_ := strconv.ParseFloat(line[0],64)
			
			sensorValueList[i] = value
		}
		valueList[j] = sensorValueList
		
	}
	fmt.Printf("valueList %v\n",valueList)
	for i := 0; i < int(size); i++ {
			if valueList[i] == nil {
				continue
			}
			values := make(map[string]float64)
			for j:= range sensors {
				values[sensors[i].sensorType] = valueList[i][j]
			}
			datajson,_ :=  json.Marshal(map[string]interface{}{ "sensorType": sensorType, "values": values, "date": Date})
			fmt.Printf("datajson %v\n",datajson)
			token := Client.Publish(region+"/"+sensorType, 0, false, datajson)
			token.Wait()
			
			Date = Date.Add(time.Minute)
			time.Sleep(2 * time.Second)
		}
}