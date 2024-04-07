package main

import (
	"context"
	"fmt"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

var ClientPointer *mongo.Client
//"sensorType": sensorType, "values": values, "date": Date, "region": region
type Data struct {
    SensorType string
    Values     struct {
        CO  float64 `bson:"CO"`
        CO2 float64 `bson:"CO2"`
        NO2 float64 `bson:"NO2"`
    } `bson:"values"`
    Date   string `bson:"date"`
    Region string `bson:"region"`
}


func Mongo(password string, mongourl1 string, mongourl2 string) *mongo.Client {
	if ClientPointer == nil {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		// fmt.Printf(mongourl1 + password + mongourl2)
		client, err := mongo.Connect(ctx, options.Client().ApplyURI("mongodb+srv://prodan:hvsmA8xGAnr2lrbi@megamentes.uudopi3.mongodb.net/prodam"))

		if err != nil {
			panic(err)
		}
		TestConection(client, ctx)
		ClientPointer = client
	}
	return ClientPointer
}

func Select(collection *mongo.Collection, filter bson.D) Data{
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	cursor, err := collection.Find(ctx, filter)
	if err != nil {
		panic(err)
	}
	
	fmt.Printf("filter %v\n", filter)
	fmt.Printf("cursor %v\n", cursor)
	slice := make([]Data, 0)
	pointerToSlice := &slice
	
	if err = cursor.All(ctx, pointerToSlice); err != nil {
		panic(err)
	}
	fmt.Printf("slice %v\n", slice)

	return slice[0]
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

// func main() {
// 	err := godotenv.Load(".env")
// 	if err != nil {
// 		fmt.Printf("Error loading environment: %s", err)
// 	}
// 	password := os.Getenv("PASSWORD")
// 	mongourl1 := os.Getenv("mongourl1")
// 	mongourl2 := os.Getenv("mongourl2")
// 	mongo :=Mongo(password, mongourl1, mongourl2)
// 	collection := GetCollection("prodam", "nothData",mongo)
// 	//{"date":"2027-01-01T00:00:00Z","region":"north","sensorType":"AirQuality","values":{"CO":400,"CO2":5,"NO2":100}}
// 	filter := bson.D{
// 		{Key: "sensorType", Value: "AirQuality"},
// 		{Key: "date", Value: "2027-01-01T00:00:00Z"},
// 		{Key: "region", Value: "north"},
// 		{Key: "values.CO", Value: 400},
// 		{Key: "values.CO2", Value: 5},
// 		{Key: "values.NO2", Value: 100},
// 		// {Key: "values", Value: bson.D{{Key: "CO", Value: 400}, {Key: "CO2", Value: 5}, {Key: "NO2", Value: 100}},
// 	}
// 	Select(collection,filter)
// }
