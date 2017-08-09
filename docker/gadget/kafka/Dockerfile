FROM java:openjdk-8-jre
ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.1.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
RUN apt-get update
RUN apt-get install -y zookeeper wget supervisor dnsutils
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean
RUN wget http://apache.mirrors.spacedump.net/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
RUN tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt
RUN rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
ADD scripts/start-kafka.sh /usr/bin/start-kafka.sh
ADD supervisor/kafka.conf supervisor/zookeeper.conf /etc/supervisor/conf.d/
CMD ["supervisord", "-n"]
