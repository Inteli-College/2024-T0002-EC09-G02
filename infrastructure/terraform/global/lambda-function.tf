resource "aws_lambda_function" "lambda_function_kafka_listener" {
  function_name = "KafkaListenerLambdaFunction"

  package_type = "Image"
  image_uri    = "${aws_ecr_repository.kafka-listener-repo.repository_url}:latest"
  role         = var.lab_role
  timeout      = 15
  memory_size  = 1024
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.iot_events_queue.arn
  function_name    = aws_lambda_function.lambda_function_kafka_listener.arn
}