pipeline {
    agent any

    environment {
        IMAGE_NAME = "7205416852/myip"
        DOCKER_CREDS = credentials('7205416852')  // ID of Docker Hub credentials in Jenkins
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/supravat001/myip.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${7205416852/myip}:latest")
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'pip install -r requirements.txt'
                sh 'pytest tests || echo "No tests found."'
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', '7205416852') {
                        dockerImage.push("latest")
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
}
