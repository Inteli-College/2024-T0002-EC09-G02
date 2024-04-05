package main

import (
	"testing"
)



func TestConsumingFromTopic(t *testing.T) {
	consumer := Consumer()
	Subscribe(consumer,"north",t)
}