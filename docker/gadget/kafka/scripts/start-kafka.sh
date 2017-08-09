#!/bin/sh

# set advertised host for clients
echo "advertised host: $ADVERTISED_HOST"
if grep -q "^advertised.host.name" $KAFKA_HOME/config/server.properties; then
    sed -r -i "s/#(advertised.host.name)=(.*)/\1=$ADVERTISED_HOST/g" $KAFKA_HOME/config/server.properties
else
    echo "advertised.host.name=$ADVERTISED_HOST" >> $KAFKA_HOME/config/server.properties
fi

# set advertised port for clients
echo "advertised port: $ADVERTISED_PORT"
if grep -q "^advertised.port" $KAFKA_HOME/config/server.properties; then
    sed -r -i "s/#(advertised.port)=(.*)/\1=$ADVERTISED_PORT/g" $KAFKA_HOME/config/server.properties
else
    echo "advertised.port=$ADVERTISED_PORT" >> $KAFKA_HOME/config/server.properties
fi

# set ZooKeeper chroot if set
if [ ! -z "$ZK_CHROOT" ]; then
    until /usr/share/zookeeper/bin/zkServer.sh status; do
      sleep 0.1
    done
    echo "create /$ZK_CHROOT \"\"" | /usr/share/zookeeper/bin/zkCli.sh || {
        echo "can't create chroot in zookeeper, exit"
        exit 1
    }
    sed -r -i "s/(zookeeper.connect)=(.*)/\1=localhost:2181\/$ZK_CHROOT/g" $KAFKA_HOME/config/server.properties
fi

# set topic retention time if set
if [ ! -z "$LOG_RETENTION_HOURS" ]; then
    echo "log retention hours: $LOG_RETENTION_HOURS"
    sed -r -i "s/(log.retention.hours)=(.*)/\1=$LOG_RETENTION_HOURS/g" $KAFKA_HOME/config/server.properties
fi

# set topic retention bytes if set
if [ ! -z "$LOG_RETENTION_BYTES" ]; then
    echo "log retention bytes: $LOG_RETENTION_BYTES"
    sed -r -i "s/#(log.retention.bytes)=(.*)/\1=$LOG_RETENTION_BYTES/g" $KAFKA_HOME/config/server.properties
fi

# set number of topic partitions if set
if [ ! -z "$NUM_PARTITIONS" ]; then
    echo "default number of partition: $NUM_PARTITIONS"
    sed -r -i "s/(num.partitions)=(.*)/\1=$NUM_PARTITIONS/g" $KAFKA_HOME/config/server.properties
fi

# enable auto create topics if set
if [ ! -z "$AUTO_CREATE_TOPICS" ]; then
    echo "auto.create.topics.enable: $AUTO_CREATE_TOPICS"
    echo "auto.create.topics.enable=$AUTO_CREATE_TOPICS" >> $KAFKA_HOME/config/server.properties
fi

# start Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
