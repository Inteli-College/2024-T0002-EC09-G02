# Create an IoT Thing
resource "aws_iot_thing" "sensor_north_thing" {
  name = "SensorNorthIoTThing"
}

resource "aws_iot_thing" "sensor_west_thing" {
  name = "SensorWestIoTThing"
}

resource "aws_iot_thing" "sensor_test_thing" {
  name = "SensorTestIoTThing"
}

resource "aws_iot_thing" "sensor_south_thing" {
  name = "SensorSouthIoTThing"
}

resource "aws_iot_thing" "sensor_east_thing" {
  name = "SensorEastIoTThing"
}

resource "aws_iot_thing" "sensor_center_thing" {
  name = "SensorCenterIoTThing"
}

resource "tls_private_key" "north_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_private_key" "center_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_private_key" "west_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_private_key" "south_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_private_key" "east_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_private_key" "test_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "north_signed_cert" {
  private_key_pem = tls_private_key.north_key.private_key_pem

  validity_period_hours = 87600

  allowed_uses = []

  subject {
    organization = "North"
  }
}

resource "tls_self_signed_cert" "center_signed_cert" {
  private_key_pem = tls_private_key.center_key.private_key_pem

  validity_period_hours = 87600

  allowed_uses = []

  subject {
    organization = "Center"
  }
}

resource "tls_self_signed_cert" "west_signed_cert" {
  private_key_pem = tls_private_key.west_key.private_key_pem

  validity_period_hours = 87600

  allowed_uses = []

  subject {
    organization = "West"
  }
}

resource "tls_self_signed_cert" "south_signed_cert" {
  private_key_pem = tls_private_key.south_key.private_key_pem

  validity_period_hours = 87600

  allowed_uses = []

  subject {
    organization = "South"
  }
}

resource "tls_self_signed_cert" "east_signed_cert" {
  private_key_pem = tls_private_key.east_key.private_key_pem

  validity_period_hours = 87600

  allowed_uses = []

  subject {
    organization = "East"
  }
}

resource "tls_self_signed_cert" "test_signed_cert" {
  private_key_pem = tls_private_key.test_key.private_key_pem

  validity_period_hours = 87600

  allowed_uses = []

  subject {
    organization = "Test"
  }
}



resource "aws_iot_certificate" "north_cert" {
  certificate_pem = trimspace(tls_self_signed_cert.north_signed_cert.cert_pem)
  active          = true
}

resource "aws_iot_certificate" "center_cert" {
  certificate_pem = trimspace(tls_self_signed_cert.center_signed_cert.cert_pem)
  active          = true
}

resource "aws_iot_certificate" "west_cert" {
  certificate_pem = trimspace(tls_self_signed_cert.west_signed_cert.cert_pem)
  active          = true
}

resource "aws_iot_certificate" "south_cert" {
  certificate_pem = trimspace(tls_self_signed_cert.south_signed_cert.cert_pem)
  active          = true
}

resource "aws_iot_certificate" "east_cert" {
  certificate_pem = trimspace(tls_self_signed_cert.east_signed_cert.cert_pem)
  active          = true
}

resource "aws_iot_certificate" "test_cert" {
  certificate_pem = trimspace(tls_self_signed_cert.test_signed_cert.cert_pem)
  active          = true
}

resource "aws_iot_thing_principal_attachment" "north_thing_principal_attachment" {
  principal = aws_iot_certificate.north_cert.arn
  thing     = aws_iot_thing.sensor_north_thing.name
}

resource "aws_iot_thing_principal_attachment" "center_thing_principal_attachment" {
  principal = aws_iot_certificate.center_cert.arn
  thing     = aws_iot_thing.sensor_center_thing.name
}

resource "aws_iot_thing_principal_attachment" "west_thing_principal_attachment" {
  principal = aws_iot_certificate.west_cert.arn
  thing     = aws_iot_thing.sensor_west_thing.name
}

resource "aws_iot_thing_principal_attachment" "south_thing_principal_attachment" {
  principal = aws_iot_certificate.south_cert.arn
  thing     = aws_iot_thing.sensor_south_thing.name
}

resource "aws_iot_thing_principal_attachment" "east_thing_principal_attachment" {
  principal = aws_iot_certificate.east_cert.arn
  thing     = aws_iot_thing.sensor_east_thing.name
}

