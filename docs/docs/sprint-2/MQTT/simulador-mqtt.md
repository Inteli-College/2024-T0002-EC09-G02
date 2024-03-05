---
sidebar_position: 3
slug: '/sprint_2/MQTT/simulador_mqtt'
label: "Simulador MQTT"
---
# AWS IoT Core

Nesta seção, vamos explicar a implementação da comunicação via MQTT inteiramente na nuvem, usanod o IoT COre.

O AWS IoT Core é um serviço da Amazon Web Services (AWS) projetado para gerenciar a comunicação eficiente entre dispositivos IoT (Internet das Coisas) e a nuvem. A escolha do AWS IoT Core para nosso projeto foi motivada por diversos benefícios cruciais.

A primeira vantagem é a **escalabilidade**, permitindo que o serviço ajuste automaticamente a capacidade para lidar com um grande número de dispositivos conectados. Isso é essencial para garantir o desempenho contínuo e eficiente do sistema, mesmo em ambientes dinâmicos.

Além disso, a **integração facilitada** com outros serviços da AWS oferece flexibilidade na construção e expansão do ecossistema do projeto. O AWS IoT Core se conecta harmoniosamente a outros serviços, possibilitando a implementação de soluções mais abrangentes e personalizadas.

Outro aspecto crucial é a **segurança otimizada**, alcançada através do uso de certificados. O AWS IoT Core implementa práticas de segurança robustas, garantindo a transmissão segura de dados entre os dispositivos IoT e a nuvem. O uso de certificados fortalece a autenticação e a proteção contra ameaças potenciais.

Nesse sentido, realizamos a implementação do código de geração e publicação de dados na pasta `~/src`, que contém o módulo Python `simulator`. A organização e funcionamento deles são explicados abaixo.

## Módulo simulator

O módulo é dividido da seguinte forma:

```bash
├── data
│   ├── center
│   ├── east
│   ├── north
│   ├── south
│   └── west
├── data_generator
│   ├── generator.py
│   └── reading.py
├── generic_sensor
│   ├── publisher.py
```

- data/: Este diretório organiza os dados gerados pelo simulador, dividindo-os em subdiretórios correspondentes às diferentes regiões do projeto (center, east, north, south, west). Isso facilita a categorização e o gerenciamento eficiente dos dados de cada localidade.
- data_generator/: Neste diretório, encontram-se os scripts responsáveis por gerar os dados simulados.
  - generator.py: O script principal que utiliza a lógica de simulação para criar dados de sensores fictícios.
  - reading.py: Define a classe Reading, utilizada para configurar os parâmetros de leitura de cada tipo de sensor, promovendo uma abordagem modular e personalizável.
- generic_sensor/: Este diretório contém o script de publicação, que implementa a lógica para enviar os dados gerados para o AWS IoT Core. Este componente é crucial para a integração eficaz entre o simulador e o serviço na nuvem.

### Geração dos dados

O processo de geração de dados simulados é realizado através do script `generator.py`, que utiliza a classe Reading e seus parâmetros predefinidos para criar leituras fictícias de sensores. 

#### Classe Reading

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

E assim por diante, para outros tipos de sensores.

#### Função generate_mock_sensor_value

Esta função é crucial para a criação de valores sintéticos de sensores com base nos parâmetros definidos. Ela considera os valores mínimo, máximo, médio e a probabilidade de gerar outliers. A lógica utiliza a distribuição normal para gerar valores dentro ou fora do intervalo interquartil, dependendo da probabilidade de outliers.

#### Armazenamento local de dados
O loop final percorre cada sensor na lista sensors e para cada região (east, west, north, south, center), gera 100 leituras simuladas. Estas leituras são armazenadas em arquivos CSV específicos para cada sensor e região dentro do diretório `data/`.

Além disso, são criados arquivos de configuração JSON para cada sensor e região, contendo detalhes como tipo de sensor, região, taxa de transmissão, unidade e qualidade de serviço (QoS). Esses arquivos de configuração são cruciais para integrar eficientemente os dados simulados com o AWS IoT Core.

Este processo de geração de dados proporciona uma abordagem eficaz para testar o sistema em diferentes cenários antes da implementação com dispositivos IoT reais.

### Publicação dos dados

![alt text](<../../../static/img/Diagrama de blocos - MQTT.png>)

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

#### Fluxo de Execução

**Leitura de Configuração:**
1. O script lê as configurações do sensor a partir do arquivo JSON associado à região e ao tipo de sensor fornecidos como argumentos. Em resumo, ele procura dinamicamente os valores e configurações associados a esse sensor na pasta `data`.
2. Cria uma instância da classe Configuration para armazenar essas configurações.

**Leitura de Dados CSV:**
1. Obtém dados simulados do sensor a partir do arquivo CSV associado à região e ao tipo de sensor fornecidos como argumentos.
2. Armazena esses dados em uma lista.
   
**Conexão MQTT com AWS IoT Core:**
1. Estabelece uma conexão segura com o AWS IoT Core usando certificados TLS.
2. Utiliza os parâmetros de região, certificados e chaves associados ao sensor, disponíveis na pasta `authentication_keys`.

Publicação de Dados:

1. Itera sobre os dados do sensor.
2. Arredonda os valores e cria uma mensagem JSON com base nas configurações do sensor.
3. Publica essa mensagem no tópico MQTT específico para o sensor, região e AWS IoT Core.

#### Detalhes de Conexão
- Intervalo de Publicação (interval): O tempo entre as publicações é calculado com base na taxa de transmissão configurada para o sensor.
= Tópico MQTT (topic): Construído com base na região e no tipo de sensor, este é o canal onde os dados são publicados no AWS IoT Core (padrão `sensor/região/sensor`)
