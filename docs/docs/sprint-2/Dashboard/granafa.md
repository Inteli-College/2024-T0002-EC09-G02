---
sidebar_position: 1
slug: '/sprint_2/dashboard/grafana'
label: "Grafana e Prometheus"
---
# Grafana e Prometheus

O Grafana e o Prometheus são ferramentas essenciais para a visualização e monitoramento de dados. O Grafana é uma plataforma de análise e visualização de métricas, enquanto o Prometheus é um sistema de monitoramento e alerta. Ambos são amplamente utilizados em ambientes de nuvem e são altamente integrados com a AWS.

## Grafana

O Grafana é uma plataforma de análise e visualização de métricas, que permite criar, explorar e compartilhar dashboards e dados. O Grafana oferece suporte a uma ampla variedade de fontes de dados, incluindo Prometheus, AWS CloudWatch, Elasticsearch, InfluxDB, MySQL, PostgreSQL, e muitas outras. Além disso, o Grafana oferece suporte a plugins, o que permite estender suas funcionalidades e integrá-lo com outros sistemas.

### Vantagens do Grafana

O Grafana oferece diversas vantagens em relação a outras ferramentas de visualização de métricas, tais como:
- **Suporte a Diversas Fontes de Dados**: O Grafana oferece suporte a uma ampla variedade de fontes de dados, o que permite integrá-lo com sistemas e serviços de monitoramento.
- **Flexibilidade e Customização**: O Grafana oferece uma interface intuitiva e flexível para a criação e customização de dashboards, permitindo criar visualizações personalizadas e adaptadas às necessidades do usuário.
- **Integração com Outras Ferramentas**: O Grafana oferece suporte a plugins, o que permite estender suas funcionalidades e integrá-lo com outros sistemas, como Prometheus, AWS CloudWatch, Elasticsearch e muitas outras.
- **Comunidade Ativa e Suporte**: O Grafana tem uma comunidade ativa e crescente, o que significa uma grande quantidade de recursos de aprendizado, plugins compartilhados e suporte quando você precisa de ajuda.
- **Escalabilidade e Desempenho**: O Grafana é projetado para lidar com grandes volumes de dados e oferece suporte a ambientes de nuvem, o que permite escalar e dimensionar a plataforma conforme necessário.
- **Open Source e Licença Apache 2.0**: O Grafana é um software de código aberto e é distribuído sob a licença Apache 2.0, o que significa que é gratuito para uso comercial e não comercial.

## Prometheus

O Prometheus é um sistema de monitoramento e alerta, que coleta métricas de sistemas e serviços e armazena essas métricas em um banco de dados de séries temporais. O Prometheus oferece suporte a uma ampla variedade de fontes de dados, incluindo AWS CloudWatch, JMX, StatsD, e muitas outras. Além disso, o Prometheus oferece suporte a alertas, o que permite definir regras de alerta com base nas métricas coletadas.

### Vantagens do Prometheus

O Prometheus oferece diversas vantagens em relação a outras ferramentas de monitoramento, tais como:
- **Coleta de Métricas de Sistemas e Serviços**: O Prometheus coleta métricas de sistemas e serviços, incluindo CPU, memória, disco, rede, e muitas outras, o que permite monitorar o desempenho e a disponibilidade dos sistemas e serviços.
- **Armazenamento de Métricas em Banco de Dados de Séries Temporais**: O Prometheus armazena as métricas coletadas em um banco de dados de séries temporais, o que permite consultar e analisar as métricas ao longo do tempo.
- **Suporte a Alertas**: O Prometheus oferece suporte a alertas, o que permite definir regras de alerta com base nas métricas coletadas, e notificar os usuários quando as regras são acionadas.

## Integração do Grafana com o Prometheus

O Grafana e o Prometheus são altamente integrados, o que permite visualizar e analisar as métricas coletadas pelo Prometheus por meio de dashboards personalizados. O Grafana oferece suporte nativo ao Prometheus, o que significa que é possível configurar o Prometheus como uma fonte de dados no Grafana e criar dashboards com base nas métricas coletadas pelo Prometheus.

### Vantagens da Integração

A integração do Grafana com o Prometheus oferece diversas vantagens, tais como:
- **Visualização e Análise de Métricas**: O Grafana oferece uma interface intuitiva e flexível para a visualização e análise de métricas coletadas pelo Prometheus, o que permite criar dashboards personalizados e adaptados às necessidades do usuário.
- **Alertas e Notificações**: O Grafana oferece suporte a alertas e notificações, o que permite definir regras de alerta com base nas métricas coletadas pelo Prometheus, e notificar os usuários quando as regras são acionadas.

## Motivo de Uso

O grupo decidiu adotar o Grafana e o Prometheus para visualização e análise dos dados coletados. Essa escolha foi motivada pelo robusto suporte de integração via SDK com a AWS, facilitando a coleta de métricas de sistemas e serviços. A integração se beneficia da autoconfiguração de acesso (não havendo a necessidade de cadastrar as credencias da AWS), um recurso particularmente vantajoso no contexto do EKS (Elastic Kubernetes Service). Como o EKS gerencia os pods, a instalação do Grafana e do Prometheus diretamente sobre ele elimina a necessidade de configurações manuais de acesso. Isso é possível porque o próprio EKS automatiza a configuração de acesso, simplificando significativamente o processo de implementação e gestão dessas ferramentas de monitoramento. 

## Exemplo de Dashboard

O dashboard a seguir é um exemplo de como as métricas coletadas pelo Prometheus podem ser visualizadas e analisadas por meio do Grafana. O dashboard inclui gráficos de séries temporais, tabelas, e outros tipos de visualizações, que permitem monitorar o desempenho e a disponibilidade dos pods e serviços do cluster do Amazon EKS.

![alt text](../../../static/img/monitoramento-eks.png)


## Demo do Grafana e Prometheus

A seguir, um vídeo demonstrativo de como o Grafana e o Prometheus podem ser utilizados para visualizar e analisar métricas coletadas de sistemas e serviços. O vídeo inclui uma demonstração de como configurar um novo data source no Grafana, criar um novo dashboard, e adicionar visualizações de métricas coletadas pelo Prometheus, incluindo o dashboard construido para demonstração de dados de sensores da região norte.

<iframe width="560" height="315" src="https://www.youtube.com/embed/j9ltPLv8gIc" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
