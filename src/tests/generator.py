import csv
import random
import sys

def generate_mock_sensor_value(min_value, max_value, resolution):
    # Calculate the range of possible values within the given min and max
    value_range = max_value - min_value
    
    # Calculate the number of possible steps within the range based on resolution
    num_steps = int(value_range / resolution)
    
    # Generate a random step within the range
    random_step = random.randint(0, num_steps)
    
    # Calculate the actual value based on the random step and resolution
    mock_sensor_value = min_value + random_step * resolution
    
    return mock_sensor_value

if len(sys.argv) != 6:
    print("Usage: python generator.py <num_leituras> <resolucao> <min_valor> <max_valor>")
    sys.exit(1)

# Extract command-line arguments
num_leituras = int(sys.argv[1])
resolucao = float(sys.argv[2])
min_valor = float(sys.argv[3])
max_valor = float(sys.argv[4])
filename = str(sys.argv[5])

print(num_leituras, resolucao, min_valor, max_valor)
# Gerar leituras e escrever no arquivo CSV
with open(filename, "w", newline="") as csvfile:
    writer = csv.writer(csvfile)

    # Gerar e escrever leituras
    for _ in range(num_leituras):
        valor = generate_mock_sensor_value(min_valor, max_valor, resolucao)
        writer.writerow([valor])

print(f"Arquivo {filename} gerado com sucesso.")