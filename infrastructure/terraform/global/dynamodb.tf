resource "aws_dynamodb_table" "sensor_north" {
  name         = "sensorNorth"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "Region North Table"
  }
}

resource "aws_dynamodb_table" "sensor_south" {
  name         = "sensorSouth"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "Region South Table"
  }
}

resource "aws_dynamodb_table" "sensor_east" {
  name         = "sensorEast"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "Region East Table"
  }
}

resource "aws_dynamodb_table" "sensor_west" {
  name         = "sensorWest"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "Region West Table"
  }
}

resource "aws_dynamodb_table" "sensor_center" {
  name         = "sensorCenter"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "Region Center Table"
  }
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
      "Resource": [
        "${aws_dynamodb_table.sensor_north.arn}",
        "${aws_dynamodb_table.sensor_south.arn}",
        "${aws_dynamodb_table.sensor_east.arn}",
        "${aws_dynamodb_table.sensor_west.arn}",
        "${aws_dynamodb_table.sensor_center.arn}"]
    }
  ]
}
EOF
}

# Rule to send data from IoT Core to DynamoDB
resource "aws_iot_topic_rule" "sensor_north_topic_rule" {
  name        = "SensorNorthRule"
  description = "Sensor North rule to send data to DynamoDB"
  enabled     = true

  sql         = "SELECT * FROM '/sensor/region/north'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    role_arn = var.lab_role
    put_item {
      table_name = aws_dynamodb_table.sensor_north.name
    }
  }
}

resource "aws_iot_topic_rule" "sensor_south_topic_rule" {
  name        = "SensorSouthRule"
  description = "Sensor South rule to send data to DynamoDB"
  enabled     = true

  sql         = "SELECT * FROM '/sensor/region/south'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    role_arn = var.lab_role
    put_item {
      table_name = aws_dynamodb_table.sensor_south.name
    }
  }
}

resource "aws_iot_topic_rule" "sensor_east_topic_rule" {
  name        = "SensorEastRule"
  description = "Sensor East rule to send data to DynamoDB"
  enabled     = true

  sql         = "SELECT * FROM '/sensor/region/east'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    role_arn = var.lab_role
    put_item {
      table_name = aws_dynamodb_table.sensor_east.name
    }
  }
}

resource "aws_iot_topic_rule" "sensor_west_topic_rule" {
  name        = "SensorWestRule"
  description = "Sensor West rule to send data to DynamoDB"
  enabled     = true

  sql         = "SELECT * FROM '/sensor/region/west'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    role_arn = var.lab_role
    put_item {
      table_name = aws_dynamodb_table.sensor_west.name
    }
  }
}

resource "aws_iot_topic_rule" "sensor_center_topic_rule" {
  name        = "SensorCenterRule"
  description = "Sensor Center rule to send data to DynamoDB"
  enabled     = true

  sql         = "SELECT * FROM '/sensor/region/center'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    role_arn = var.lab_role
    put_item {
      table_name = aws_dynamodb_table.sensor_center.name
    }
  }
}
