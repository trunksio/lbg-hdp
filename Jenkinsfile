pipeline {
  agent any
  stages {
    stage('Clone repository') {
      steps {
        checkout scm
      }
    }
    // stage('Lint Dockerfiles') {
    //   parallel {
    //     stage('Lint Ambari Image') {
    //         steps {
    //             script {
    //                 docker.image('hadolint/hadolint:latest-debian').inside() {
    //                     sh 'hadolint ./containers/ambari-server/Dockerfile'
    //                 }
    //             }
    //         }
    //     }
    //     stage('Lint Node Image') {
    //         steps {
    //             script {
    //                 docker.image('hadolint/hadolint:latest-debian').inside() {
    //                     sh 'hadolint ./containers/node/Dockerfile'
    //                 }
    //             }
    //         }
    //     }
    //     stage('Lint Postgres Image') {
    //         steps {
    //             script {
    //                 docker.image('hadolint/hadolint:latest-debian').inside() {
    //                     sh 'hadolint ./containers/postgres/Dockerfile'
    //                 }
    //             }
    //         }
    //     }
    //   }
    // }
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
        stage('Scan ambari image for vulnerabilities') {
            steps {
                script {
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aquasec-microscanner-token',
                                        passwordVariable: 'TOKEN',
                                        usernameVariable: 'USER']]) {

                        ambari.inside("-u root --env \"MICROSCANNER_TOKEN=${env.TOKEN}\" --env https_proxy=$HTTPS_PROXY --env HTTPS_PROXY=$HTTPS_PROXY --env http_proxy=$HTTP_PROXY --env HTTP_PROXY=$HTTP_PROXY"){
                            sh 'mkdir -p /usr/local/bin'
                            sh 'curl https://get.aquasec.com/microscanner -o /usr/local/bin/microscanner'
                            sh 'chmod +x /usr/local/bin/microscanner'
                            sh '/usr/local/bin/microscanner $MICROSCANNER_TOKEN'
                        }
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