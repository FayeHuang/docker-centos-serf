FROM fayehuang/centos-supervisor
MAINTAINER FayeHuang

ENV SERF_HOME /root/serf
RUN mkdir $SERF_HOME && mkdir $SERF_HOME/bin && mkdir $SERF_HOME/etc 

RUN yum install -y wget unzip curl dnsmasq && yum clean all
# slove "dnsmasq: setting capabilities failed: Operation not permitted"
# refs:https://github.com/nicolasff/docker-cassandra/issues/8
RUN echo "user=root" >> /etc/dnsmasq.conf

RUN wget https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip -P /tmp
RUN unzip /tmp/0.6.4_linux_amd64.zip -d $SERF_HOME/bin && rm -f /tmp/0.6.4_linux_amd64.zip

COPY serf_init.sh $SERF_HOME/bin/serf_init.sh
COPY dnsmasq.json $SERF_HOME/etc/dnsmasq.json
COPY dnsmasq.sh $SERF_HOME/bin/dnsmasq.sh
RUN chmod +x $SERF_HOME/bin/*

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 22
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

 
