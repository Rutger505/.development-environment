#!/bin/bash

docker context create desktop-linux \
  --description "Docker Desktop Linux" \
  --docker "host=unix://$HOME/.docker/desktop/docker.sock"
docker context use desktop-linux

sudo usermod -aG docker "$USER"
