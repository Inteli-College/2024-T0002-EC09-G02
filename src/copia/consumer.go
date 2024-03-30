package main

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/confluentinc/confluent-kafka-go/kafka"
	"go.mongodb.org/mongo-driver/mongo"
)

var ConsumerPointer *kafka.Consumer
var CollectionPointer *mongo.Collection

func Consumer(collectionPointer *mongo.Collection) *kafka.Consumer {
	
	CollectionPointer = collectionPointer 
	if ConsumerPointer == nil {
		GenerateConsumer()
		return ConsumerPointer
	}
	return ConsumerPointer
}

func GenerateConsumer() {
	// Configurações do consumidor
	conf := ReadConfig()
	consumer, err := kafka.NewConsumer(&conf)
	if err != nil {
		panic(err)
	}
	// defer consumer.Close()

	ConsumerPointer = consumer
}

func Subscribe(consumer *kafka.Consumer,topic string) {
	fmt.Printf("aqui: %v",consumer)
	// Assinar tópico
	err := consumer.SubscribeTopics([]string{topic}, nil)

	throw(err)

	// Consumir mensagens
	for {
		msg, err := consumer.ReadMessage(-1)
		if err == nil {
			fmt.Printf("Received message: %s\n", string(msg.Value))
			Writer("./logs/teste.txt",fmt.Sprintf("%v",string(msg.Value)))
			result := strings.Split(string(msg.Value), ",")
			transmission_rate_hz, _ := strconv.Atoi(result[2])
			qos, _ := strconv.Atoi(result[3])
			data := &Data{sensor_type: result[0], region: result[1], transmission_rate_hz: transmission_rate_hz, qos: qos, unit: result[4]}
			fmt.Printf("aqui5 %v", data.transmission_rate_hz)
			Insert(CollectionPointer, *data)
			fmt.Println("aqui6")
			Writer("./logs/consumer_logs.txt", "sensor_type: "+data.sensor_type+" region: "+data.region+" transmission_rate_hz: "+strconv.Itoa(data.transmission_rate_hz)+" qos: "+strconv.Itoa(data.qos)+"unit: "+result[4]+"\n")

		} else {
			fmt.Printf("Consumer error: %v (%v)\n", err, msg)
			break
		}
	}
}