resource "aws_iot_thing_principal_attachment" "test_thing_principal_attachment" {
  principal = aws_iot_certificate.test_cert.arn
  thing     = aws_iot_thing.sensor_test_thing.name
}


output "north_cert_pem" {
  value = tls_self_signed_cert.north_signed_cert.cert_pem
}

output "center_cert_pem" {
  value = tls_self_signed_cert.center_signed_cert.cert_pem
}

output "west_cert_pem" {
  value = tls_self_signed_cert.west_signed_cert.cert_pem
}

output "south_cert_pem" {
  value = tls_self_signed_cert.south_signed_cert.cert_pem
}

output "east_cert_pem" {
  value = tls_self_signed_cert.east_signed_cert.cert_pem
}

output "test_cert_pem" {
  value = tls_self_signed_cert.test_signed_cert.cert_pem
}

output "north_key_pem" {
  value     = tls_private_key.north_key.private_key_pem
  sensitive = true
}

output "center_key_pem" {
  value     = tls_private_key.center_key.private_key_pem
  sensitive = true
}

output "west_key_pem" {
  value     = tls_private_key.west_key.private_key_pem
  sensitive = true
}

output "south_key_pem" {
  value     = tls_private_key.south_key.private_key_pem
  sensitive = true
}

output "east_key_pem" {
  value     = tls_private_key.east_key.private_key_pem
  sensitive = true
}

output "test_key_pem" {
  value     = tls_private_key.test_key.private_key_pem
  sensitive = true
}

data "aws_arn" "north_thing_arn" {
  arn = aws_iot_thing.sensor_north_thing.arn
}

data "aws_arn" "center_thing_arn" {
  arn = aws_iot_thing.sensor_center_thing.arn
}

data "aws_arn" "west_thing_arn" {
  arn = aws_iot_thing.sensor_west_thing.arn
}

data "aws_arn" "south_thing_arn" {
  arn = aws_iot_thing.sensor_south_thing.arn
}

data "aws_arn" "east_thing_arn" {
  arn = aws_iot_thing.sensor_east_thing.arn
}

data "aws_arn" "test_thing_arn" {
  arn = aws_iot_thing.sensor_test_thing.arn
}

