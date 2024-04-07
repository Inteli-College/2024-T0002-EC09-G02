---
sidebar_position: 7
slug: 'Testes'
---

# Testes Da pipeline de dados

Foi gerado um pipeline de dados para a coleta de dados de poluição sonora e de gases. Para garantir a integridade da pipeline de dados foi gerado um teste de integração que verifica se os dados estão sendo processados corretamente. Este teste segue 4 etapas

Além da sua gratuitdade, também podemos utilizar do grande potencial na criação de dashboards públicos, por isso escolhemos ele como nossa ferramenta de dashboards.

## Publicação de um dado

O arquivo generator.go é chamado para gerar e publicar 1 dado no tópico north/airQuality do hivemq (broker de mensageria). O dado gerado é:

```json
{"date":"2024-01-01T04:10:00Z","sensorType":"AirQuality","values":{"NO2":{"$numberDouble":"33.3482293679101"},"CO2":{"$numberDouble":"10.483687006235096"},"CO":{"$numberDouble":"677.0335652750239"}},"region":"north"}
```

E seus valores são gaurdados para comparação posteriormente

## Teste de subscriber no hivemq

O teste de subscriber é feito para verificar se o dado gerado foi publicado corretamente no tópico north/airQuality do hivemq. O teste é feito com o arquivo subscriber.go que se inscreve no tópico north/airQuality e verifica se o dado publicado é o mesmo que foi gerado. no sucesso é printado a mensagem:

```json
hivemq is working fine
```

### Teste consumer kafka

O teste de consumer é feito para verificar se o dado publicado no tópico north/airQuality do hivemq foi consumido corretamente pelo kafka. O teste é feito com o arquivo consumer.go que se inscreve no tópico data do kafka e verifica se o dado publicado é o mesmo que foi gerado. no sucesso é printado a mensagem:

```json
kafka is working fine
```

#### Teste mongodb

O teste de mongodb é feito para verificar se o dado publicado no tópico north/airQuality do hivemq foi consumido corretamente pelo kafka e armazenado no mongodb. O teste é feito com o arquivo mongo.go que se conecta ao mongodb e verifica cada campo do dado publicado. no sucesso é printado a mensagem:

```json
"Pipeline is working fine\n"
```

#### Usando o teste de integração da pipeline de dados

Podemos rodar o teste manualmente usando o comando:

```bash
cd src/testes
go test -v
```

Ou podemos rodar o teste automaticamente usando o github actions, que roda o teste a cada push no repositório. O nome da action que realiza os testes é `Teste de Pipeline de Dados` que pode ser acessada [aqui](https://github.com/Inteli-College/2024-T0002-EC09-G02/actions/workflows/test_go.yml)

![Output da pipeline de dados](<../../static/img/testes_go.png>)
