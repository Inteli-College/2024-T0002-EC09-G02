# ponderada7mod9

## Introdução

Este repositório contém a quinta ponderada do módulo 9 do curso de engenharia da computação do Inteli. O objetivo é integrar o sistema de publicação pub-sub desenvolvido na ponderada 3. Foi utilizado o metabase para a visualização dos dados.

## Como rodar

Primeiramente é necessário rodar o container do metabase. Para isso, execute o seguinte comando:

```bash
docker run -d -p 3000:3000 -v $(pwd)/db.db:/db.db --name metabase metabase/metabase
```

Após isso, é necessário rodar o pacote go do projeto. Para isso, execute o seguinte comando:

```bash
go run *.go
```

Vale ressaltar que multithreading é utilizado para que o publisher e o subscriber rodem simultaneamente. Para isso, é necessário que o sistema operacional suporte multithreading.

## Vídeo

O vídeo da apresentação da ponderada pode ser encontrado no seguinte link: [Vídeo](https://youtu.be/eGAv7Lp_Jj8)
