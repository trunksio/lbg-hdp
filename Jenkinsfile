pipeline {
    agent any
    checkout scm
    stages {
        stage('base') {
            steps {
                docker.withRegistry('http://nexus-docker-internal.service.consul:80', 'nexus-credentials') {

                    def baseImage = docker.build("lbg-hdp-base:${env.BUILD_ID}", "./containers/base")
                    baseImage.push()
                }
            }
        }
        // stage('Stage 2') {
        //     steps {
        //         node(windowsNode) {
        //             echo "windowsNode: $windowsNode, NODE_NAME: $NODE_NAME"
        //         }
        //     }
        // }
    }
}