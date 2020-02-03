
pipeline {
    agent {
        node { label 'build_host' }
    }
    environment {
        CI = 'true'
        DOTNET_RUNNING_IN_CONTAINER = 'true'
    }
    stages {
        stage('Preparing Workspace') {          
            steps {               
                sh 'cp ${PWD}/samples/Directory.Build.props ${PWD}/samples/complexapp/'
                sh 'sudo rm -rf ${PWD}/samples/complexapp/libbar/obj'
                sh 'sudo rm -rf ${PWD}/samples/complexapp/libbar/bin'
                sh 'sudo rm -rf ${PWD}/samples/complexapp/libfoo/obj'
                sh 'sudo rm -rf ${PWD}/samples/complexapp/libfoo/bin'
                sh 'sudo rm -rf ${PWD}/samples/complexapp/tests/bin'
                sh 'sudo rm -rf ${PWD}/samples/complexapp/tests/obj'
            }
        }
        stage('Sanity Check') {
            steps {
                sh 'echo "Linting"; sleep 10;'               
            }
        }
        stage('Unit Test') {
            steps {
                sh 'docker run --rm -v ${PWD}/samples/complexapp:/app -w /app/tests mcr.microsoft.com/dotnet/core/sdk:3.1 dotnet test'
            }
        }
        stage('Build') {         
           steps {
                sh 'docker run --rm -v ${PWD}/samples/complexapp:/app -w /app/tests mcr.microsoft.com/dotnet/core/sdk:3.1 dotnet build -c release --no-restore'                
           }
        }
        stage('Deliver') {
            steps {
                sh 'docker run --rm -v ${PWD}/samples/complexapp:/app -w /app/tests mcr.microsoft.com/dotnet/core/sdk:3.1 dotnet clean'
                sh './jenkins/scripts/deliver.sh'
                sh './jenkins/scripts/validate.sh'
                input message: 'Kill the process ? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}
