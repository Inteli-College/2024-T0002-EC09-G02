package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"math"
	"os"
	"time"

	MQTT "github.com/eclipse/paho.mqtt.golang"
)

type Configuration struct {
	Unit             string  `json:"unit"`
	TransmissionRate float64 `json:"transmission_rate_hz"` // in Hz
	Longitude        float64 `json:"longitude"`
	Latitude         float64 `json:"latitude"`
	Sensor           string  `json:"sensor"`
	QoS              byte    `json:"qos"`
}

type Data struct {
	Value            float64   `json:"value"`
	Unit             string    `json:"unit"`
	TransmissionRate float64   `json:"transmission_rate"`
	Longitude        float64   `json:"longitude"`
	Latitude         float64   `json:"latitude"`
	Sensor           string    `json:"sensor"`
	Timestamp        time.Time `json:"timestamp"`
	QoS              byte      `json:"qos"`
}

func main() {
	if len(os.Args) != 3 {
		fmt.Println("Usage: go run publisher.go <config_path> <csv_path>")
		return
	}

	configPath := os.Args[1]
	csvPath := os.Args[2]

	config, err := readConfig(configPath)
	if err != nil {
		panic(err)
	}

	client := connectMQTT("publisher")
	defer client.Disconnect(250)

	data, err := readCSV(csvPath)
	if err != nil {
		panic(err)
	}

	publishData(client, config, data)
}

func connectMQTT(node_name string) MQTT.Client {
	opts := MQTT.NewClientOptions().AddBroker("tcp://localhost:1891")
	opts.SetClientID(node_name)
	client := MQTT.NewClient(opts)

	if token := client.Connect(); token.Wait() && token.Error() != nil {
		panic(token.Error())
	}

	return client
}

func readCSV(csvPath string) ([]float64, error) {
	file, err := os.Open(csvPath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var values []float64
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()

		var value float64
		_, err := fmt.Sscanf(line, "%f", &value)
		if err != nil {
			return nil, err
		}

		values = append(values, value)
	}

	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return values, nil
}

func publishData(client MQTT.Client, config Configuration, data []float64) {
	interval := time.Second / time.Duration(config.TransmissionRate)
	ticker := time.NewTicker(interval)
	defer ticker.Stop()

	for _, value := range data {
		roundedValue := math.Round(value*100) / 100

		message := createJSONMessage(config, roundedValue)

		token := client.Publish("sensor/" + config.Sensor, byte(config.QoS), false, message)
		token.Wait()

		<-ticker.C
	}
}

func createJSONMessage(config Configuration, roundedValue float64) []byte {
	data := Data{
		Value:            roundedValue,
		Unit:             config.Unit,
		TransmissionRate: config.TransmissionRate,
		Longitude:        config.Longitude,
		Latitude:         config.Latitude,
		Sensor:           config.Sensor,
		Timestamp:        time.Now(),
		QoS:              config.QoS,
	}

	jsonMsg, err := json.Marshal(data)
	if err != nil {
		panic(err)
	}

	return jsonMsg
}

func readConfig(filename string) (Configuration, error) {
	file, err := os.Open(filename)
	if err != nil {
		return Configuration{}, err
	}
	defer file.Close()

	decoder := json.NewDecoder(file)
	config := Configuration{}
	err = decoder.Decode(&config)
	return config, err
}
