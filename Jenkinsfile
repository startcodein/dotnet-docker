
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
                sh 'sudo chown -R builder ${PWD}'    
                sh 'cp ${PWD}/samples/Directory.Build.props ${PWD}/samples/complexapp/'               
            }
        }
        stage('Sanity Check') {
            steps {
                sh 'echo "Linting"; sleep 10;'               
            }
        }
        stage('Unit Test') {
            steps {
                sh 'sudo chown -R builder ${PWD}'    
                sh 'docker run -u 1001  --rm -v ${PWD}/samples/complexapp:/app -w /app/tests mcr.microsoft.com/dotnet/core/sdk:3.1 dotnet test'
            }
        }
        stage('Build') {         
           steps {
                sh 'sudo chown -R builder ${PWD}'    
                sh 'docker run -u 1001 --rm -v ${PWD}/samples/complexapp:/app -w /app/tests mcr.microsoft.com/dotnet/core/sdk:3.1 dotnet build -c release --no-restore'                
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
