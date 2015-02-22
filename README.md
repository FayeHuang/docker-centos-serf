# docker-centos-serf
    docker run -d -p 2222:22 --name=node1 --hostname=node1.example.local --dns=127.0.0.1 fayehuang/centos-serf
    docker run -d -p 2222:22 --name=node2 --hostname=node2.example.local --dns=127.0.0.1 -e SERF_JOIN_IP=<node1_IP> fayehuang/centos-serf
