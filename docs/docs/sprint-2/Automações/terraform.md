---
sidebar_position: 2
slug: '/sprint_2/arquitetura/terraform'
label: "Terraform"
---
# Terraform

O terraform é uma ferramenta de infraestrutura como código (IaC) que permite a criação, atualização e exclusão de recursos da AWS de forma programática e automatizada. Com o terraform, é possível definir a infraestrutura do projeto em arquivos de configuração, chamados de *scripts*, que são escritos em uma linguagem de domínio específico (DSL) chamada HCL (HashiCorp Configuration Language). Esses *scripts* são então executados pelo terraform, que se encarrega de criar, atualizar e excluir os recursos da AWS conforme definido nos arquivos de configuração.

## Vantagens do Terraform

O terraform oferece diversas vantagens em relação à criação manual de recursos da AWS, tais como:   

**Código como Infraestrutura (IaC)**
- O Terraform permite que você trate sua infraestrutura como código, o que facilita a versionamento, reutilização e compartilhamento entre equipes. Isso promove práticas de desenvolvimento ágeis e seguras.

**Gerenciamento Declarativo**
- Com Terraform, você declara o estado desejado da sua infraestrutura, e o Terraform se encarrega de alcançá-lo. Isso elimina a necessidade de scripts manuais, reduzindo erros e inconsistências.

**Automação de Implantação**
- Terraform automatiza a criação, modificação e destruição de recursos na AWS, tornando o processo de implantação rápido e eficiente.

**Gerenciamento de Configuração**
- Permite gerenciar não apenas recursos da AWS, mas também configurar serviços e aplicações, garantindo que a infraestrutura e as configurações estejam alinhadas.

**Independência de Fornecedores**
- Embora estejamos falando de AWS, o Terraform pode gerenciar recursos em múltiplos provedores de nuvem, permitindo estratégias multi-cloud sem precisar aprender novas ferramentas ou linguagens.

**Módulos Reutilizáveis**
- Terraform incentiva o uso de módulos, que são conjuntos de configurações reutilizáveis, facilitando a padronização e reduzindo a duplicação de código em sua infraestrutura.

**Planejamento e Previsão**
- Antes de aplicar as mudanças, Terraform pode gerar um plano de execução, mostrando o que será alterado, adicionado ou removido. Isso ajuda a evitar surpresas e garante revisões mais seguras.

**Comunidade e Suporte**
- Terraform tem uma comunidade ativa e crescente, o que significa uma grande quantidade de recursos de aprendizado, módulos compartilhados e suporte quando você precisa de ajuda.

**Segurança e Conformidade**
- Ao integrar práticas de revisão de código e testes automatizados com o gerenciamento de infraestrutura, Terraform pode ajudar a garantir a conformidade e a segurança da infraestrutura.

**Escala e Performance**
- Terraform é projetado para lidar com infraestruturas de grande escala, permitindo gerenciar milhares de recursos com facilidade, eficiência e de maneira confiável.

## Estrutura do Projeto

Todos os arquivos de configuração do terraform estão organizados em uma estrutura de diretórios que segue as melhores práticas de organização de código. A estrutura do projeto é composta por:

