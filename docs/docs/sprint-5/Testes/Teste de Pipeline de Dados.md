---
sidebar_position: 7
slug: 'Testes da pipeline de dados'
---

# Testes da pipeline de dados

Esta documentação descreve os testes realizados na pipeline de dados desenvolvida para coleta e processamento de informações sobre poluição sonora e de gases. O objetivo desses testes é garantir a integridade e o funcionamento adequado da pipeline.


## Publicação de um dado

Para iniciar, é gerado um dado simulado que representa informações de qualidade do ar. Este dado é então publicado no tópico 'north/airQuality' no broker de mensageria HiveMQ. Abaixo está um exemplo do formato do dado gerado:

```json
{
  "date": "2024-01-01T04:10:00Z",
  "sensorType": "AirQuality",
  "values": {
    "NO2": 33.3482293679101,
    "CO2": 10.483687006235096,
    "CO": 677.0335652750239
  },
  "region": "north"
}
```


## Teste de subscriber no HiveMQ

O próximo passo é verificar se o dado gerado foi publicado corretamente no tópico 'north/airQuality' do HiveMQ. Para isso, é utilizado o arquivo 'subscriber.go', que se inscreve no referido tópico e compara o dado recebido com o dado gerado. Se o teste for bem-sucedido, a mensagem abaixo é exibida:

```json
hivemq is working fine
```

## Teste de Consumer Kafka

Após a publicação no HiveMQ, o dado é consumido pelo Kafka para processamento adicional. O teste de consumer é realizado para verificar se o dado publicado no tópico 'north/airQuality' do HiveMQ é corretamente consumido pelo Kafka. O arquivo 'consumer.go' é utilizado para este propósito, comparando o dado consumido com o dado gerado. Se o teste for bem-sucedido, a seguinte mensagem é exibida:

```json
kafka is working fine
```

## Teste de MongoDB

Por fim, é verificado se o dado publicado no tópico 'north/airQuality' do HiveMQ é consumido corretamente pelo Kafka e armazenado no MongoDB. O teste é realizado pelo arquivo 'mongo.go', que se conecta ao MongoDB e verifica cada campo do dado publicado. Se todos os campos estiverem corretos, a seguinte mensagem é exibida:

```json
Pipeline is working fine
```

## Execução dos Testes

Os testes podem ser executados manualmente utilizando o seguinte comando:

```bash
cd src/testes
go test -v
```

Além disso, há uma automação configurada usando o GitHub Actions, que executa os testes a cada push no repositório. A ação responsável por isso é chamada Teste de Pipeline de Dados e pode ser acessada [aqui](https://github.com/Inteli-College/2024-T0002-EC09-G02/actions/workflows/ci-test-go.yml).

