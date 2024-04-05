package main

import (
	"testing"

	"go.mongodb.org/mongo-driver/bson"
)


func TestSelecting(t *testing.T) {
	mongo := Mongo("password")
	collection := GetCollection("name", "collection",mongo)
	filter := bson.D{{"region", "north"}}
	Select(collection, filter)
}