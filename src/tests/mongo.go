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

var ClientPointer *mongo.Client
//"sensorType": sensorType, "values": values, "date": Date, "region": region
type Data struct {
	sensorType string
	values     map[string]float64
	date       time.Time
	region     string
}


func Mongo(password string) *mongo.Client {
	if ClientPointer == nil {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()

		client, err := mongo.Connect(ctx, options.Client().ApplyURI("mongodb+srv://albertomiranda:"+password+"@betinhodb.xeezpin.mongodb.net/?retryWrites=true&w=majority&appName=betinhoDb"))

		if err != nil {
			panic(err)
		}
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
		dateString := result.date.Format("2006-01-02 15:04:05")
		valuesString := ""
		valuesString = mapToString(result.values)
		fmt.Println("sensorType: "+result.sensorType, "values: "+valuesString, "date: "+ dateString, "region: "+result.region)
	}

}

func Insert(collection *mongo.Collection, result Data) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	values :=  mapToString(result.values)
	dateString := result.date.Format("2006-01-02 15:04:05")
	res, err := collection.InsertOne(ctx, bson.D{{Key: "sensorType", Value: result.sensorType}, {Key: "values", Value: values}, {Key: "date", Value: dateString}, {Key: "region", Value: result.region}})
	fmt.Printf("insert item with id %v", res.InsertedID)
	if err != nil {
		panic(err)
	}
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

func mapToString(values map[string]float64) string {
	valuesString := ""
	for key, value := range values {
		valuesString += key + ": " + strconv.FormatFloat(value, 'f', 6, 64) + ", "
	}
	return valuesString
}
