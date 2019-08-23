#!/bin/bash
set -ev
docker-compose up -d
docker pull gjyoung1974/radtest

# Wait for MySQL to boot
sleep 15
docker-compose ps
docker run -it --rm --network docker-freeradius_backend gjyoung1974/radtest radtest testing password freeradius 2 testing123
