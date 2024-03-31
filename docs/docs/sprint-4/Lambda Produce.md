---
sidebar_position: 4
slug: 'Lambda Produce'
---

# Lambda Produce

O AWS Lambda é um serviço de computação sem servidor que permite executar código em resposta a eventos. Ele é altamente escalável e pode ser usado para processar eventos em tempo real, como a ingestão de dados de um tópico do Confluent Cloud. Neste documento, vamos explorar como o AWS Lambda pode ser usado para produzir dados em um tópico do Confluent Cloud.

## Implementação da Função Lambda

A configuração de uma função Lambda para produzir dados em um tópico do Confluent Cloud envolve a integração com o Confluent Cloud e a definição de um handler que processa os eventos recebidos. Aqui está um exemplo básico de como isso pode ser feito em Python:

```python
from confluent_kafka import Producer
import json
from dotenv import load_dotenv
import os

# Carrega variáveis de ambiente
load_dotenv()

def lambda_handler(event, context):
    # Configuração do Kafka Producer
    kafka_conf = {
        'bootstrap.servers': os.getenv('BOOTSTRAP_SERVERS'),
        'security.protocol': 'SASL_SSL',
        'sasl.mechanisms': 'PLAIN',
        'sasl.username': os.getenv('SASL_USERNAME'),
        'sasl.password': os.getenv('SASL_PASSWORD')
    }

    producer = Producer(kafka_conf)
    topic = os.getenv('KAFKA_TOPIC')

    def delivery_report(err, msg):
        if err is not None:
            print(f'Message delivery failed: {err}')
        else:
            print(f'Message delivered to {msg.topic()} [{msg.partition()}]')

    # Processa as mensagens recebidas do SQS
    for record in event['Records']:
        message = json.dumps(record['body']).encode('utf-8')
        producer.produce(topic, message, callback=delivery_report)
    
    producer.flush()

    return {
        'statusCode': 200,
        'body': json.dumps('Mensagens enviadas para o Kafka com sucesso!')
    }
```

Neste exemplo, a função Lambda recebe eventos do SQS, processa as mensagens recebidas e as envia para um tópico do Confluent Cloud usando o Kafka Producer. Certifique-se de configurar as variáveis de ambiente corretamente para a conexão com o Confluent Cloud.

## Infraestrutura com Terraform

Assim como as demais partes da arquitetura, a infraestrutura necessária para a função Lambda pode ser provisionada com o Terraform. Isso inclui a definição da função Lambda, a fila SQS, e o repositório ECR. Aqui está um esboço básico do que precisaria ser incluído no seu arquivo Terraform:

```hcl
# Definição do provider AWS
provider "aws" {
  region = var.aws_region
}

# Criação do repositório ECR
resource "aws_ecr_repository" "kafka_listener_repo" {
  name = "kafka-listener-repo"
}

# Criação da função Lambda (exemplo básico)
resource "aws_lambda_function" "kafka_listener" {
  function_name = "KafkaListenerLambdaFunction"
}
```

Os detalhes exatos da configuração do Terraform estão presentes na pasta `infrastructure/terraform/global` do repositório do projeto. Certifique-se de ajustar as configurações conforme as necessidades do seu ambiente.

### GitHub Actions para Build e Deploy

Para automatizar o processo de build e deploy da função Lambda, o grupo utilizou o GitHub Actions, que permite a execução de workflows de CI/CD diretamente no repositório do GitHub. Aqui está um exemplo de como isso foi feito:

#### Workflow - Build

No arquivo `.github/workflows/build-lambda.yml`, o grupo definiu um workflow para build da imagem Docker da função Lambda, dessa forma, podemos testar se a função está funcionando corretamente antes de fazer o deploy:

```yaml
jobs:
  build-lambda:
    name: Build Image
    runs-on: ubuntu-latest

    steps:
      - name: Check out code
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ env.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ env.AWS_SECRET_ACCESS_KEY }}
          aws-session-token: ${{ env.AWS_SESSION_TOKEN }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build Lambda Image
        working-directory: ./src/lambda/kafka-listener/src
        run: |
          docker build -t lambda_kafka_listener .
          docker run -d -p 8080:80 lambda_kafka_listener:latest
```

