#!/bin/bash
#
# usage: ./copy-file-down-from-container.sh [container_name] [path/file] 
#

docker cp $1:$2 .
