pipeline {
    agent { label 'b-saf-ec2-docker' }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        IMAGE_NAME = 'okile/b-safe-project-app'
        IMAGE_TAG = "build-${BUILD_NUMBER}"
        APP_PORT = '8090'
        CONTAINER_NAME = 'b-safe-app-running'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Ebosterix/b-safe-project-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Run Automated Tests') {
            steps {
                sh 'chmod +x test/smoke_test.sh'
                sh './test/smoke_test.sh'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                    docker rm -f $CONTAINER_NAME || true
                    docker run -d -p $APP_PORT:80 --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'sleep 3'
                sh 'curl -f http://localhost:$APP_PORT || exit 1'
            }
        }
    }

    post {
        always {
            echo 'Cleaning up dangling images...'
            sh 'docker image prune -f'
        }
        success {
            echo 'Pipeline completed successfully — app is live on port 8090.'
        }
        failure {
            echo 'Pipeline failed — check logs above.'
        }
    }
}

