#!/usr/bin/env bash
# stop script on error
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <config_path> <csv_path>"
    exit 1
fi

# Get absolute path for config file
config_path="$(readlink -f "$1")"

# Get absolute path for CSV file
csv_path="$(readlink -f "$2")"

# Check for python 3
if ! python3 --version &> /dev/null; then
  printf "\nERROR: python3 must be installed.\n"
  exit 1
fi

# Check to see if root CA file exists, download if not
if [ ! -f ./root-CA.crt ]; then
  printf "\nDownloading AWS IoT Root CA certificate from AWS...\n"
  curl https://www.amazontrust.com/repository/AmazonRootCA1.pem > root-CA.crt
fi

# Check to see if AWS Device SDK for Python exists, download if not
if [ ! -d ./aws-iot-device-sdk-python-v2 ]; then
  printf "\nCloning the AWS SDK...\n"
  git clone https://github.com/aws/aws-iot-device-sdk-python-v2.git --recursive
fi

# Check to see if AWS Device SDK for Python is already installed, install if not
if ! python3 -c "import awsiot" &> /dev/null; then
  printf "\nInstalling AWS SDK...\n"
  python3 -m pip install ./aws-iot-device-sdk-python-v2
  result=$?
  if [ $result -ne 0 ]; then
    printf "\nERROR: Failed to install SDK.\n"
    exit $result
  fi
fi

# run pub/sub sample app using certificates downloaded in package
printf "\nRunning pub/sub sample application...\n"
python3 src/pubsub.py --config_path "$config_path" --csv_path "$csv_path" --endpoint a1c08ash4mpwrf-ats.iot.us-east-1.amazonaws.com --ca_file root-CA.crt --cert air_quality_sensor.cert.pem --key air_quality_sensor.private.key --client_id basicPubSub --topic sdk/test/python --count 0