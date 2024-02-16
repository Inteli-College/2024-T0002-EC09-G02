from mqtt_python.publisher import Configuration, connect_mqtt, publish_data
import time
import json
from datetime import timedelta

mock_config = Configuration(
    sensor="solar",
    region="Butanta",
    transmission_rate_hz=10,
    unit="W/m³",
    qos=1,
)

mock_data = [1.25, 2.50, 1.25, 2.50, 1.25, 2.50, 0, 0, 2.50, 1.25, 2.50]
received_messages = []
first_message_timestamp = None
last_message_timestamp = None
received_qos = []


def test_connect_mqtt():
    client = connect_mqtt("publisher")
    assert client
    client.disconnect()


def setup_test():
    def on_message(client, userdata, message):
        print("Received message: ", message.payload.decode())
        global received_messages, first_message_timestamp, last_message_timestamp
        received_messages.append(message.payload.decode())
        if len(received_messages) == 1:
            first_message_timestamp = time.time()
        last_message_timestamp = time.time()


    global received_messages
    received_messages = []
    client = connect_mqtt("subscriber")
    client.on_message = on_message
    client.subscribe(f'sensor/{mock_config.region}/{mock_config.sensor}',
                     qos=mock_config.qos)

    client.loop_start()
    publish_data(client, mock_config, mock_data)

    return client


def test_message_reception():
    client = setup_test()

    num_messages = len(mock_data)
    time_per_message = 1/mock_config.transmission_rate_hz
    time_margin = 0.5 * time_per_message
    total_time = num_messages * time_per_message + time_margin
    time.sleep(total_time)

    assert len(received_messages) > 0
    client.disconnect()


def test_message_integrity():
    setup_test()  # Assuming setup_test() is defined elsewhere
    
    decoded_messages = []
    for msg in received_messages:
        m = json.loads(msg)
        decoded_messages.append(m)

    for expected_value in mock_data:
        assert any(msg['value'] == expected_value for msg in decoded_messages)

def test_transmission_rate():
    setup_test()  # Assuming setup_test() is defined elsewhere
    print(first_message_timestamp, last_message_timestamp)
    time_period = timedelta(seconds=(last_message_timestamp - first_message_timestamp)).total_seconds()
    frequency = len(mock_data) / time_period

    # Check transmission rate
    assert abs(frequency - mock_config.transmission_rate_hz) < 10


def test_qos():
    global received_messages
    received_messages = []
    client = connect_mqtt("subscriber")

    client.loop_start()

    def on_message(client, userdata, message):
        received_messages.append(message.payload.decode())

    client.on_message = on_message

    client.subscribe(f'sensor/{mock_config.region}/{mock_config.sensor}', mock_config.qos)
    
    mock_qos_data = [1.25]
    publish_data(client, mock_config, mock_qos_data)

    if mock_config.qos == 0:
        print("\x1b[33m[INFO] QoS set to 0, no guarantee of message delivery\x1b[0m")
    elif mock_config.qos == 1:
        if len(received_messages) == 0:
            raise AssertionError("\x1b[31m[FAIL] No messages received with QoS 1\x1b[0m")
        else:
            for msg in received_messages:
                m = json.loads(msg)
                if m['value'] != mock_qos_data[0]:
                    raise AssertionError("\x1b[31m[FAIL] Received {}, expected {}\x1b[0m".format(m['value'], mock_qos_data[0]))
            print("\x1b[32m[PASS] Message received with QoS 1\x1b[0m")
    elif mock_config.qos == 2:
        if len(received_messages) != 1:
            raise AssertionError("\x1b[31m[FAIL] Incorrect number of messages received with QoS 2. Expected: 1, received: {}\x1b[0m".format(len(received_messages)))
        else:
            m = json.loads(received_messages[0])
            if m['value'] != mock_qos_data[0]:
                raise AssertionError("\x1b[31m[FAIL] Received {}, expected {}\x1b[0m".format(m['value'], mock_qos_data[0]))
            print("\x1b[32m[PASS] Message received with QoS 2\x1b[0m")
    else:
        raise AssertionError("\x1b[31m[FAIL] Invalid QoS value: {}\x1b[0m".format(mock_config['qos']))