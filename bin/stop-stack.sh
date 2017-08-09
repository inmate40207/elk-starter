#!/bin/bash
#
# stop-stack.sh
#
# inmate40207 ELK Starter shutdown script
#
# stops the base software stack under docker
#

docker-compose --file $PWD/../docker/gadget/docker-compose.yml down
