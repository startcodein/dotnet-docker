
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
        stage('Code Sanity Check') {
            steps {
                sh 'echo "Linting"; sleep 1; ls -l ${PWD}/samples/complexapp/ '
            }
        }
        stage('Functional Testing') {
            steps {
                sh 'cd  ${PWD}/samples/complexapp/tests ; dotnet test'
            }
        }
        stage('Build') {
           steps {
                sh 'cd ${PWD}/samples/complexapp/ ;  dotnet build -c Release '
           }
        }
        stage('Security and Compliance Testing') {
            steps {
                sh './sonar.sh'
                }
        }
        stage('Deployment') {
            steps {
                sh 'env ; cd ${PWD}/samples/complexapp/; dotnet pack -c Release '
                }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '*/**/complexapp*.nupkg', fingerprint: true
        }
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
