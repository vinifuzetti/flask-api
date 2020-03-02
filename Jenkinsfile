pipeline {
    environment {
        registry = "vrfuzetti/flask-api"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    agent { 
        dockerfile {
            additionalBuildArgs  '-t flask-api:$BUILD_NUMBER'
        }
    }
    stages {
        stage('Deploy Image') {
            steps {
                withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    sh "docker push vrfuzetti/flask-api:$BUILD_NUMBER"
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