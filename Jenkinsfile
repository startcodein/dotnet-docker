
pipeline {
    agent {
        node { label 'build_host' }
    }
    environment {
        CI = 'true'
        DOTNET_RUNNING_IN_CONTAINER = 'true'
    }
    stages {
        stage('Sanity Check') {
            steps {
                sh 'echo "Linting"; sleep 10;'
            }
        }
        stage('Unit Test') {
            steps {
                sh 'docker run --rm -v ./samples/complexapp:/app -w /app/tests mcr.microsoft.com/dotnet/core/sdk:3.1 dotnet test'
            }
        }
        stage('Test and Audit') {
            failFast true
            parallel {
              stage('Test') {
                steps {
                    sh './jenkins/scripts/test.sh'
                }
              }
              stage('Audit') {
                steps {
                    sh './jenkins/scripts/audit.sh'
                }
              }
            }
        }
        stage('Deliver') {
            steps {
                sh './jenkins/scripts/deliver.sh'
                sh './jenkins/scripts/validate.sh'
                input message: 'Kill the process ? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}
