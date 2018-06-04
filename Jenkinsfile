    
def ambari
def node

pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                /* Let's make sure we have the repository cloned to our workspace */
                checkout scm
            }
        }
        stage('Build Images') {
            parallel{
                stage('Build Ambari Image') {
                    steps {
                        withEnv(["AMBARI_DDL_URL=https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql",
                                "AMBARI_REPO_URL=http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo",
                                "HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo"]) {
                            
                            script {
                                ambari = docker.build("ambari-server", "./containers/ambari-server")
                            }
                        }
                    }
                }
                stage('Build Node Image') {
                    steps {
                        withEnv(["AMBARI_DDL_URL=https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql",
                                "AMBARI_REPO_URL=http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo",
                                "HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo"]) {

                            script {    
                                node = docker.build("node", "./containers/node")
                            }
                        }
                    }
                }
            }
        }
        stage('Test Images') {
            parallel{
                stage('Test Ambari Image') {
                    steps {
                        script {
                            ambari.inside {
                                sh 'echo "Do some stuff"'
                            }
                        }
                    }
                }
                stage('Test Node Image') {
                    steps {
                        script {
                            node.inside {
                                sh 'echo "Do some stuff"'
                            }
                        }
                    }
                }
            }
        }
        stage('Push Images') {
            parallel{
                stage('Push Ambari Image') {
                    steps {
                        script {
                            docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                                ambari.push("latest")
                            }
                        }
                    }
                }
                stage('Push Worker Image') {
                    steps {
                        script {
                            docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                                node.push("worker")
                            }
                        }
                    }
                }
                stage('Push Master Image') {
                    steps {
                        script {
                            docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                                node.push("master")
                            }
                        }
                    }
                }
            }
        }
    }
}