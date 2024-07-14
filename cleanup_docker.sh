#!/usr/bin/env bash

# Parar todos os contêineres
docker stop $(docker ps -a -q)

# Apagar todos os contêineres
docker rm $(docker ps -a -q)

# Apagar todas as imagens locais
docker rmi $(docker images -a -q)

# Remover todos os volumes
docker volume rm $(docker volume ls -q)
