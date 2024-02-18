package main

import (
	"encoding/json"
	MQTT "github.com/eclipse/paho.mqtt.golang"
	"math"
	"testing"
	"time"
)

var mockConfig = Configuration{
	Sensor:           "air",
	Longitude:        59.0,
	Latitude:         55.0,
	TransmissionRate: 10,
	Unit:             "W/m³",
	QoS:              1,
}
var mockData = []float64{1.25, 2.50, 1.25, 2.50, 1.25, 2.50, 0, 0, 2.50, 1.25, 2.50}
var receivedMessages []string
var firstMessageTimestamp time.Time
var lastMessageTimestamp time.Time
var receivedQoS []byte

var messagePubTestHandler MQTT.MessageHandler = func(client MQTT.Client, msg MQTT.Message) {
	payload := string(msg.Payload())
	receivedMessages = append(receivedMessages, payload)

	// Capture QoS
	receivedQoS = append(receivedQoS, msg.Qos())

	// Capture timestamps for the first and last messages
	if len(receivedMessages) == 1 {
		firstMessageTimestamp = time.Now()
	}

	lastMessageTimestamp = time.Now()
}

// Test to check if messages are received successfully

func TestConnectMQTT(t *testing.T) {
	client := connectMQTT("publisher")
	defer client.Disconnect(250)

	if !client.IsConnected() {
		t.Fatalf("\x1b[31m[FAIL] Unable to connect to MQTT broker\x1b[0m")
	} else {
		t.Log("\x1b[32m[PASS] Connected to MQTT broker\x1b[0m")
	}
}

func setupTest(t *testing.T) {
	t.Helper()
	receivedMessages = []string{}
	client := connectMQTT("subscriber")
	defer client.Disconnect(250)

	if token := client.Subscribe("sensor/"+mockConfig.Sensor, mockConfig.QoS, messagePubTestHandler); token.Wait() && token.Error() != nil {
		t.Fatalf("Error subscribing to MQTT: %s", token.Error())
	}
	publishData(client, mockConfig, mockData)
}

func TestMessageReception(t *testing.T) {
	setupTest(t)

	numMessages := len(mockData)
	timePerMessage := time.Duration(int(time.Second) / int(mockConfig.TransmissionRate))
	timeMargin := int(0.5 * float64(time.Second))
	totalTime := time.Duration(numMessages*int(timePerMessage) + timeMargin)
	time.Sleep(totalTime)

	if len(receivedMessages) == 0 {
		t.Fatal("\x1b[31m[FAIL] No messages received\x1b[0m")
	} else {
		t.Log("\x1b[32m[PASS] Messages received successfully\x1b[0m")
	}
}

func TestMessageIntegrity(t *testing.T) {
	setupTest(t)
	var decodedMessages []float64
	for _, msg := range receivedMessages {
		var m Data
		if err := json.Unmarshal([]byte(msg), &m); err != nil {
			t.Fatalf("Error decoding JSON: %s", err)
		}
		decodedMessages = append(decodedMessages, m.Value)
	}

	// Check if each item in mockData has at least one correspondence in decodedMessages
	for _, expectedValue := range mockData {
		found := false
		for _, decodedValue := range decodedMessages {
			if expectedValue == decodedValue {
				found = true
				break
			}
		}
		if !found {
			t.Fatalf("\x1b[31m[FAIL] Value %v not found in received messages: %v\x1b[0m", expectedValue, decodedMessages)
		}
	}
	t.Log("\x1b[32m[PASS] Correct messages received\x1b[0m")
}

func TestTransmissionRate(t *testing.T) {
	setupTest(t)
	// Calculate time period in seconds
	timePeriod := lastMessageTimestamp.Sub(firstMessageTimestamp).Seconds()

	// Calculate frequency in Hz
	frequency := float64(len(mockData)) / timePeriod

	// Check transmission rate
	if math.Abs(frequency-mockConfig.TransmissionRate) > 2 {
		t.Fatalf("\x1b[31m[FAIL] Received frequency: %f, expected: %f\x1b[0m", frequency, mockConfig.TransmissionRate)
	} else {
		t.Log("\x1b[32m[PASS] Transmission rate within acceptable range of 2Hz\x1b[0m")
	}
}

func TestQoS(t *testing.T) {
	client := connectMQTT("subscriber")
	defer client.Disconnect(250)

	if token := client.Subscribe("sensor/"+mockConfig.Sensor, mockConfig.QoS, messagePubTestHandler); token.Wait() && token.Error() != nil {
		t.Fatalf("Error subscribing to MQTT: %s", token.Error())
	}
	receivedMessages = []string{}
	mockQoSData := []float64{1.25}
	publishData(client, mockConfig, mockQoSData)
	time.Sleep(time.Duration(1 / int(mockConfig.TransmissionRate) * int(time.Second)))

	switch mockConfig.QoS {
	case 0:
		t.Log("\x1b[33m[INFO] QoS set to 0, no guarantee of message delivery\x1b[0m")
	case 1:
		if len(receivedMessages) == 0 {
			t.Fatalf("\x1b[31m[FAIL] No messages received with QoS 1\x1b[0m")
		} else {
			for _, msg := range receivedMessages {
				var m Data
				if err := json.Unmarshal([]byte(msg), &m); err != nil {
					t.Fatalf("Error decoding JSON: %s", err)
				}
				if m.Value != mockQoSData[0] {
					t.Fatalf("\x1b[31m[FAIL] Received %v, expected %v\x1b[0m", m.Value, mockQoSData[0])
				}
			}
			t.Log("\x1b[32m[PASS] Message received with QoS 1\x1b[0m")
		}
	case 2:
		if len(receivedMessages) != 1 {
			t.Fatalf("\x1b[31m[FAIL] Incorrect number of messages received with QoS 2. Expected: 1, received: %d\x1b[0m", len(receivedMessages))
		} else {
			var m Data
			if err := json.Unmarshal([]byte(receivedMessages[0]), &m); err != nil {
				t.Fatalf("Error decoding JSON: %s", err)
			}
			if m.Value != mockQoSData[0] {
				t.Fatalf("\x1b[31m[FAIL] Received %v, expected %v\x1b[0m", m.Value, mockQoSData[0])
			}
			t.Log("\x1b[32m[PASS] Message received with QoS 2\x1b[0m")
		}
	default:
		t.Fatalf("\x1b[31m[FAIL] Invalid QoS value: %d\x1b[0m", mockConfig.QoS)
	}

}
