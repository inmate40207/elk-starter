#!/bin/bash
#
# stop-stack.sh
#
# stops the base software stack under docker
#

docker-compose --file $PWD/../docker/gadget/docker-compose.yml down
