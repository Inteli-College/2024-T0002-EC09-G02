# Create an IoT Thing
resource "aws_iot_thing" "sensor_north_particle_thing" {
  name = "SensorNorthParticleIoTThing"
}

resource "aws_iot_thing" "sensor_west_particle_thing" {
  name = "SensorWestParticleIoTThing"
}

resource "tls_private_key" "north_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "north_signed_cert" {
  private_key_pem = tls_private_key.north_key.private_key_pem

  validity_period_hours = 87600

  allowed_uses = []

  subject {
    organization = "test"
  }
}

resource "aws_iot_certificate" "north_cert" {
  certificate_pem = trimspace(tls_self_signed_cert.north_signed_cert.cert_pem)
  active          = true
}

resource "aws_iot_thing_principal_attachment" "attachment" {
  principal = aws_iot_certificate.north_cert.arn
  thing     = aws_iot_thing.sensor_north_particle_thing.name
}

output "cert" {
  value = tls_self_signed_cert.north_signed_cert.cert_pem
}

output "key" {
  value     = tls_private_key.north_key.private_key_pem
  sensitive = true
}

data "aws_arn" "north_thing_arn" {
  arn = aws_iot_thing.sensor_north_particle_thing.arn
}

resource "aws_iot_policy" "north_thing_policy" {
  name = "thingpolicy_${aws_iot_thing.sensor_north_particle_thing.name}"

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
          "Resource" : "arn:aws:iot:${data.aws_arn.north_thing_arn.region}:${data.aws_arn.north_thing_arn.account}:topic/*"
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Subscribe",
          "Resource" : "arn:aws:iot:${data.aws_arn.north_thing_arn.region}:${data.aws_arn.north_thing_arn.account}:topicfilter/*"
        },
        {
          "Effect" : "Allow",
          "Action" : "iot:Connect",
          "Resource" : [
            "arn:aws:iot:${data.aws_arn.north_thing_arn.region}:${data.aws_arn.north_thing_arn.account}:client/*"
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

resource "aws_s3_bucket_object" "north_cert_object" {
  bucket                 = var.bucket_state
  key                    = "authentication-key/north_cert.pem"
  content                = tls_self_signed_cert.north_signed_cert.cert_pem
  server_side_encryption = "AES256"
}