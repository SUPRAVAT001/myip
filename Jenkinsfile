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
stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                        kubectl apply -f k8s/configmap.yaml
                        kubectl rollout status deployment/myapp-deployment
                    '''
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

