#!/bin/bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER

newgrp docker

#!/bin/bash

# Criar arquivo com múltiplas linhas usando cat e here-document
cat > docker-compose.yml <<EOL
version: '3.8'
services:
  metabase:
    image: metabase/metabase:latest
    environment:
      MB_DB_TYPE: postgres
      MB_DB_DBNAME: postgres
      MB_DB_PORT: "5432"
      MB_DB_USER: postgres
      MB_DB_PASS: postgres123
      MB_DB_HOST: prod-db.c5g8ceig88m3.us-east-1.rds.amazonaws.com
    ports:
      - "80:3000"
EOL

docker compose up -d