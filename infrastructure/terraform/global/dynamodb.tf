resource "aws_dynamodb_table" "sensor_north_particle" {
  name           = "sensor_north_particle"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "Region North Table"
  }
}

resource "aws_dynamodb_table" "sensor_west_particle" {
  name           = "sensor_west_particle"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "Region West Table"
  }
}
