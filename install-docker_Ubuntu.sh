#!/usr/bin/env bash

# Atualiza a lista de pacotes
sudo apt-get update

# Instala o Docker CE, Docker CLI, Containerd.io, Docker Buildx Plugin
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin

# Add user to docker group (opcional, para permitir que o usuário atual execute comandos Docker sem sudo)
sudo usermod -aG docker $USER

# Mensagem de conclusão
echo "Docker CE, Docker CLI, Containerd.io, Docker Buildx Plugin foram instalados com sucesso, também foi adicionado o seu usuário ao grupo docker."