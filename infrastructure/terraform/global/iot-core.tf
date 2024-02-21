# Create an IoT Thing
resource "aws_iot_thing" "sensor_north_particle_thing" {
  name = "Sensor North Particle IoT Thing"
}

# IoT policy to allow publishing to DynamoDB
resource "aws_iot_policy" "publish_policy" {
  name   = "publish_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iot:Connect",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iot:Publish",
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach policy to the IoT Thing
resource "aws_iot_policy_attachment" "iot_policy_attachment" {
  policy = aws_iot_policy.publish_policy.name
  target = aws_iot_thing.sensor_north_particle_thing.arn
}

# Role for IoT to interact with DynamoDB
resource "aws_iam_role" "iot_dynamodb_role" {
  name = "iot_dynamodb_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "iot.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Policy to allow IoT to write to DynamoDB
resource "aws_iam_policy" "iot_dynamodb_policy" {
  name   = "iot_dynamodb_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Resource": "${aws_dynamodb_table.sensor_north_particle.arn}"
    }
  ]
}
EOF
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "iot_dynamodb_attach" {
  role       = aws_iam_role.iot_dynamodb_role.name
  policy_arn = aws_iam_policy.iot_dynamodb_policy.arn
}

# Rule to send data from IoT Core to DynamoDB
resource "aws_iot_topic_rule" "example_rule" {
  name        = "exampleRule"
  description = "Example rule to send data to DynamoDB"
  enabled     = true

  sql = "SELECT * FROM 'sensor_north_particle'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    role_arn = aws_iam_role.iot_dynamodb_role.arn
    put_item {
      table_name = aws_dynamodb_table.sensor_north_particle.name
    }
  }
}
