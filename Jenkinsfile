node {
    checkout scm

    environment {
        AMBARI_DDL_URL  = 'https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql'
        AMBARI_REPO_URL = 'http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo'
        HDP_REPO_URL    = 'http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo'
    }

    docker.withRegistry('http://nexus-docker-internal.service.consul:80', 'nexus-credentials') {

        def ambari = docker.build("ambari-server:${env.BUILD_ID}", "./containers/ambari-server")
        ambari.push()

        def worker = docker.build("node:worker", "./containers/node")
        worker.push()
        def master = worker.tag("node:master")
        master.push()
    }
}