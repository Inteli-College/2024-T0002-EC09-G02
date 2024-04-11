---
sidebar_position: 8
slug: '/sprint_5/Demo final'
label: "Demo"
---
# Demo final
Bem-vindo à nossa demo final, onde você terá a oportunidade de ver nossa pipeline de dados em pleno funcionamento! Nesta demonstração, apresentaremos um vídeo que mostra todos os componentes da nossa pipeline trabalhando em conjunto para coletar, processar e visualizar dados de poluição sonora e de gases.

## Vídeo da Pipeline em Ação
Assista ao vídeo abaixo para ver nossa pipeline de dados em ação. Você será levado por todo o processo, desde a geração e publicação dos dados até sua visualização em um dashboard interativo.

[Vídeo de demonstração](https://github.com/Inteli-College/2024-T0002-EC09-G02/assets/99260684/9bd6c61d-66dc-4651-beb7-18d9acb0fc77)

## Explorando os Dados no Metabase
Após assistir ao vídeo, convidamos você a explorar os dados coletados em nosso dashboard interativo no Metabase. O Metabase oferece uma interface intuitiva e poderosa para visualizar e analisar dados em tempo real.

[Acesse o dashboard no Metabase](http://metabase-load-balancer-465771358.us-east-1.elb.amazonaws.com/public/dashboard/6c5c5c87-f215-42ea-ba72-6829a20302da)

## Como rodar

### Configuração Inicial:

1. Clone o repositório do projeto para sua máquina local
2. Inicialize o Módulo Go: Navegue até o diretório do projeto e inicialize o módulo Go:
```
go mod init 
go mod tidy
```

### Configuração do HiveMQ

1. Acesse o site do HiveMQ e crie um broker, protegendo-o com usuário e senha de permissão administrativas.

### Configure o Publisher
1. Abra o arquivo publisher.go no diretório do projeto.
2. Substitua os campos HiveMQUsername e HiveMQPassword com as credenciais da sua conta HiveMQ.

### Configuração do Kafka
1. Crie um cluster no Confluent Kafka seguindo as instruções fornecidas pela plataforma.

### Configuração do MongoDB
1. Crie uma Database no MongoDB
2. Acesse seu servidor MongoDB e crie uma nova database para a pipeline de dados.
3. Configure um sink connector no Confluent Kafka para enviar os dados do tópico para a database MongoDB.

### Configuração na AWS:
1. Crie uma instância EC2 na AWS e configure um grupo de autoscaling para gerenciar a escalabilidade.
2. Configure um load balancer para distribuir o tráfego entre as instâncias EC2.
3. Instale o Docker na instância EC2 e execute um contêiner do Metabase.
4. Configure o Metabase para se conectar à database MongoDB como fonte de dados.

### Execução da Pipeline:

No diretório do projeto, execute o comando para iniciar o generator e gerar os valores simulados de dados:
 
```
go run generator.go
```

No mesmo diretório, execute o comando para iniciar o publisher e publicar os dados gerados no HiveMQ:

```
go run publisher.go
```

Com esses passos, você configurará e executará a pipeline de dados completa, desde a geração dos dados simulados até a visualização no Metabase. Certifique-se de seguir todas as etapas com cuidado e de configurar corretamente as credenciais e conexões necessárias.
