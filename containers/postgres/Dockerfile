FROM postgres:9.6

ARG HTTP_PROXY=''
ENV HTTP_PROXY=$HTTP_PROXY
ENV http_proxy=$HTTP_PROXY

ARG HTTPS_PROXY=''
ENV HTTPS_PROXY=$HTTPS_PROXY
ENV https_proxy=$HTTPS_PROXY

ARG NO_PROXY=''
ENV NO_PROXY=$NO_PROXY

ARG AMBARI_DDL_URL
ADD pg_hba.conf /pg_hba.conf
ADD scripts/* /docker-entrypoint-initdb.d/
RUN chmod -R 755 /docker-entrypoint-initdb.d/
RUN mkdir /home/postgres
RUN chown postgres /pg_hba.conf /home/postgres
RUN chown postgres /var/lib/postgresql/data
