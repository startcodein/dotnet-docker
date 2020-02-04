
pipeline {
    agent {
        node { label 'dotnet' }
    }
    environment {
        CI = 'true'
        DOTNET_RUNNING_IN_CONTAINER = 'true'
        EMAIL_TO = 'ksraju007@gmail.com'
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
                sh 'cd ${PWD}/samples/complexapp/tests ; dotnet build -c release --no-restore'                
           }
        }
        stage('Deliver') {
            steps {                
                sh 'env'
                }
        }
        stage('Notification') {
            steps {                
                sh 'echo "email will be sent to ${EMAIL_TO}" ; sleep 2'
                }
        }
    }
    post {
        failure {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Build failed in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
        }
        unstable {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Unstable build in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
        }
        changed {
            emailext body: 'Check console output at $BUILD_URL to view the results.', 
                    to: "${EMAIL_TO}", 
                    subject: 'Jenkins build is back to normal: $PROJECT_NAME - #$BUILD_NUMBER'
        }
    }
}
