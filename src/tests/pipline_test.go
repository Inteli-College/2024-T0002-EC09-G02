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
	values := Generator([]SensorStruct{co2Sensor, coSensor, no2Sensor}, "1", publisher, "AirQuality", "south")
	decodedValues :=  bson.M{}
	json.Unmarshal(values, &decodedValues)
	consumer := Consumer()
	subscriber :=  Subscriber()
	Subscribe(subscriber, "south")
	valuesSubscribed := CompareMessages()
	if !reflect.DeepEqual(values, valuesSubscribed) {
		t.Errorf("Error in pipeline")
	} else {
		t.Log("hivemq is working fine")
	}
	valuesConsumed := ConsumeReturn(consumer, "south")
	if !reflect.DeepEqual(values, valuesConsumed) {
		t.Errorf("Error in pipeline")
	} else {
		t.Log("confluent is working fine")
	}
	//{"sensorType": sensorType, "values": values, "date": Date, "region": region}
	sensorType := decodedValues["sensorType"]
	valuesMap := decodedValues["values"].(map[string]interface{})
	date := decodedValues["date"]
	region := decodedValues["region"]
	mongo :=Mongo(password)
	collection := GetCollection("database name", "collection name",mongo)
	filter := bson.D{
		{Key: "sensorType", Value: sensorType},
		{Key: "values", Value: valuesMap},
		{Key: "date", Value: date},
		{Key: "region", Value: region},
	}
	valuesMongo := Select(collection,filter)
	if valuesMongo.date != decodedValues["date"] {
		t.Errorf("Error in pipeline")
	} else {
		t.Log("mongo is working fine")
	}
	if valuesMongo.region != decodedValues["region"] {
		t.Errorf("Error in pipeline")
	} else {
		t.Log("mongo is working fine")
	}
	if valuesMongo.sensorType != decodedValues["sensorType"] {
		t.Errorf("Error in pipeline")
	} else {
		t.Log("mongo is working fine")
	}
}