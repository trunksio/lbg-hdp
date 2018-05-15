FROM hdp-base
RUN yum install -y ambari-agent
RUN yum install -y ambari-metrics-*
RUN yum install -y ambari-logsearch-*
RUN yum install -y hadoop*
RUN yum install -y hive*
RUN yum install -y smartsense*
RUN yum install -y superset*
RUN yum install -y lzo snappy-devel rpcbind
RUN rm /etc/yum.repos.d/hdp*.repo
ADD scripts/start.sh /start.sh
CMD /start.sh
