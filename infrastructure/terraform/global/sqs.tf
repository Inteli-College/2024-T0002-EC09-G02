resource "aws_sqs_queue" "iot_events_queue" {
  name                       = "IotEventsQueue"
  delay_seconds              = 1 # Configura o delay da fila para 1 segundo
  visibility_timeout_seconds = 60
  message_retention_seconds  = 86400
}