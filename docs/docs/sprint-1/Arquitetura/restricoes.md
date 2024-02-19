---
sidebar_position: 4
slug: '/sprint_1/arquitetura/retricoes'
label: "Diagrama"
---

# Restrições

O projeto a ser desenvolvido durante o módulo 9 do curso de Engenharia de Computação tem como tema IoT e arquitetura em nuvem, com o objetivo de coletar dados de diversos tipos de sensores, processá-los e disponibilizá-los para visualização em um Dashboard. Em um cenário real, enfrenta restrições como apoio financeiro, custo de implantação e custo de mão de obra. No entanto, por ser desenvolvido em um ambiente universitário, as restrições assumem outras formas:

## AWS Academy

O ambiente do AWS Academy é conhecido por seu controle restrito, permitindo apenas a utilização de alguns serviços, e sua operação exige procedimentos manuais. Essas características dificultam a manipulação e a manutenção diária, considerando que as chaves de acesso expiram após quatro horas, assim como a disponibilidade do ambiente.

## Simulação de Sensores

A simulação de sensores pode comprometer a autenticidade dos dados, já que os inputs são criados com base nas informações disponíveis nos datasheets, o que difere dos resultados que seriam obtidos com o uso de sensores reais. Identificar o formato ou tipo de dados transmitidos por cada sensor também apresenta desafios.

## GitHub Actions

A utilização do GitHub Actions para CI/CD apresenta limitações, devido ao tempo de execução restrito e ao número limitado de execuções permitidas. Adicionalmente, algumas ações, como a execução de contêineres Docker, podem ser bloqueadas.

## Linguagem de Programação Go

Go é uma linguagem de programação que apresenta uma curva de aprendizado relativamente íngreme, em parte porque é uma linguagem mais recente com recursos limitados disponíveis. A AWS não oferece suporte nativo para Go, o que pode complicar a integração com seus serviços.

## Linguagem de Programação Python

Python é uma linguagem de programação com uma curva de aprendizado mais acessível, dada sua maior antiguidade e a abundância de recursos disponíveis. No entanto, o gerenciamento de dependências pode ser desafiador, visto que Python conta com múltiplas versões e dependências que podem ser incompatíveis entre si.

## Prova de Conceito

Este projeto visa ser uma prova de conceito, sendo desenvolvido em um ambiente universitário com o intuito de também promover a aprendizagem dos alunos envolvidos na construção da solução.

## Conclusão

As restrições apresentadas acima são desafios que devem ser superados ao longo do desenvolvimento do projeto, e o grupo está ciente de que a solução final pode ser impactada por essas limitações. No entanto, os integrantes do grupo estão comprometidos em superar esses desafios e entregar um projeto de qualidade, que atenda aos requisitos propostos.