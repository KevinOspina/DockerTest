pipeline {
  agent any
  environment {
    AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    AWS_DEFAULT_REGION = 'us-west-2'
  }
  stages {
    stage('Build and Push Docker Image') {
      steps {
        sh 'docker build -t my-image .'
        withCredentials([usernamePassword(credentialsId: 'my-registry-creds', usernameVariable: 'REGISTRY_USER', passwordVariable: 'REGISTRY_PASS')]) {
          sh 'docker login my-registry.azurecr.io -u $REGISTRY_USER -p $REGISTRY_PASS'
          sh 'docker tag my-image my-registry.azurecr.io/my-image'
          sh 'docker push my-registry.azurecr.io/my-image'
        }
      }
    }
    stage('Deploy to EKS') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig-creds']) {
          sh 'kubectl apply -f kubernetes-deployment.yaml'
        }
      }
    }
  }
}
