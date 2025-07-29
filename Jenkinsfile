pipeline {
    agent any

    environment {
        IMAGE_NAME = "7205416852/myip"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch:'main', url: 'https://github.com/supravat001/myip.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:latest")
                }
            }
        
        }
        stage('Push Docker Image') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'sdash', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            script {
                sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                dockerImage.push("latest")
            }
        }
    }
}
    }
}

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }

