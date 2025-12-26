pipeline {
    agent any

    environment {
        IMAGE_NAME = "vijayarangan2002/myapp"
        IMAGE_TAG  = "${BUILD_NUMBER}"

        // Jenkins Credentials IDs
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        GIT_CREDS       = credentials('github-creds')
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                sh '''
                echo "${DOCKERHUB_CREDS_PSW}" | docker login -u "${DOCKERHUB_CREDS_USR}" --password-stdin
                docker push ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Update K8s Repo') {
            steps {
                sh '''
                rm -rf myapp-k8s
                git clone https://github.com/vijayancr/myapp-k8s.git
                cd myapp-k8s

                git config user.email "jenkins@local"
                git config user.name "jenkins"

                sed -i "s|image:.*|image: ${IMAGE_NAME}:${IMAGE_TAG}|g" deployment.yaml

                git add deployment.yaml
                git commit -m "Update image to ${IMAGE_NAME}:${IMAGE_TAG}"

                git push https://${GIT_CREDS_USR}:${GIT_CREDS_PSW}@github.com/vijayancr/myapp-k8s.git
                '''
            }
        }
    }
}
