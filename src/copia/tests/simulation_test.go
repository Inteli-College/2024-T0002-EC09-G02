package main

import (
	"fmt"
	"os"
	"testing"
	"time"

	mqtt "github.com/eclipse/paho.mqtt.golang"
	godotenv "github.com/joho/godotenv"
)

func TestHiveMQTAuthentication(t *testing.T) {
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

	client := mqtt.NewClient(opts)
	if token := client.Connect(); token.Wait() && token.Error() != nil {
		t.Errorf("Error in connection with broker MQTT: %v", token.Error())
	} else {
		t.Log("Connection with broker MQTT and authentication succeeded")
	}
}

func TestSubscribing(t *testing.T) {
	Client := Subscriber()

	// sensorRegions := []string{"south", "north", "east", "west", "central"}
	// sensorsTypes := []string{"solar", "gas", "PM", "nosie"}

	if token := Client.Subscribe("south/noise", 0, nil); token.Wait() && token.Error() != nil {
		t.Errorf("Error subscribing: %v", token.Error())
	} else {
		t.Log("Subscripton in topic south/noise succeeded")
	}

}

func TestSubscribingAllTopics(t *testing.T) {
	Client := Subscriber()

	sensorRegions := []string{"south", "north", "east", "west", "central"}
	sensorTypes := []string{"solar", "gas", "PM", "nosie"}

	succeededCount := 0
	successCount := len(sensorRegions) * len(sensorTypes)
	for _, region := range sensorRegions {
		for _, sensor := range sensorTypes {
			token := Client.Subscribe(region+"/"+sensor, 0, nil)
			if token.Wait() && token.Error() != nil {
				t.Fatalf("Failed to subscribe MQTT topic: %s, error: %v", region+"/"+sensor, token.Error())
			}

			succeededCount += 1
			time.Sleep(time.Second * 2)
			Client.Unsubscribe(region + "/" + sensor)
			time.Sleep(time.Second * 2)
		}
	}

	if succeededCount == successCount {
		t.Log("Subscribed all topics successfully!")
	}

}
