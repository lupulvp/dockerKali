#!/bin/bash

CPUCOUNT=2 # 2 CPUs
MEMORY=4g  # 4 GB of RAM
USERNAME=kaliuser #update
PASSWORD=kalipass #update


docker build -t kali-linux-img \
        --build-arg USERNAME=$USERNAME \
        --build-arg PASSWORD=$PASSWORD \
        .

docker create   --name kali \
        --network bridge --memory=$MEMORY --cpus=$CPUCOUNT \
        -p 3389:3389 -p 22:22 \
        -t -v kaliuser_data:/home/kaliuser \
        kali-linux-img