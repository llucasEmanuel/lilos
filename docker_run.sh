#!/bin/zsh

docker run --rm -it \
  -v "$PWD:/data" \
  qemu-img-runner \
  -drive file=kernel.img,format=raw -nographic