
pipeline {
    agent {
        node { label 'build_host' }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Sanity Check') {
            steps {
                sh 'sleep 10; echo "Linting";curl -o Directory.Build.props https://raw.githubusercontent.com/dotnet/dotnet-docker/master/samples/Directory.Build.props
'
            }
        }
        stage('Unit Test') {
            steps {
                sh 'docker run --rm -v ${pwd}:/app -w /app/tests mcr.microsoft.com/dotnet/core/sdk:3.1 dotnet test'
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
