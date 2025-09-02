#!/bin/zsh

KERNEL_IMG_PATH=./kernel.img

if [ ! -f "$KERNEL_IMG_PATH" ] 
then
    echo "ERRO: Imagem do kernel não encontrada" >&2
    exit 1
fi

docker build -t qemu-img-runner ./qemu_docker

echo "Build concluído com sucesso!"