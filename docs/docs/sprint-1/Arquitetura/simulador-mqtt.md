---
sidebar_position: 5
slug: '/sprint_1/arquitetura/simulador'
label: "Primeiro simulador MQTT"
---
# Primeiro simulador MQTT

Durante a Sprint 1, o grupo desenvolveu a primeira versão do simulador MQTT, que é um componente essencial para o projeto. O simulador MQTT é um dispositivo que publica mensagens em tópicos MQTT, simulando o comportamento de sensores IoT. O objetivo do simulador é gerar dados de teste para o sistema.

## Diagrama de Blocos do Simulador MQTT - v1.0

[text](simulador-mqtt.md)

## Funcionamento do simulador

Utilizamos abstrações em arquivos .json e CSV para garantir a reutilização do código. O arquivo .json contém configurações como taxa de transmissão, tipo de sensor, região e unidade, enquanto o CSV armazena valores simulados do sensor. Esses arquivos são especificados como argumentos de linha de comando do publisher. 

Para gerar os valores do CSV, empregamos o script "generator.py", que recebe parâmetros como o número de dados a serem criados, valor mínimo, valor máximo e resolução também pela linha de comando.

Os dados são publicados como json com metadados no tópico "sensor/<região>/<nome-do-sensor>".

Todas as principais funções, incluindo conexão com o broker, integridade de mensagens, taxa de transmissão e QoS, são testadas automaticamente em Python, através do GitHub Actions.

## Como rodar

### 1. Gerar dados de simulação

Primeiro, é necessário gerar os dados para simulação. Para isso, execute os seguintes comandos no diretório `~/src/simulador/mqtt_python`:

```
pip install csv paho-mqtt
```

```
python3 generator.py <num_de_valores> <resolucao> <valor_minimo> <valor_maximo> <nome_do_arquivo>
```

Isso gerará um CSV com o título escolhido.

A partir daí, podemos simular a leitura desse CSV (ou de qualquer outro). 

### 2. Criar arquivo de configuração

Crie um arquivo de configuração JSON com informações sobre o sensor. O arquivo deve seguir o seguinte padrão:
```
{
    "sensor": <nome_do_sensor>,
    "region": <regiao>,
    "transmission_rate_hz": <taxa_de_transmissao_em_herz>,
    "unit": <unidade>,
    "QoS": <qos>
}
```

### 3. Executar o Publisher MQTT

Certifique-se de ter o mosquitto instalado com arquivo de configuração (ouvindo na porta 1891) e inicie o broker local:

```
mosquitto -c mosquitto.conf
```

Execute o script publisher.py passando o caminho do arquivo de configuração JSON e o caminho do arquivo CSV:

```
python3 run publisher.py <config_path> <csv_path>
```

## Estrutura dos dados

### Configuração (arquivo json)
- unit: Unidade do sensor.
- transmission_rate_hz: Taxa de transmissão em Hertz.
- region: Região do sensor.
- sensor: Nome do sensor.
- qos: Qualidade de serviço para comunicação MQTT.

### Dados do Sensor (json publicado no tópico)
- value: Valor lido pelo sensor (proveniente do CSV)
- unit: Unidade do sensor.
- transmission_rate_hz: Taxa de transmissão em Hertz.
- region: Região do sensor.
- sensor: Nome do sensor.
- timestamp: Timestamp da leitura do sensor.
- qos: Qualidade de serviço para comunicação MQTT.
  

## Testes e validações do simulador MQTT

Todo o sistema 
