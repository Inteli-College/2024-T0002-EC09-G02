resource "aws_lambda_function" "lambda_function_kafka_listener" {
  function_name = "KafkaListenerLambdaFunction"

  package_type = "Image"
  image_uri    = "058264141216.dkr.ecr.us-east-1.amazonaws.com/kafka-listener-repo:latest"
  role         = var.lab_role
  timeout      = 60
  memory_size  = 1024
}
