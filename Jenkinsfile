node {
    def ambari
    def node

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

    stage('Build ambari image') {
        steps {
            parallel(
                "build ambari image": {
                    withEnv(["AMBARI_DDL_URL=https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql",
                        "AMBARI_REPO_URL=http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo",
                        "HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo"]) {
                        
                        ambari = docker.build("ambari-server", "./containers/ambari-server")
                    }
                },
                "build node image": {
                    withEnv(["AMBARI_DDL_URL=https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql",
                        "AMBARI_REPO_URL=http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo",
                        "HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo"]) {
                        
                        node = docker.build("node", "./containers/node")
                    }
                }
            )
        }
    }

    stage('Test images') {
        /* Ideally, we would run a test framework against our image.*/
        steps {
            parallel(
                "test ambari image": {
                    ambari.inside {
                        sh 'echo "Do some stuff"'
                    }
                },
                "test node image": {
                    node.inside {
                        sh 'echo "Do some stuff"'
                    }
                }
            )
        }
    }

    stage('Push images') {
        /* Ideally, we would run a test framework against our image.*/
        steps {
            parallel(
                "Push ambari image": {
                    docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                        ambari.push("latest")
                    }
                },
                "Push node image as worker tag": {
                    docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                        node.push("master")
                    }
                },
                "Push node image as master tag": {
                    docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                        node.push("master")
                    }
                }
            )
        }
    }
}