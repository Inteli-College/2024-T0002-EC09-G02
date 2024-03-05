---
sidebar_position: 3
slug: '/sprint_2/MQTT/index.md'
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

