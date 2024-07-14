#!/usr/bin/env bash

# SCRIPT PARA INSTALAR O DOCKER NO UBUNTU

# Função para imprimir uma linha com o caractere especificado
print_line() {
    local char="$1"
    local length="$2"
    printf '%*s\n' "$length" | tr ' ' "$char"
}

# Função para imprimir o texto centralizado em uma caixa
print_boxed_text() {
    local text="$1"
    local text_length=${#text}
    local box_width=$((text_length + 4))
    
    print_line '-' "$box_width"
    echo "| $text |"
    print_line '-' "$box_width"
}

# Pergunta para o usuário confirmar antes de continuar
read -p "Este script irá instalar o Docker. Deseja continuar? (s/n): " answer

# Verifica a resposta do usuário
if [[ "$answer" != "s" ]]; then
    echo "Operação cancelada."
    exit 1
fi

# Atualiza a lista de pacotes
sudo apt-get update > /dev/null
echo "Lista de pacotes atualizada com sucesso!"

# Instala o Docker CE, Docker CLI, Containerd.io, Docker Buildx Plugin
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin > /dev/null
echo "Docker CE, Docker CLI, Containerd.io, Docker Buildx Plugin foram instalados com sucesso!"

# Add user to docker group (opcional, para permitir que o usuário atual execute comandos Docker sem sudo)
sudo usermod -aG docker $USER > /dev/null
echo "Seu usuário foi adicionado ao grupo docker."
echo " --------------------------------------------------------------------------------------- "
echo " | Docker intalado com sucesso, tente criar um conteiner com: 'docker run hello-world' | "
echo " --------------------------------------------------------------------------------------- "
