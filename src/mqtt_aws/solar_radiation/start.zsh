#!/usr/bin/env zsh
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
if ! command -v python3 &> /dev/null; then
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
python3 src/publisher.py --config_path "$config_path" --csv_path "$csv_path" --endpoint a3ru784j6s0pfl-ats.iot.us-east-1.amazonaws.com --ca_file rad --cert north.pem.crt --key private-north.pem.key --client_id north --topic oi --count 0
