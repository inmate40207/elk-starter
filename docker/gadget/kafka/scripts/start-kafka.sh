#!/bin/sh

handle () {
  file=$1
  directive=$2
  value=$3
  if grep -q "$directive" $file; then
#echo    sed -E -i "s/#($directive)=(.*)/\1=$value/g" $file
    echo "replacing:"
    sed -i .bak -e "s/^$directive*=*.*/$directive=$value/; s/^#$directive*=*.*/$directive=$value/" "$file" | grep $directive 
  else
   echo "adding:"
   echo "$directive=$value" >> $file
  fi
}

# standard location for Kafka server config file
CONFIG_FILE=$KAFKA_HOME/config/server.properties

# set directives in the log
handle $CONFIG_FILE advertised.host.name $ADVERTISED_HOST
handle $CONFIG_FILE advertised.port $ADVERTISED_PORT 
handle $CONFIG_FILE log.retention.hours $LOG_RETENTION_HOURS
handle $CONFIG_FILE log.retention.bytes $LOG_RETENTION_BYTES
handle $CONFIG_FILE num.partitions $NUM_PARTITIONS
handle $CONFIG_FILE delete.topic.enable $DELETE_TOPIC_ENABLE

# start Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $CONFIG_FILE

