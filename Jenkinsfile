
pipeline {
    agent {
        node { label 'dotnet' }
    }
    environment {
        CI = 'true'
        DOTNET_RUNNING_IN_CONTAINER = 'true'
        EMAIL_TO = 'distribution@example.com'
    }
    stages {
        stage('Sanity Check') {
            steps {
                sh 'echo "Linting"; sleep 1; ls -l ${PWD}/samples/complexapp/ '
            }
        }
        stage('Unit Test') {
            steps {
                sh 'cd  ${PWD}/samples/complexapp/tests ; dotnet test'
            }
        }
        stage('Build') {
           steps {
                sh 'cd ${PWD}/samples/complexapp/tests ;  ls -l ; dotnet build -c release --no-restore'
           }
        }
        stage('CodeAnalysis') {
            steps {
                sh './sonar.sh'
                }
        }
        stage('Deliver') {
            steps {
                sh 'env ; cd ${PWD}/samples/complexapp/tests ; dotnet publish -c release --no-build ; ls -l  '
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
