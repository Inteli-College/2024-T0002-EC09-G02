package main

import (
	"context"
	"fmt"
	"strconv"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

type Data struct {
	sensor_type        string
	region    string
	transmission_rate_hz         int
	qos int
	unit string 
}

var ClientPointer *mongo.Client

func Mongo(password string) *mongo.Client {
	if ClientPointer == nil {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()

		client, err := mongo.Connect(ctx, options.Client().ApplyURI("mongodb+srv://prodan:"+password+"@cluster0.zxw7sgo.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"))

		throw(err)
		TestConection(client, ctx)
		ClientPointer = client
	}
	return ClientPointer
}

func Select(collection *mongo.Collection, filter bson.D) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	cursor, err := collection.Find(ctx, filter)
	if err != nil {
		panic(err)
	}
	var results []Data
	if err = cursor.All(ctx, results); err != nil {
		panic(err)
	}
	for _, result := range results {
		fmt.Println("sensor_type: "+result.sensor_type, "region: "+result.region, "transmission_rate_hz: "+strconv.Itoa(result.transmission_rate_hz), "qos: "+strconv.Itoa(result.qos), "unit: "+result.unit)
	}

}

func Insert(collection *mongo.Collection, data Data) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	fmt.Printf("data %v", data)
	fmt.Printf("collection %v", collection)
	res, err := collection.InsertOne(ctx, bson.D{{Key: "sensor_type", Value: data.sensor_type},  {Key: "region", Value: data.region}, {Key: "transmission_rate_hz", Value: data.transmission_rate_hz}, {Key: "qos", Value: data.qos}, {Key: "unit", Value: data.unit}})
	fmt.Printf("insert item with id %v", res.InsertedID)
	throw(err)
}

func GetCollection(databaseName string, collectionName string, client *mongo.Client) *mongo.Collection {
	return client.Database(databaseName).Collection(collectionName)
}

func TestConection(client *mongo.Client, ctx context.Context) bool {
	err := client.Ping(ctx, readpref.Primary())

	if err == nil {

		return true
	}

	fmt.Printf("%v", err)

	return false
}
