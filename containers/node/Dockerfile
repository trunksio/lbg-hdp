FROM centos:6

ARG AMBARI_REPO_URL='http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo'
ARG HDP_REPO_URL='http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo'
ENV AMBARI_REPO_URL $AMBARI_REPO_URL
ENV HDP_REPO_URL $HDP_REPO_URL

ARG HTTP_PROXY=''
ENV HTTP_PROXY $HTTP_PROXY

ARG HTTPS_PROXY=''
ENV HTTPS_PROXY $HTTPS_PROXY

ARG NO_PROXY=''
ENV NO_PROXY $NO_PROXY

RUN yum install -y sudo wget openssl-devel postgresql-jdbc mysql-connector-java unzip
RUN wget -nv ${AMBARI_REPO_URL} -O /etc/yum.repos.d/ambari.repo
RUN wget -nv ${HDP_REPO_URL} -O /etc/yum.repos.d/hdp.repo
# Uncomment if you want to run kerberos in container
RUN yum install -y krb5-server krb5-libs krb5-workstation
RUN yum install -y ambari-agent
RUN yum install -y ambari-metrics-*
RUN yum install -y ambari-logsearch-*
RUN yum install -y hadoop*
RUN yum install -y zookeeper*
RUN yum install -y hive*
RUN yum install -y phoenix_*
RUN yum install -y ranger*
RUN yum install -y storm_*
RUN yum install -y kafka_*
RUN yum install -y pig_*
RUN yum install -y datafu_*
RUN yum install -y spark* livy*
RUN yum install -y zeppelin*
RUN yum install -y falcon_*
RUN yum install -y oozie_*
#RUN yum install -y lucidworks-hdpsearch
RUN yum install -y smartsense*
RUN yum install -y druid*
RUN yum install -y superset*
RUN yum install -y lzo snappy-devel rpcbind
ADD scripts/ambari-hdp-1.repo /etc/yum.repos.d/
ADD scripts/krb5.conf /etc/
ADD scripts/start.sh /start.sh
CMD /start.sh
