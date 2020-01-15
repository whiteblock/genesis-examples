@Library('whiteblock-dev')_

pipeline {
   agent {
      kubernetes {
        cloud 'kubernetes-dev-gke'
        yaml """
  apiVersion: v1
  kind: Pod
  metadata:
    labels:
      cicd: true
  spec:
    containers:
    - name: node
      image: node
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
    stage('lint') {
      steps {
        container('node') {
          script {
            sh "curl -sSf https://assets.whiteblock.io/cli/install.sh | sh"
            def files = findFiles(glob: '**/*.yaml').findAll { !it.path.contains('tutorials/') }
            files.each {
              echo "${it.path}"
              sh """#!/bin/bash
                set -xeo pipefail
                source /root/.whiteblock/env
                genesis lint $it.path
              """
            }
          }
        }
      }
    }
  }
  post {
    always {
      slackNotify(env.BRANCH_NAME == env.DEFAULT_BRANCH)
    }
  }
}
