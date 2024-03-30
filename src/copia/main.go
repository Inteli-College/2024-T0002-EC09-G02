package main

import (
	"bufio"
	"fmt"
	"math/rand/v2"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"time"

	"github.com/confluentinc/confluent-kafka-go/kafka"
	godotenv "github.com/joho/godotenv"
	_ "github.com/mattn/go-sqlite3" // Import go-sqlite3 library
)

func main() {
	err := godotenv.Load(".env")
	throw(err)
	var password = os.Getenv("mongopassword")
	client := Mongo(password)
	collection := GetCollection("betinhoDb", "users", client)
	producer := Producer()
	consumer := Consumer(collection)
	go RunProducer(producer)
	go Subscribe(consumer,"test_topic")
	go RunMetabase()
	select {}
}

func throw(err error) {
	if err != nil {
		panic(err)
	}
}

func GenerateMessage() string {
	name := "user" + strconv.Itoa(rand.IntN(100))
	password := "password" + strconv.Itoa(rand.IntN(100))
	age := rand.IntN(40)
	hours_spent := rand.IntN(100)
	text := name + "," + password + "," + strconv.Itoa(age) + "," + strconv.Itoa(hours_spent)
	return text
}

func RunProducer(producer *kafka.Producer) {

	for {
		Publish(GenerateMessage(),"test_topic",producer)
		time.Sleep(1000000000)
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

func RunMetabase() {
	cmd := exec.Command("docker", "run", "-d", "-p", "3000:3000", "--name" ,"metabase","metabase/metabase")
	err := cmd.Run()
	if err != nil {
		panic(err)
	}
}