pipeline {

    agent any

    tools {
        maven 'Maven3'
    }

    environment {
        APP_NAME = 'automation-deployment'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '========== CHECKOUT =========='
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo '========== BUILD =========='
                sh 'mvn clean package'
            }
        }

        stage('Archive Artifact') {
            steps {
                echo '========== ARCHIVE =========='
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }
    }

    post {

        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }

        always {
            cleanWs()
        }
    }
}