```
.
├── infrastructure
│   ├── charts
│   │   ├── grafana
│   │   │   └── value.yaml
│   │   └── prometheus
│   │       └── value.yaml
│   ├── terraform
│   │   ├── global
│   │   │   ├── main.tf
│   │   │   ├──  variables.tf
│   │   │   ├── aws-glue.tf
│   │   │   ├── bastion.tf
│   │   │   ├── dynamodb.tf
│   │   │   ├── eks.tf
│   │   │   ├── iot-core.tf
│   │   │   ├── network.tf
│   │   │   ├── s3.tf
│   │   │   ├── sg.tf
│   │   │   └── vpc.tf
│   │   ├── s3
│   │   │   ├── main.tf
│   │   │   └── s3.tf

```
Esses arquivos podem ser encontrados no repositório do projeto [aqui](https://github.com/Inteli-College/2024-T0002-EC09-G02/tree/main/infrastructure). Cada arquivo `.tf` tirando os arquvos `main.tf` e `variables.tf`, se refere a um recurso da AWS que será criado, atualizado ou excluído pelo terraform.

## Arquivos de Configuração
Dentro do diretório `infrastructure/terraform/global`, temos os seguintes arquivos de configuração:
- **main.tf**: Define os recursos da AWS que serão criados, atualizados ou excluídos.
- **variables.tf**: Define as variáveis que serão utilizadas nos arquivos de configuração. Sendo elas:

```env
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["192.168.0.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["192.168.1.0/24"]
}

variable "default_availability_zone" {
  type        = string
  description = "Default availability zone"
  default     = "us-east-1a"
}

variable "lab_role" {
  type        = string
  description = "Lab role"
  default     = "arn:aws:iam::<ID ACCOUNT>:role/LabRole"
}

variable "dynamodb_arn" {
  type        = string
  description = "DynamoDB ARN"
  default     = "arn:aws:dynamodb:us-east-1:<ID ACCOUNT>:table/*"
}

variable "bucket_state" {
  type        = string
  description = "S3 bucket for state Terraform"
  default     = "<BUCKET NAME>"
}

```

**NOTA:** As variáveis `lab_role`, `dynamodb_arn` e `bucket_state` são sensíveis e devem ser configuradas de acordo com o ambiente de execução. Além da variavel `lab_role` que é uma variável do IAM a ser usado, as demais são variáveis de recursos da AWS.


## Comandos Terraform

Para executar os comandos do terraform, é necessário ter o terraform instalado na máquina. Para instalar o terraform, siga as instruções do [site oficial](https://learn.hashicorp.com/tutorials/terraform/install-cli).

Após a instalação, é possível executar os seguintes comandos:

- **terraform init**: Inicializa o diretório de trabalho e baixa os plugins necessários para o projeto.
- **terraform validate**: Verifica a sintaxe dos arquivos de configuração.
- **terraform fmt**: Formata os arquivos de configuração de acordo com as boas práticas.
- **terraform plan**: Gera e exibe um plano de execução, mostrando o que será alterado, adicionado ou removido.
- **terraform apply**: Aplica as mudanças descritas nos arquivos de configuração.
- **terraform destroy**: Destroi todos os recursos criados pelo terraform.

## Pipeline de Integração Contínua e Entrega Contínua (CI/CD)
Durante a sprint 2, o grupo implementou um pipeline de integração contínua para automatizar a execução dos comandos do terraform. O pipeline foi implementado utilizando a ferramenta de CI/CD, o Github Actions, que é integrada ao repositório do projeto.

- **Pipeline: Terraform - Up S3 State**: Este pipeline é responsável por criar o bucket S3 que armazenará o estado do terraform. O estado do terraform é um arquivo que armazena o estado atual da infraestrutura, permitindo que o terraform saiba o que foi criado, atualizado ou excluído. O bucket S3 é um recurso da AWS que armazena objetos, como arquivos e pastas, e é utilizado para armazenar o estado do terraform `terraform.tfstate` e backups `terraform.tfstate.backup`.
  
![alt text](<../../../static/img/terraform - s3.png>)

- **Pipeline: Terraform - Up Infrastructure**: Este pipeline é responsável por criar a infraestrutura do projeto. Ele executa os comandos iniciais de configuração do AWS CLI, posteriormente, os comandos `terraform init`, `terraform validate`, `terraform fmt`, `terraform plan` e `terraform apply` para inicializar o diretório de trabalho, verificar a sintaxe dos arquivos de configuração, formatar os arquivos de configuração, gerar um plano de execução e aplicar as mudanças descritas nos arquivos de configuração, respectivamente.
  
![alt text](<../../../static/img/terraform - up.png>)

- **Pipeline: Terraform - Down Infrastructure**: Este pipeline é responsável por destruir a infraestrutura do projeto. Ele executa os comandos `terraform destroy` para destruir todos os recursos criados pelo terraform.
  
![alt text](<../../../static/img/terraform - down.png>)

## Conclusão

O terraform pode ser uma ferramenta poderosa para gerenciar a infraestrutura da AWS de forma programática e automatizada. Ele oferece diversas vantagens em relação à criação manual de recursos da AWS, tais como: código como infraestrutura (IaC), gerenciamento declarativo, automação de implantação, gerenciamento de configuração, independência de fornecedores, módulos reutilizáveis, planejamento e previsão, comunidade e suporte, segurança e conformidade, escala e performance. Além disso, o terraform permite a criação de pipelines de integração contínua e entrega contínua (CI/CD) para automatizar a execução dos comandos do terraform. Com isso, é possível garantir a consistência, segurança e eficiência da infraestrutura da AWS, facilitando tanto a implementação quanto a manutenção.
