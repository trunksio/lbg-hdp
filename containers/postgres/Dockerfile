FROM postgres:9.6

# hadolint ignore=DL3008,DL3015
RUN apt-get update -y \
 && apt-get install -y wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ARG AMBARI_DDL_URL
COPY pg_hba.conf /pg_hba.conf
COPY scripts/* /docker-entrypoint-initdb.d/
RUN chmod -R 755 /docker-entrypoint-initdb.d/
RUN mkdir /home/postgres
RUN chown postgres /pg_hba.conf /home/postgres
RUN chown postgres /var/lib/postgresql/data
RUN touch /tmp/test