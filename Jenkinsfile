
pipeline {
    agent {
        node { label 'dotnet' }
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
                sh 'cd  ${PWD}/samples/complexapp/tests ; dotnet test'
            }
        }
        stage('Build') {         
           steps {
                sh 'cd ${PWD}/samples/complexapp/tests  dotnet build -c release --no-restore'                
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
