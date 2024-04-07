# Kafka Producer for IoT Events

Este documento fornece uma visão geral e um guia sobre como configurar e executar um script Python para publicar mensagens em um tópico do Apache Kafka usando as bibliotecas `confluent_kafka` e `python-dotenv`.

## Visão Geral

O script Python descrito aqui consome mensagens de um evento (simulando, por exemplo, mensagens provenientes de sensores IoT) e publica essas mensagens em um tópico específico do Apache Kafka. Isso é feito através da configuração de um produtor Kafka, que é autenticado e configurado com detalhes fornecidos através de variáveis de ambiente.

## Pré-Requisitos

Para executar este script, você precisará ter Python instalado em seu ambiente. Além disso, as seguintes bibliotecas Python são necessárias:

- `confluent_kafka`: para interação com o Apache Kafka.
- `python-dotenv`: para carregar as variáveis de ambiente do arquivo `.env`.

Você pode instalar estas bibliotecas usando o seguinte comando:

```sh
pip install confluent_kafka python-dotenv
```

## Configuração

Antes de executar o script, você deve configurar as variáveis de ambiente necessárias. Crie um arquivo `.env` no mesmo diretório do seu script com o seguinte conteúdo:

```
BOOTSTRAP_SERVERS='pkc-p11xm.us-east-1.aws.confluent.cloud:9092'
KAFKA_TOPIC='regions'
SASL_USERNAME='WXZ6MQ5JRCQW462O'
SASL_PASSWORD='RaEM2xCydD3orhqHBVH2mdWa617nhQAFKSQ3RCuI4tmohMmNk1Rp9gtgH2muJk+l'
```

Estas variáveis são usadas para configurar a conexão com o Apache Kafka, incluindo os servidores bootstrap, o tópico a ser utilizado, o nome de usuário e a senha para autenticação SASL.

## Uso

Para usar o script, simplesmente execute-o com Python. O script espera um evento com registros a serem processados e publicados no Kafka. Você pode simular um evento para teste ou integrá-lo em um ambiente de produção onde eventos são gerados dinamicamente.

O script processa cada registro no evento, converte as mensagens para o formato esperado pelo Kafka (bytes), e publica no tópico configurado. Cada mensagem enviada é acompanhada de um callback para reportar o sucesso ou falha na entrega da mensagem.

## Estrutura do Código

A função principal `lambda_handler` é responsável por processar o evento. Ela inicializa o produtor Kafka com as configurações especificadas, itera sobre os registros no evento, prepara e envia as mensagens. Após o envio de todas as mensagens, o script aguarda a conclusão de todas as operações pendentes com `producer.flush()`.

## Considerações Finais

Este guia oferece um ponto de partida para integrar aplicações Python com o Apache Kafka. Para usos em produção, considere implementar tratamento de erros adequado, logging e monitoramento para garantir a resiliência e a eficácia da sua solução.