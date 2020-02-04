@Library('whiteblock-dev')_

pipeline {
   agent {
      kubernetes {
        cloud 'kubernetes-prod-gke'
        yaml """
  apiVersion: v1
  kind: Pod
  metadata:
    labels:
      cicd: true
  spec:
    serviceAccountName: tiller
    containers:
    - name: gsutil
      image: gcr.io/google.com/cloudsdktool/cloud-sdk:alpine
      command:
      - cat
      tty: true
  """
      }
  }
  environment {
    DEFAULT_BRANCH = 'master'
  }
  stages {
    stage('publish-hashes') {
      steps {
        sh 'find . -name *.yaml | xargs shasum > latest.txt'
      }
    }
  }
}
