#!/usr/bin/env bash

#SCRIPT PARA REMOVER O DOCKER TOTALMENTE DO SITEMA. !!!CUIDADO!!! 

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
read -p "Este script irá remover totalmente o Docker, Contêineres, Imagens e Volumes e Redes, Deseja continuar? (s/n): " answer

# Verifica a resposta do usuário
if [[ "$answer" != "s" ]]; then
    echo "Operação cancelada."
    exit 1
fi

# Parar todos os contêineres em execução
sudo docker stop $(sudo docker ps -q) > /dev/null 2>&1
echo "Todos os contêineres Docker em execução foram parados."

# Remover todos os contêineres
sudo docker rm $(sudo docker ps -aq) > /dev/null 2>&1
echo "Todos os contêineres Docker foram removidos."

# Remover todas as imagens
sudo docker rmi $(sudo docker images -q) > /dev/null 2>&1
echo "Todas as imagens Docker foram removidas."

# Remover todos os volumes
sudo docker volume rm $(sudo docker volume ls -q) > /dev/null 2>&1
echo "Todos os volumes Docker foram removidos."

# Remover todas as redes
sudo docker network rm $(sudo docker network ls -q) > /dev/null 2>&1
echo "Todas as redes Docker foram removidas."

# Remover pacotes do Docker
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io > /dev/null 2>&1
echo "Pacotes do Docker foram removidos."

# Remover dependências do Docker que não são mais necessárias
sudo apt-get autoremove -y --purge docker-ce docker-ce-cli containerd.io > /dev/null 2>&1
echo "Dependências do Docker foram removidas."

# Remover diretórios do Docker
sudo rm -rf /var/lib/docker > /dev/null 2>&1
sudo rm -rf /var/lib/containerd > /dev/null 2>&1
echo "Diretórios do Docker foram removidos."

# Limpar arquivos de configuração remanescentes
sudo rm -rf /etc/docker > /dev/null 2>&1
sudo rm -rf /etc/systemd/system/docker.service > /dev/null 2>&1
sudo rm -rf /etc/systemd/system/docker.socket > /dev/null 2>&1
echo "Arquivos de configuração remanescentes do Docker foram removidos."

# Recarregar configuração do systemd
sudo systemctl daemon-reload > /dev/null 2>&1
echo "Configuração do systemd foi recarregada."

# Remover grupo Docker se existir
if getent group docker > /dev/null 2>&1; then
    sudo groupdel docker > /dev/null 2>&1
    echo "Grupo Docker foi removido."
fi
echo "-----------------------------------------------------"
echo "| O Docker foi completamente removido do seu sistema.|"
echo "-----------------------------------------------------"
