import csv
import random
import sys


def generate_mock_sensor_value(min_value, max_value, resolution):
    value_range = max_value - min_value
    num_steps = int(value_range / resolution)
    random_step = random.randint(0, num_steps)
    mock_sensor_value = min_value + random_step * resolution
    return mock_sensor_value


if len(sys.argv) != 6:
    print('''Usage: python generator.py <num_leituras> <resolucao>
          <min_valor> <max_valor> <filename>''')
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
