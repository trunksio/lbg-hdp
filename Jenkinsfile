node {
        checkout scm
        stages {
            stage('base') {
                docker.withRegistry('http://nexus-docker-internal.service.consul:80', 'nexus-credentials') {

                    def baseImage = docker.build("lbg-hdp-base:${env.BUILD_ID}", "./containers/base")
                    baseImage.push()
                }
            }
        } 
}