FROM centos:6

COPY CentOS-Base.repo /etc/yum.repos.d/
COPY scripts/ambari-hdp-1.repo /etc/yum.repos.d/
COPY scripts/ambari.repo /etc/yum.repos.d/

RUN yum install -y sudo wget openssl-devel unzip krb5-server krb5-libs krb5-workstation ipa-client oddjob-mkhomedir openssh  ipa-admintools
RUN yum install -y sudo wget ambari-agent ambari-metrics-* ambari-logsearch-* hadoop* zookeeper* hive* phoenix_* ranger* storm_* kafka_* pig_* datafu_* spark* livy* zeppelin* falcon_* oozie_* smartsense* druid* superset* lzo snappy-devel rpcbind ambari-server lucidworks-hdpsearch ambari-infra-solr-client
COPY scripts/start.sh /start.sh
RUN mkdir -p /usr/share/java/
RUN curl -k 'https://nexus/repository/files/postgresql-42.2.2.jar' -o /usr/share/java/postgresql-42.2.2.jar
RUN ambari-server setup --jdbc-db postgres --jdbc-driver=/usr/share/java/postgresql-42.2.2.jar
RUN ambari-server setup --database=postgres --databasehost=postgres.lbg.dev --databaseport=5432 --databasename=ambari --postgresschema=ambari  --databaseusername=ambari --databasepassword=dev --silent
COPY scripts/serverstart.sh /serverstart.sh
COPY scripts/HDP-2.6.4.0-91.xml /tmp
RUN curl http://public-repo-1.hortonworks.com/HDP-SOLR/hdp-solr-ambari-mp/solr-service-mpack-2.2.9.tar.gz -o /tmp/solr-service-mpack-2.2.9.tar.gz
RUN ambari-server install-mpack --mpack=/tmp/solr-service-mpack-2.2.9.tar.gz
RUN authconfig --enablemkhomedir --update
COPY scripts/resolv.conf /etc/resolv.conf.bak
