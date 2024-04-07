package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/confluentinc/confluent-kafka-go/kafka"
	"go.mongodb.org/mongo-driver/mongo"
)

var ConsumerPointer *kafka.Consumer
var CollectionPointer *mongo.Collection

func Consumer() *kafka.Consumer {

	if ConsumerPointer == nil {
		GenerateConsumer()
		return ConsumerPointer
	}
	return ConsumerPointer
}

func GenerateConsumer() {
	// Configurações do consumidor
	configmap := ReadConfig()
	consumer, err := kafka.NewConsumer(&configmap)
	if err != nil {
		panic(err)
	}
	// defer consumer.Close()

	ConsumerPointer = consumer
}

func Consume(consumer *kafka.Consumer,topic string, t *testing.T) {
	// Assinar tópico
	err := consumer.SubscribeTopics([]string{topic}, nil)

	if err != nil {
		t.Errorf("Error subscribing: %v", err)
	} else {
		t.Log("Subscripton in topic north succeeded")
	}

	// Consumir mensagens
	initialtime := time.Now()
	messagecount := 0
	for {
		msg, err := consumer.ReadMessage(-1)
		if err == nil {
			fmt.Printf("Received message: %s\n", string(msg.Value))
			var dataPointer *string
			err := json.Unmarshal(msg.Value,dataPointer)
			if err != nil {
				fmt.Println("Error unmarshalling data")
				os.Exit(1)
			}
			t.Logf("Data received: %s", *dataPointer)
			finaltime := time.Now()
			messagecount++
			if finaltime.Sub(initialtime) > 10*time.Second {
				t.Logf("Received %d messages\n", messagecount)
				t.Logf("messages per second: %f\n", float64(messagecount)/finaltime.Sub(initialtime).Seconds())
				break
			}
			
		} else {
			t.Logf("Consumer error: %v (%v)\n", err, msg)
			break
		}
	}
}

func ConsumeReturn(consumer *kafka.Consumer,topic string) []byte{
	// Assinar tópico
	err := consumer.SubscribeTopics([]string{topic}, nil)

	if err != nil {
		fmt.Printf("Error subscribing: %v", err)
	} else {
		fmt.Println("Subscripton in topic north succeeded")
	}

	// Consumir mensagens
	for {
		msg, err := consumer.ReadMessage(-1)
		if err == nil {
			return msg.Value
		} 
	}
}

func ReadConfig() kafka.ConfigMap {
    // reads the client configuration from client.properties
    // and returns it as a key-value map
    m := make(map[string]kafka.ConfigValue)

    file, err := os.Open("client.properties")
    if err != nil {
        fmt.Fprintf(os.Stderr, "Failed to open file: %s", err)
        os.Exit(1)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.TrimSpace(scanner.Text())
        if !strings.HasPrefix(line, "#") && len(line) != 0 {
            kv := strings.Split(line, "=")
            parameter := strings.TrimSpace(kv[0])
            value := strings.TrimSpace(kv[1])
            m[parameter] = value
        }
    }

    if err := scanner.Err(); err != nil {
        fmt.Printf("Failed to read file: %s", err)
        os.Exit(1)
    }

    return m
}