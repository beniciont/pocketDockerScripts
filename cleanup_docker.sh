#!/usr/bin/env bash

# SCRIPT PARA APAGAR TODOS OS CONTAINERES, IMAGES E VOLUMES DO DOCKER.

# Parar todos os contêineres
CONTAINERS=$(docker ps -a -q)
if [ -z "$CONTAINERS" ]; then
    echo "Não há contêineres para parar."
else
    docker stop $CONTAINERS
    echo "Contêineres Parados!"
fi

# Apagar todos os contêineres
CONTAINERS=$(docker ps -a -q)
if [ -z "$CONTAINERS" ]; then
    echo "Não há contêineres para apagar."
else
    docker rm $CONTAINERS
    echo "Contêineres Apagados!"
fi

# Apagar todas as imagens locais
IMAGES=$(docker images -a -q)
if [ -z "$IMAGES" ]; then
    echo "Não há imagens para apagar."
else
    docker rmi $IMAGES
    echo "Imagens Apagadas!"
fi

# Remover todos os volumes
VOLUMES=$(docker volume ls -q)
if [ -z "$VOLUMES" ]; then
    echo "Não há volumes para apagar."
else
    docker volume rm $VOLUMES
    echo "Volumes Apagados!"
fi