#### Workflow - Deploy

No arquivo `.github/workflows/deploy-lambda.yml`, o grupo definiu um workflow para deploy da função Lambda no ambiente do ECR:

```yaml
jobs:
  deploy-lambda:
    name: Deploy to EKS
    runs-on: ubuntu-latest
    needs: build-lambda

    steps:
      - name: Check out code
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ env.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ env.AWS_SECRET_ACCESS_KEY }}
          aws-session-token: ${{ env.AWS_SESSION_TOKEN }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Set up .env file
        working-directory: ./src/lambda/kafka-listener/src
        run: |
          echo "BOOTSTRAP_SERVERS"=${{secrets.BOOTSTRAP_SERVERS }}>> .env
          echo "KAFKA_TOPIC"=${{secrets.KAFKA_TOPIC }}>> .env
          echo "BOOTSTRAP_SERVERS"=${{secrets.BOOTSTRAP_SERVERS }}>> .env
          echo "SASL_USERNAME"=${{secrets.SASL_USERNAME }}>> .env
          echo "SASL_PASSWORD"=${{secrets.SASL_PASSWORD }}>> .env


      - name: Deploy Kafka Listener to ECR
        working-directory: ./src/lambda/kafka-listener/src
        env:
          ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
          ECR_REPOSITORY: ${{ env.ECR_REPOSITORY_NAME }}

        run: |
          docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:latest .
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:latest

```

#### Workflow - Update Lambda

No arquivo `.github/workflows/update-lambda.yml`, o grupo definiu um workflow para atualizar a função Lambda no ambiente do AWS Lambda:

```yaml
jobs:
  update-lambda:
    name: Update Lambda
    runs-on: ubuntu-latest
    needs: deploy-lambda

    steps:
      - name: Check out code
        uses: actions/checkout@v2

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ env.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ env.AWS_SECRET_ACCESS_KEY }}
          aws-session-token: ${{ env.AWS_SESSION_TOKEN }}
          aws-region: ${{ env.AWS_REGION }}
      
      - name: Fetch AWS Account ID and set as env variable
        run: echo "AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)" >> $GITHUB_ENV

      - name: Update Lambda
        working-directory: ./src/lambda/kafka-listener/src
        env:
          ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
          ECR_REPOSITORY: ${{ env.ECR_REPOSITORY_NAME }}
        run: |
          aws lambda update-function-code --function-name KafkaListenerLambdaFunction --image-uri $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/kafka-listener-repo:latest 
```

Dessa forma, o grupo conseguiu automatizar o processo de build e deploy da função Lambda, garantindo que as atualizações fossem aplicadas de forma consistente e segura.

### Variáveis de Ambiente

As variáveis de ambiente são essenciais para configurar a função Lambda corretamente. Elas incluem informações como as credenciais de acesso ao Confluent Cloud, o tópico do Kafka, e outras configurações específicas da aplicação. Aqui está um exemplo de como essas variáveis podem ser configuradas no GitHub Actions:

```yaml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_SESSION_TOKEN: ${{ secrets.AWS_SESSION_TOKEN }}
  AWS_REGION: 'us-east-1'
  BOOTSTRAP_SERVERS: ${{ secrets.BOOTSTRAP_SERVERS }}
  KAFKA_TOPIC: 'my-topic'
  SASL_USERNAME: ${{ secrets.SASL_USERNAME }}
  SASL_PASSWORD: ${{ secrets.SASL_PASSWORD }}
```


## Conclusão

Embora a função Lambda represente apenas um elemento da arquitetura geral, ela é essencial para a integração entre microsserviços, promovendo uma comunicação assíncrona eficiente e facilitando o intercâmbio de mensagens entre diferentes partes da aplicação. A implementação de containers Docker para a função Lambda, juntamente com sua integração ao GitHub Actions, possibilitou a automação completa dos processos de build e deploy. Essa abordagem não apenas prepara o caminho para uma futura implementação em instâncias EC2, mas também simplifica os testes locais, elevando a eficiência e a flexibilidade do desenvolvimento.