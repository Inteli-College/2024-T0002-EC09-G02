---
sidebar_position: 1
slug: '/sprint_2/MQTT/data-gen'
label: "Geração dos dados"
---

# Geração dos dados

O processo de geração de dados simulados é realizado através do script `generator.py`, que utiliza a classe Reading e seus parâmetros predefinidos para criar leituras fictícias de sensores. 

## Classe Reading

A classe Reading é definida para representar leituras de sensores com parâmetros específicos. Os parâmetros incluem o tipo de sensor, unidade de medida, valores mínimo e máximo, valor médio e a probabilidade de gerar valores discrepantes (outliers). Diversas instâncias dessa classe são criadas para diferentes tipos de sensores e armazenadas em uma lista chamada `sensors`.

Para cada tipo de sensor, são definidos parâmetros específicos em forma de dicionários. Abaixo estão os parâmetros para alguns sensores específicos:

*CO2 Sensor (co2_sensor_params)*

```
Tipo: CO2
Unidade: ppm
Mínimo: 300, Máximo: 1000
Valor Médio: 400
Probabilidade de Valor Discrepante: 0.05
```

*CO Sensor (co_sensor_params)*

```
Tipo: CO
Unidade: ppm
Mínimo: 0, Máximo: 10
Valor Médio: 1
Probabilidade de Valor Discrepante: 0.05
```
*PM10 Sensor (pm10_sensor_params)*
```
Tipo: PM10
Unidade: ug/m³
Mínimo: 0, Máximo: 100
Valor Médio: 20
Probabilidade de Valor Discrepante: 0.05
```

Em suma, geramos valores para os sensores **'co_sensor', 'co2_sensor', 'no2_sensor', 'pm10_sensor', 'pm25_sensor', 'solar_intensity_sensor' e 'noise_sensor'**.

## Função generate_mock_sensor_value

```python
def generate_mock_sensor_value(min_value, max_value, average_value, outlier_probability):
    # Calculate interquartile range
    iqr = (max_value - min_value) / 2
    
    # Check if outlier should be generated
    if np.random.rand() < outlier_probability:
        # Generate outlier value outside the interquartile range
        outlier_value = np.random.normal(loc=average_value, scale=iqr * 1.5)
        
        # Ensure the outlier value does not exceed the bounds
        outlier_value = min(max_value, max(min_value, outlier_value))
        
        return outlier_value
    else:
        # Generate normal sensor value within the interquartile range
        normal_value = np.random.normal(loc=average_value, scale=iqr)
        
        # Ensure the normal value does not exceed the bounds
        normal_value = min(max_value, max(min_value, normal_value))
        
        return normal_value
```

Esta função é crucial para a criação de valores sintéticos de sensores com base nos parâmetros definidos. Ela considera os valores mínimo, máximo, médio e a probabilidade de gerar outliers. A lógica utiliza a distribuição normal para gerar valores dentro ou fora do intervalo interquartil, dependendo da probabilidade de outliers.

## Armazenamento local de dados
O loop final percorre cada sensor na lista sensors e para cada região (east, west, north, south, center), gera 100 leituras simuladas. Estas leituras são armazenadas em arquivos CSV específicos para cada sensor e região dentro do diretório `data/`.

Além disso, são criados arquivos de configuração JSON para cada sensor e região, contendo detalhes como tipo de sensor, região, taxa de transmissão, unidade e qualidade de serviço (QoS). Esses arquivos de configuração são cruciais para integrar eficientemente os dados simulados com o AWS IoT Core. 

Em suma, o processo gera a seguinte organização de arquivos:

