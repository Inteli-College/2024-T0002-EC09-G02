# Create an IoT Thing
resource "aws_iot_thing" "sensor_north_particle_thing" {
  name = "SensorNorthParticleIoTThing"
}

resource "aws_iot_thing" "sensor_west_particle_thing" {
  name = "SensorWestParticleIoTThing"
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["iot:*"]
    resources = ["*"]
    sid      = "AllowAllIotActions"
  }
}
# IoT policy to allow publishing to DynamoDB
resource "aws_iot_policy" "policy_document" {
  name   = "policy_all"
  policy = data.aws_iam_policy_document.policy_document.json
}

resource "aws_iot_certificate" "certificate" {
  active = true
}

resource "aws_iot_policy_attachment" "att" {
  policy = aws_iot_policy.policy_document.name
  target = aws_iot_certificate.certificate.arn
}

resource "aws_iot_thing_principal_attachment" "iot_thing_principal_attachment_north" {
  thing = aws_iot_thing.sensor_north_particle_thing.name
  principal  = aws_iot_certificate.certificate.arn
}

resource "aws_iot_thing_principal_attachment" "iot_thing_principal_attachment_west" {
  thing    = aws_iot_thing.sensor_west_particle_thing.name
  principal = aws_iot_certificate.certificate.arn
}

# Rule to send data from IoT Core to DynamoDB
resource "aws_iot_topic_rule" "sensor_west_particle_to_dynamodb_rule" {
  name        = "SensorWestParticleToDynamoDBRule"
  description = "IoT rule to insert data into DynamoDB"
  enabled     = true

  sql         = "SELECT * FROM 'your/topic/here'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    role_arn = var.lab_role
    put_item {
      table_name = "sensor_west_particle"
    }
  }
}

resource "aws_iot_topic_rule" "sensor_north_particle_to_dynamodb_rule" {
  name        = "SensorNorthParticleToDynamoDBRule"
  description = "IoT rule to insert data into DynamoDB"
  enabled     = true

  sql         = "SELECT * FROM 'your/topic/here'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    role_arn = var.lab_role
    put_item {
      table_name = "sensor_north_particle"
    }
  }
}
