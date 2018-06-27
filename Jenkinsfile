pipeline {
  agent any
  stages {
    stage('Clone repository') {
      steps {
        checkout scm
      }
    }
    stage('Build Images') {
      parallel {
        stage('Build Ambari Image') {
          steps {
            withEnv(overrides: ["AMBARI_DDL_URL=https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql",
                                                                    "AMBARI_REPO_URL=http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo",
                                                                    "HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo"]) {
              script {
                ambari = docker.build("ambari-server", "--build-arg HTTP_PROXY=$HTTP_PROXY --build-arg HTTPS_PROXY=$HTTPS_PROXY --build-arg NO_PROXY=$NO_PROXY ./containers/ambari-server")
              }

            }

          }
        }
        stage('Build Node Image') {
          steps {
            withEnv(overrides: ["AMBARI_DDL_URL=https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql",
                                                                    "AMBARI_REPO_URL=http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo",
                                                                    "HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo"]) {
              script {
                node = docker.build("node", "--build-arg HTTP_PROXY=$HTTP_PROXY --build-arg HTTPS_PROXY=$HTTPS_PROXY --build-arg NO_PROXY=$NO_PROXY ./containers/node")
              }

            }

          }
        }
        stage('Build Postgres Image') {
          steps {
            withEnv(overrides: ["AMBARI_DDL_URL=https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql",
                                                                    "AMBARI_REPO_URL=http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo",
                                                                    "HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo"]) {
              script {
                postgres = docker.build("postgres", "--build-arg HTTP_PROXY=$HTTP_PROXY --build-arg HTTPS_PROXY=$HTTPS_PROXY --build-arg NO_PROXY=$NO_PROXY ./containers/postgres")
              }

            }

          }
        }
        stage('Build kdc Image') {
          steps {
            withEnv(overrides: ["AMBARI_DDL_URL=https://raw.githubusercontent.com/apache/ambari/release-2.6.1/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql",
                                                                    "AMBARI_REPO_URL=http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.0/ambari.repo",
                                                                    "HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.4.0/hdp.repo"]) {
              script {
                kerberos = docker.build("kdc", "--build-arg HTTP_PROXY=$HTTP_PROXY --build-arg HTTPS_PROXY=$HTTPS_PROXY --build-arg NO_PROXY=$NO_PROXY ./containers/kdc")
              }

            }

          }
        }
      }
    }
    stage('Test/Scan Images') {
      parallel {
        stage('Scan Ambari image for OS vulnerabilities') {
            steps {
                aquaMicroscanner imageName: ambari.imageName(), notCompliesCmd: 'exit 1', onDisallowed: 'warn'
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
        stage('Test Postgres Image') {
          steps {
            script {
              postgres.inside {
                sh 'echo "Do some stuff"'
              }
            }

          }
        }
      }
    }
    stage('Push Images') {
      parallel {
        stage('Push Ambari Image') {
          steps {
              script {
                docker.withRegistry("$REGISTRY_URL", 'nexus-credentials') {
                  ambari.push("latest")
                }
              }
          }
        }
        stage('Push Worker Image') {
          steps {
              script {
                docker.withRegistry("$REGISTRY_URL", 'nexus-credentials') {
                  node.push("worker")
                }
              }
          }
        }
        stage('Push Master Image') {
          steps {
            script {
                docker.withRegistry("$REGISTRY_URL", 'nexus-credentials') {
                    node.push("master")
                }
            }
          }
        }
        stage('Push Postgres Image') {
          steps {
            script {
                docker.withRegistry("$REGISTRY_URL", 'nexus-credentials') {
                    postgres.push("latest")
                }
            }
          }
        }
        stage('Push kdc Image') {
          steps {
                script {
                  docker.withRegistry("$REGISTRY_URL", 'nexus-credentials') {
                    kerberos.push("latest")
                  }
                }
            }
        }
      }
    }
  }
  environment {
    HTTP_PROXY = '"http://dmz-proxy-01.sandbox.local:3128"'
    HTTPS_PROXY = '"http://dmz-proxy-01.sandbox.local:3128"'
    NO_PROXY = '"registry.service.consul"'
    REGISTRY_URL = 'https://registry:443'
  }
}