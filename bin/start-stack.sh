#!/bin/bash
#
# start-stack.sh
#

# load local configuration details
source ../etc/elk-environment.conf

# if the .env file exists, add/change the LOCAL_IP= entry, even if it is commented out
file=$PWD/../docker/gadget/.env
directive=LOCAL_IP
value=$LOCAL_IP
if [ -f $file ]; then
  if grep -q "$directive" $file; then
    sed -i .bak -e "s/^$directive*=*.*/$directive=$value/; s/^#$directive*=*.*/$directive=$value/" "$file" | grep $directive
  else
    echo "$directive=$value" >> $file
  fi
else
  echo "$directive=$value" >> $file
fi

# launch the Docker containers
docker-compose --file $PWD/../docker/gadget/docker-compose.yml up --build -d
