package main

import (
	"github.com/confluentinc/confluent-kafka-go/kafka"
)

var ProducerPointer *kafka.Producer

func Producer() *kafka.Producer {
	if ProducerPointer == nil {
		GenerateProducer()
		return ProducerPointer
	}
	return ProducerPointer
}

func GenerateProducer() {
	// Configurações do produtor
	conf := ReadConfig()
	producer, err := kafka.NewProducer(&conf)
	if err != nil {
		panic(err)
	}	
	// defer producer.Close()

	ProducerPointer = producer
}

func Publish(message string, topic string, producer *kafka.Producer) int {
	// Enviar mensagem
	err := producer.Produce(&kafka.Message{
		TopicPartition: kafka.TopicPartition{Topic: &topic, Partition: kafka.PartitionAny},
		Value:          []byte(message),
	}, nil)
	if err != nil {
		panic(err)
	}
	// throw(err)
	// Aguardar a entrega de todas as mensagens
	
	return producer.Flush(15 * 1000)
}


