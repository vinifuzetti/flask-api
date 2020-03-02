pipeline {
    environment {
        registry = "vrfuzetti/flask-api"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Building Image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }

        stage('Deploy Image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }

        stage('Clean Workspace'){
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}