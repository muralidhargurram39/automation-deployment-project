pipeline {

    agent any

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '10'))
        disableConcurrentBuilds()
    }

    environment {
        APP_NAME = "automation-deployment"
    }

    stages {

        stage('Build') {
            steps {
                echo "========== BUILD =========="
                sh 'mvn clean package'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }
    }

    post {

        success {
            echo "Build Successful"
        }

        failure {
            echo "Build Failed"
        }

        always {
            cleanWs()
        }
    }
}
