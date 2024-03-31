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

var Client mqtt.Client
 
func Publisher() mqtt.Client {
	if (Client != nil) {
		return Client
	}

	err := godotenv.Load(".env")
	if err != nil {
		fmt.Printf("Error loading .env file: %s", err)
	}

	var broker = os.Getenv("BROKER_ADDR")
	var port = 8883
	opts := mqtt.NewClientOptions()
	opts.AddBroker(fmt.Sprintf("tls://%s%d/mqtt", broker, port))
	opts.SetClientID("Publisher")
	opts.SetUsername(os.Getenv("HIVE_USER"))
	opts.SetPassword(os.Getenv("HIVE_PSWD"))
	opts.OnConnect = connectHandler
	opts.OnConnectionLost = connectLostHandler

	client := mqtt.NewClient(opts)
	if token := client.Connect(); token.Wait() && token.Error() != nil {
		panic(token.Error())
	}

	Client = client

	return client

	// for {
	// 	name := "user" + strconv.Itoa(rand.IntN(100))
	// 	password := "password" + strconv.Itoa(rand.IntN(100))
	// 	age := rand.IntN(40)
	// 	hours_spent := rand.IntN(100)
	// 	text := name + "," + password + "," + strconv.Itoa(age) + "," + strconv.Itoa(hours_spent)
	// 	token := client.Publish("test_topic/fazol", 1, false, text)
	// 	token.Wait()
	// 	Writer("./logs/publisher_logs.txt", text+"\n")
	// 	time.Sleep(2 * time.Second)
	// }
}
