#!/bin/bash
#
# start-stack-sh
#
# inmate40207 ELK Starter launch script
#

# load configuration details
source ../etc/elk-environment.conf

# launch the Docker containers
docker-compose --file $PWD/../docker/gadget/docker-compose.yml up --build -d
