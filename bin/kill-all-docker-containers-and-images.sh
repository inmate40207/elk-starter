#!/bin/bash
#
# brute-force delete of all containers and images
#
# gives your Docker instance a fresh, new start
#

docker rm -f $(docker ps -a -q)
docker rmi -f $(docker images -q)