```bash
├── data
│   ├── center
│   │   ├── CO2.csv
│   │   ├── CO2.json
│   │   ├── CO.csv
│   │   ├── CO.json
│   │   ├── NO2.csv
│   │   ├── NO2.json
│   │   ├── noise.csv
│   │   ├── noise.json
│   │   ├── PM10.csv
│   │   ├── PM10.json
│   │   ├── PM2.5.csv
│   │   ├── PM2.5.json
│   │   ├── solar.csv
│   │   └── solar.json
│   ├── east
│   │   ├── CO2.csv
│   │   ├── CO2.json
│   │   ├── CO.csv
│   │   ├── CO.json
│   │   ├── NO2.csv
│   │   ├── NO2.json
│   │   ├── noise.csv
│   │   ├── noise.json
│   │   ├── PM10.csv
│   │   ├── PM10.json
│   │   ├── PM2.5.csv
│   │   ├── PM2.5.json
│   │   ├── solar.csv
│   │   └── solar.json
│   ├── north
│   │   ├── CO2.csv
│   │   ├── CO2.json
│   │   ├── CO.csv
│   │   ├── CO.json
│   │   ├── NO2.csv
│   │   ├── NO2.json
│   │   ├── noise.csv
│   │   ├── noise.json
│   │   ├── PM10.csv
│   │   ├── PM10.json
│   │   ├── PM2.5.csv
│   │   ├── PM2.5.json
│   │   ├── solar.csv
│   │   └── solar.json
│   ├── south
│   │   ├── CO2.csv
│   │   ├── CO2.json
│   │   ├── CO.csv
│   │   ├── CO.json
│   │   ├── NO2.csv
│   │   ├── NO2.json
│   │   ├── noise.csv
│   │   ├── noise.json
│   │   ├── PM10.csv
│   │   ├── PM10.json
│   │   ├── PM2.5.csv
│   │   ├── PM2.5.json
│   │   ├── solar.csv
│   │   └── solar.json
│   └── west
│       ├── CO2.csv
│       ├── CO2.json
│       ├── CO.csv
│       ├── CO.json
│       ├── NO2.csv
│       ├── NO2.json
│       ├── noise.csv
│       ├── noise.json
│       ├── PM10.csv
│       ├── PM10.json
│       ├── PM2.5.csv
│       ├── PM2.5.json
│       ├── solar.csv
│       └── solar.json
```

Este processo de geração de dados proporciona uma abordagem eficaz para testar o sistema em diferentes cenários antes da implementação com dispositivos IoT reais.

## Publicação dos dados

A publicação se dá pelo script `publisher.py`, localizado na pasta `generic_sensor`. Este script é responsável pela conexão com o AWS IoT Core, leitura da configuração do sensor a partir de um arquivo JSON, obtenção dos dados do sensor de um arquivo CSV e publicação desses dados em um tópico MQTT.

Para executar o script `publisher.py`, é necessário fornecer dois argumentos de linha de comando:

```
--sensor: Especifica o tipo de sensor a ser publicado.
--region: Define a região associada ao sensor.
```

**Exemplo de Uso:**

```
python publisher.py --sensor CO2 --region east
```

## Fluxo de Execução

**Leitura de Configuração:**
1. O script lê as configurações do sensor a partir do arquivo JSON associado à região e ao tipo de sensor fornecidos como argumentos. Em resumo, ele procura dinamicamente os valores e configurações associados a esse sensor na pasta `data`.
2. Cria uma instância da classe Configuration para armazenar essas configurações.

**Leitura de Dados CSV:**
1. Obtém dados simulados do sensor a partir do arquivo CSV associado à região e ao tipo de sensor fornecidos como argumentos.
2. Armazena esses dados em uma lista.
   
**Conexão MQTT com AWS IoT Core:**
1. Estabelece uma conexão segura com o AWS IoT Core usando certificados TLS.
2. Utiliza os parâmetros de região, certificados e chaves associados ao sensor, disponíveis na pasta `authentication_keys`.

**Publicação de Dados:**

1. Itera sobre os dados do sensor.
2. Arredonda os valores e cria uma mensagem JSON com base nas configurações do sensor.
3. Publica essa mensagem no tópico MQTT específico para o sensor, região e AWS IoT Core.

### Detalhes de Conexão
- **Intervalo de Publicação (interval):** O tempo entre as publicações é calculado com base na taxa de transmissão configurada para o sensor.
- **Tópico MQTT (topic):** Construído com base na região e no tipo de sensor, este é o canal onde os dados são publicados no AWS IoT Core (padrão `sensor/região/sensor`)

