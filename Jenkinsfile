pipeline {
    environment {
        registry = "vrfuzetti/flask-api"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    agent { 
        dockerfile {
            label 'app pipeline'
            additionalBuildArgs  '-t flask-api:$BUILD_NUMBER'
        }
    }
    stages {
        stage('Deploy Image') {
            steps {
                withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    sh 'docker push vrfuzetti/flask-api:$BUILD_NUMBER' 
                }
            }
        }
    }
}