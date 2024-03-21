resource "aws_lambda_function" "lambda_function_kafka_listener" {
  function_name = "KafkaListenerLambdaFunction"

  package_type = "Image"
  image_uri    = "public.ecr.aws/<namespace>/<repository-name>:<tag>"
  role         = var.lab_role
  timeout     = 60
  memory_size = 1024
}

resource "aws_lambda_function" "lambda_function_kafka_consumer" {
  function_name = "KafkaConsumerLambdaFunction"

  package_type = "Image"
  image_uri    = "public.ecr.aws/<namespace>/<repository-name>:<tag>"
  role         = var.lab_role

  timeout     = 60
  memory_size = 1024
}