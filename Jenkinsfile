pipeline {

    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }

    environment {

        BUILD_VERSION = "1.0.${BUILD_NUMBER}"

    }

    stages {

        stage('Checkout') {

            steps {

                checkout scm

            }

        }

        stage('Build') {

            steps {

                echo "========== BUILD =========="

                echo "Version : ${BUILD_VERSION}"

                sh """
                    mvn clean package \
                    -Drevision=${BUILD_VERSION}
                """

            }

        }

        stage('SonarQube Analysis') {

            steps {

                withSonarQubeEnv('SonarQube') {

                    sh """
                        mvn sonar:sonar \
                        -Drevision=${BUILD_VERSION}
                    """

                }

            }

        }

        stage('Archive Artifact') {

            steps {

                archiveArtifacts artifacts: 'target/*.war',
                                 fingerprint: true

            }

        }

        stage('Deploy to Nexus') {

            steps {

                configFileProvider([
                    configFile(
                        fileId: 'maven-settings',
                        variable: 'MAVEN_SETTINGS'
                    )
                ]) {

                    withCredentials([
                        usernamePassword(
                            credentialsId: 'nexus-cred',
                            usernameVariable: 'NEXUS_USER',
                            passwordVariable: 'NEXUS_PASS'
                        )
                    ]) {

                        sh """
                            mvn deploy \
                            -s \$MAVEN_SETTINGS \
                            -Drevision=${BUILD_VERSION}
                        """

                    }

                }

            }

        }

    }

    post {

        success {

            echo "=================================="
            echo "Build Successful"
            echo "Artifact Version : ${BUILD_VERSION}"
            echo "=================================="

        }

        failure {

            echo "=================================="
            echo "Build Failed"
            echo "=================================="

        }

        always {

            cleanWs()

        }

    }

}