resource "aws_iot_policy" "north_thing_policy" {
  name = "thingpolicy_${aws_iot_thing.sensor_north_thing.name}"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "iot:Publish",
            "iot:Receive",
            "iot:PublishRetain"
          ],
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.north_thing_arn.region}:${data.aws_arn.north_thing_arn.account}:topic/sensor/north/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Subscribe",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.north_thing_arn.region}:${data.aws_arn.north_thing_arn.account}:topicfilter/sensor/north/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Connect",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.north_thing_arn.region}:${data.aws_arn.north_thing_arn.account}:client/*",
          ]
        }
      ]
    }
  )
}

resource "aws_iot_policy" "center_thing_policy" {
  name = "thingpolicy_${aws_iot_thing.sensor_center_thing.name}"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "iot:Publish",
            "iot:Receive",
            "iot:PublishRetain"
          ],
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.center_thing_arn.region}:${data.aws_arn.center_thing_arn.account}:topic/sensor/center/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Subscribe",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.center_thing_arn.region}:${data.aws_arn.center_thing_arn.account}:topicfilter/sensor/center/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Connect",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.center_thing_arn.region}:${data.aws_arn.center_thing_arn.account}:client/*",
          ]
        }
      ]
    }
  )
}

resource "aws_iot_policy" "west_thing_policy" {
  name = "thingpolicy_${aws_iot_thing.sensor_west_thing.name}"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "iot:Publish",
            "iot:Receive",
            "iot:PublishRetain"
          ],
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.west_thing_arn.region}:${data.aws_arn.west_thing_arn.account}:topic/sensor/west/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Subscribe",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.west_thing_arn.region}:${data.aws_arn.west_thing_arn.account}:topicfilter/sensor/west/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Connect",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.west_thing_arn.region}:${data.aws_arn.west_thing_arn.account}:client/*",
          ]
        }
      ]
    }
  )
}

resource "aws_iot_policy" "south_thing_policy" {
  name = "thingpolicy_${aws_iot_thing.sensor_south_thing.name}"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "iot:Publish",
            "iot:Receive",
            "iot:PublishRetain"
          ],
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.south_thing_arn.region}:${data.aws_arn.south_thing_arn.account}:topic/sensor/south/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Subscribe",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.south_thing_arn.region}:${data.aws_arn.south_thing_arn.account}:topicfilter/sensor/south/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Connect",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.south_thing_arn.region}:${data.aws_arn.south_thing_arn.account}:client/*",
          ]
        }
      ]
    }
  )
}

resource "aws_iot_policy" "east_thing_policy" {
  name = "thingpolicy_${aws_iot_thing.sensor_east_thing.name}"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "iot:Publish",
            "iot:Receive",
            "iot:PublishRetain"
          ],
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.east_thing_arn.region}:${data.aws_arn.east_thing_arn.account}:topic/sensor/east/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Subscribe",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.east_thing_arn.region}:${data.aws_arn.east_thing_arn.account}:topicfilter/sensor/east/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Connect",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.east_thing_arn.region}:${data.aws_arn.east_thing_arn.account}:client/*",
          ]
        }
      ]
    }
  )
}

resource "aws_iot_policy" "test_thing_policy" {
  name = "thingpolicy_${aws_iot_thing.sensor_test_thing.name}"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "iot:Publish",
            "iot:Receive",
            "iot:PublishRetain"
          ],
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.test_thing_arn.region}:${data.aws_arn.test_thing_arn.account}:topic/test/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Subscribe",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.test_thing_arn.region}:${data.aws_arn.test_thing_arn.account}:topicfilter/test/*",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Connect",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.test_thing_arn.region}:${data.aws_arn.test_thing_arn.account}:client/*",
          ]
        }
      ]
    }
  )
}

resource "aws_iot_policy_attachment" "north_attachment" {
  policy = aws_iot_policy.north_thing_policy.name
  target = aws_iot_certificate.north_cert.arn
}

resource "aws_iot_policy_attachment" "center_attachment" {
  policy = aws_iot_policy.center_thing_policy.name
  target = aws_iot_certificate.center_cert.arn
}

resource "aws_iot_policy_attachment" "west_attachment" {
  policy = aws_iot_policy.west_thing_policy.name
  target = aws_iot_certificate.west_cert.arn
}

resource "aws_iot_policy_attachment" "south_attachment" {
  policy = aws_iot_policy.south_thing_policy.name
  target = aws_iot_certificate.south_cert.arn
}

resource "aws_iot_policy_attachment" "east_attachment" {
  policy = aws_iot_policy.east_thing_policy.name
  target = aws_iot_certificate.east_cert.arn
}

resource "aws_iot_policy_attachment" "test_attachment" {
  policy = aws_iot_policy.test_thing_policy.name
  target = aws_iot_certificate.test_cert.arn
}

data "aws_iot_endpoint" "iot_endpoint" {
  endpoint_type = "iot:Data-ATS"
}

output "iot_endpoint" {
  value = data.aws_iot_endpoint.iot_endpoint.endpoint_address
}

resource "aws_s3_bucket_object" "north_private_key_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/north_key.pem"
  content                = tls_private_key.north_key.private_key_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "center_private_key_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/center_key.pem"
  content                = tls_private_key.center_key.private_key_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "west_private_key_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/west_key.pem"
  content                = tls_private_key.west_key.private_key_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "south_private_key_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/south_key.pem"
  content                = tls_private_key.south_key.private_key_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "test_private_key_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/test_key.pem"
  content                = tls_private_key.test_key.private_key_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "east_private_key_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/east_key.pem"
  content                = tls_private_key.east_key.private_key_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "north_cert_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/north_cert.pem"
  content                = tls_self_signed_cert.north_signed_cert.cert_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "center_cert_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/center_cert.pem"
  content                = tls_self_signed_cert.center_signed_cert.cert_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "west_cert_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/west_cert.pem"
  content                = tls_self_signed_cert.west_signed_cert.cert_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "south_cert_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/south_cert.pem"
  content                = tls_self_signed_cert.south_signed_cert.cert_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "east_cert_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/east_cert.pem"
  content                = tls_self_signed_cert.east_signed_cert.cert_pem
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "test_cert_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/test_cert.pem"
  content                = tls_self_signed_cert.test_signed_cert.cert_pem
  server_side_encryption = "AES256"
}