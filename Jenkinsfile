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
                ambari = docker.build("ambari-server", "-e HTTP_PROXY=$HTTP_PROXY -e HTTPS_PROXY=$HTTPS_PROXY -e NO_PROXY=$NO_PROXY ./containers/ambari-server")
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
                node = docker.build("node", "-e HTTP_PROXY=$HTTP_PROXY -e HTTPS_PROXY=$HTTPS_PROXY -e NO_PROXY=$NO_PROXY ./containers/node")
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
                postgres = docker.build("postgres", "-e HTTP_PROXY=$HTTP_PROXY -e HTTPS_PROXY=$HTTPS_PROXY -e NO_PROXY=$NO_PROXY ./containers/postgres")
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
                kerberos = docker.build("kdc", "-e HTTP_PROXY=$HTTP_PROXY -e HTTPS_PROXY=$HTTPS_PROXY -e NO_PROXY=$NO_PROXY ./containers/kdc")
              }

            }

          }
        }
      }
    }
    stage('Test Images') {
      parallel {
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
            withEnv(overrides: ["REGISTRY_URL=https://registry.service.consul:443"]) {
              script {
                docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                  ambari.push("latest")
                }
              }

            }

          }
        }
        stage('Push Worker Image') {
          steps {
            withEnv(overrides: ["REGISTRY_URL=https://registry.service.consul:443"]) {
              script {
                docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                  node.push("worker")
                }
              }

            }

          }
        }
        stage('Push Master Image') {
          steps {
            script {
              withEnv(["REGISTRY_URL=https://registry.service.consul:443"]) {
                script {
                  docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                    node.push("master")
                  }
                }
              }
            }

          }
        }
        stage('Push Postgres Image') {
          steps {
            script {
              withEnv(["REGISTRY_URL=https://registry.service.consul:443"]) {
                script {
                  docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                    postgres.push("latest")
                  }
                }
              }
            }

          }
        }
        stage('Push kdc Image') {
          steps {
            script {
              withEnv(["REGISTRY_URL=https://registry.service.consul:443"]) {
                script {
                  docker.withRegistry('https://nexus-docker-internal:443', 'nexus-credentials') {
                    kerberos.push("latest")
                  }
                }
              }
            }

          }
        }
      }
    }
  }
  environment {
    HTTP_PROXY = 'http://dmz-proxy-01.sandbox.local:3128'
    HTTPS_PROXY = 'http://dmz-proxy-01.sandbox.local:3128'
    NO_PROXY = 'registry.service.consul'
  }
}