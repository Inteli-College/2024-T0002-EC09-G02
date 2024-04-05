package main

import (
	"fmt"
	"os"

	mqtt "github.com/eclipse/paho.mqtt.golang"
	godotenv "github.com/joho/godotenv"
)

var connectHandler mqtt.OnConnectHandler = func(client mqtt.Client) {
	fmt.Println("Connected")
}

var connectLostHandler mqtt.ConnectionLostHandler = func(client mqtt.Client, err error) {
	fmt.Printf("Connection lost: %v", err)
}

var messageSubHandler mqtt.MessageHandler = func(client mqtt.Client, msg mqtt.Message) {
	fmt.Printf("[SUBSCRIBER][%s] %s \n", msg.Topic(), msg.Payload())
}

func Subscriber() mqtt.Client {
	err := godotenv.Load(".env")
	if err != nil {
		fmt.Printf("Error loading environment: %s", err)
	}

	var broker = os.Getenv("BROKER_ADDR")
	var port = 8883

	opts := mqtt.NewClientOptions()
	opts.AddBroker(fmt.Sprintf("tls://%s%d/mqtt", broker, port))
	opts.SetClientID("Subscriber")
	opts.SetUsername(os.Getenv("HIVE_USER"))
	opts.SetPassword(os.Getenv("HIVE_PSWD"))
	opts.OnConnect = connectHandler
	opts.OnConnectionLost = connectLostHandler
	opts.SetDefaultPublishHandler(messageSubHandler)

	client := mqtt.NewClient(opts)
	if token := client.Connect(); token.Wait() && token.Error() != nil {
		panic(token.Error())
	}

	return client
}
