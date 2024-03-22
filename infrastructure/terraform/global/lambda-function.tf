resource "aws_lambda_function" "lambda_function_kafka_listener" {
  function_name = "KafkaListenerLambdaFunction"

  package_type = "Image"
  image_uri    = "${aws_ecr_repository.kafka-listener-repo.repository_url}:latest"
  role         = var.lab_role
  timeout      = 60
  memory_size  = 1024
}
