package main

import (
	"encoding/json"
	"os"
	"reflect"
	"testing"

	godotenv "github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/bson"
)
var co2Sensor = SensorStruct{mean: 400, sensorType: "CO", volatility: 90, mean_reversion_rate: 0.1}

var coSensor = SensorStruct{mean: 5, sensorType: "CO2", volatility: 2, mean_reversion_rate: 0.1}

var no2Sensor = SensorStruct{mean: 100, sensorType: "NO2", volatility: 20, mean_reversion_rate: 0.1}


func TestPipeline(t *testing.T) {
	err := godotenv.Load(".env")
	if err != nil {
		t.Errorf("Error loading .env file")
	}
	publisher := Publisher()
	password := os.Getenv("PASSWORD")
	mongourl1 := os.Getenv("mongourl1")
	mongourl2 := os.Getenv("mongourl2")
	values := Generator([]SensorStruct{co2Sensor, coSensor, no2Sensor}, "1", publisher, "AirQuality", "north")
	decodedValues :=  bson.M{}
	json.Unmarshal(values, &decodedValues)
	subscriber :=  Subscriber()
	Subscribe(subscriber, "north")
	channel := CompareMessages()
	valuesSubscribed := <-channel
	if !reflect.DeepEqual(values, valuesSubscribed) {
		t.Errorf("Error in pipeline")
	} else {
		t.Log("hivemq is working fine\n")
	}

	sensorType := decodedValues["sensorType"].(string)
	valuesMap := decodedValues["values"].(map[string]interface{})


	date := decodedValues["date"].(string)
	region := decodedValues["region"].(string)
	mongo :=Mongo(password, mongourl1, mongourl2)
	collection := GetCollection("prodam", "nothData",mongo)
	filter := bson.D{
		{Key: "sensorType", Value: sensorType},
		{Key: "date", Value: date},
		{Key: "region", Value: region},
	}
	for key, value := range valuesMap {
		floatValue, _ := value.(float64)
		filter = append(filter, bson.E{Key: "values."+key, Value: floatValue})
	}

	valuesMongo := Select(collection,filter)
	if valuesMongo.Date != decodedValues["date"] {
		t.Errorf("Error in pipeline")
	} 
	if valuesMongo.Region != decodedValues["region"] {
		t.Errorf("Error in pipeline")
	} 
	if valuesMongo.SensorType != decodedValues["sensorType"] {
		t.Errorf("Error in pipeline")
	} 
	if valuesMongo.Values.CO != valuesMap["CO"] {
		t.Errorf("Error in pipeline")
	}	
	if valuesMongo.Values.CO2 != valuesMap["CO2"] {
		t.Errorf("Error in pipeline")
	}
	if valuesMongo.Values.NO2 != valuesMap["NO2"] {
		t.Errorf("Error in pipeline")
	}
}