FROM hdp-base 

ARG HTTP_PROXY=''
ENV HTTP_PROXY=$HTTP_PROXY

ARG HTTPS_PROXY=''
ENV HTTPS_PROXY=$HTTPS_PROXY

ARG NO_PROXY=''
ENV NO_PROXY=$NO_PROXY

RUN yum install -y ambari-agent
RUN yum install -y ambari-metrics-*
RUN yum install -y ambari-logsearch-*
RUN yum install -y hadoop*
RUN yum install -y zookeeper*
RUN yum install -y kafka_*
RUN yum install -y datafu_*
RUN yum install -y smartsense*
RUN yum install -y superset*
RUN yum install -y lzo snappy-devel rpcbind
RUN rm /etc/yum.repos.d/hdp*.repo
ADD scripts/start.sh /start.sh
CMD /start.sh
