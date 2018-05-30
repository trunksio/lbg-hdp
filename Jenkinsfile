node {
    checkout scm

    docker.withRegistry('http://nexus-docker-internal.service.consul:80', 'nexus-credentials') {

        def ambari = docker.build("ambari-server:${env.BUILD_ID}", "./containers/ambari-server")
        ambari.push()

        def worker = docker.build("node:worker", "./containers/node")
        worker.push()
        def master = worker.tag("node:master")
        master.push()
    }
}