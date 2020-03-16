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

        stage('Upload Image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy Image to Swarm') {
            steps {
                script {
                    def remote = [:]
                    remote.name = 'ec2-3-81-59-56'
                    remote.host = 'ec2-3-81-59-56.compute-1.amazonaws.com'
                    remote.allowAnyHosts = true
                    withCredentials([sshUserPrivateKey(credentialsId: 'aws-user', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
                        remote.user = userName
                        remote.identityFile = identity
                        sh("sed -i 's/VERSION/$BUILD_NUMBER/g' compose-api.yaml")
                        sshPut remote: remote, from: 'compose-api.yaml', into: '.'
                        sshCommand remote: remote, command: "docker service update --image $registry:$BUILD_NUMBER serv_flask-api"
                        sshRemove remote: remote, path: 'compose-api.yaml'
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