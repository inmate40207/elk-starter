#!/bin/bash
#
# usage: ./copy-down.sh [container_name] [path/file] 

docker cp $1:$2 .
