FROM centos:6

ARG AMBARI_REPO_URL='http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo'
ARG HDP_REPO_URL='http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo'
ENV AMBARI_REPO_URL $AMBARI_REPO_URL
ENV HDP_REPO_URL $HDP_REPO_URL

RUN yum install -y sudo wget openssl-devel postgresql-jdbc mysql-connector-java unzip
RUN wget -nv ${AMBARI_REPO_URL} -O /etc/yum.repos.d/ambari.repo
RUN wget -nv ${HDP_REPO_URL} -O /etc/yum.repos.d/hdp.repo
RUN yum install -y krb5-server krb5-libs krb5-workstation ambari-agent ambari-metrics-* ambari-logsearch-* hadoop* zookeeper* hive* phoenix_* ranger* storm_* kafka_* pig_* datafu_* spark* livy* zeppelin* falcon_* oozie_* smartsense* druid* superset* lzo snappy-devel rpcbind ambari-server
ADD scripts/ambari-hdp-1.repo /etc/yum.repos.d/
ADD scripts/krb5.conf /etc/
ADD scripts/start.sh /start.sh
RUN ambari-server setup --database=postgres --databasehost=postgres.lbg.dev --databaseport=5432 --databasename=ambari --postgresschema=ambari  --databaseusername=ambari --databasepassword=dev --silent
RUN ambari-server setup --jdbc-db postgres --jdbc-driver=/usr/share/java/postgresql-jdbc.jar
ADD scripts/serverstart.sh /serverstart.sh
ADD scripts/HDP-2.6.4.0-91.xml /tmp
