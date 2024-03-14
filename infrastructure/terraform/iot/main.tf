terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}
provider "aws" {
  region = "us-west-2"  # Change this to your desired AWS region
}

resource "aws_iot_policy" "mqtt_policy" {
  name        = "mqtt_policy"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iot:Publish",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iot_policy_attachment" "mqtt_policy_attachment" {
  policy_arn = aws_iot_policy.mqtt_policy.arn
  target     = "arn:aws:iot:*:*:client/*"
}

resource "aws_iot_certificate" "mqtt_certificate" {
  active = true
}

resource "aws_iot_policy_attachment" "default_attachment" {
  policy_arn = aws_iot_policy.mqtt_policy.arn
  target     = aws_iot_certificate.mqtt_certificate.arn
}

output "mqtt_broker_endpoint" {
  value = aws_iot_certificate.mqtt_certificate.endpoint
}

output "mqtt_certificate" {
  value = aws_iot_certificate.mqtt_certificate.certificate_pem
}

output "mqtt_private_key" {
  value = aws_iot_certificate.mqtt_certificate.private_key
}
