pipeline {

    agent any

    tools {
        maven 'Maven3'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }

    environment {

        APP_NAME = "automation-deployment"

        GROUP_ID = "com/example"

        ARTIFACT_ID = "automation-deployment-project"

        VERSION = "1.0.${BUILD_NUMBER}"

        SONAR_PROJECT_KEY = "automation-deployment"

        SONAR_PROJECT_NAME = "Automation Deployment Project"

        NEXUS_URL = "http://nexus:8081"

        NEXUS_REPOSITORY = "maven-releases1"

        IMAGE_NAME = "automation-deployment"

        IMAGE_TAG = "${BUILD_NUMBER}"

        CONTAINER_NAME = "automation-app"

        CONTAINER_PORT = "9091"

    }

    stages {

        stage('Checkout') {

            steps {

                echo "========== CHECKOUT =========="

                checkout scm

            }

        }

        stage('Build + Unit Test + SonarQube') {

            steps {

                echo "========== BUILD / TEST / SONAR =========="

                withSonarQubeEnv('SonarQube') {

                    sh """
                    mvn clean verify sonar:sonar \
                        -Drevision=${VERSION} \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.projectName="${SONAR_PROJECT_NAME}"
                    """

                }

            }

        }

        stage('Quality Gate') {

            steps {

                echo "========== QUALITY GATE =========="

                timeout(time: 10, unit: 'MINUTES') {

                    waitForQualityGate abortPipeline: true

                }

            }

        }

        stage('Package') {

            steps {

                echo "========== PACKAGE =========="

                sh """
                mvn package \
                    -DskipTests \
                    -Drevision=${VERSION}
                """

            }

        }

        stage('Publish Artifact to Nexus') {

            steps {

                echo "========== PUBLISH TO NEXUS =========="

                withCredentials([
                    usernamePassword(
                        credentialsId: 'nexus-cred',
                        usernameVariable: 'NEXUS_USER',
                        passwordVariable: 'NEXUS_PASS'
                    )
                ]) {

                    configFileProvider([
                        configFile(
                            fileId: 'maven-settings',
                            variable: 'MAVEN_SETTINGS'
                        )
                    ]) {

                        sh '''
                        mvn deploy \
                            -DskipTests \
                            -Drevision=${VERSION} \
                            -s "$MAVEN_SETTINGS"
                        '''

                    }

                }

            }

        }

        stage('Download Artifact From Nexus') {

            steps {

                echo "========== DOWNLOAD =========="

                withCredentials([
                    usernamePassword(
                        credentialsId: 'nexus-cred',
                        usernameVariable: 'NEXUS_USER',
                        passwordVariable: 'NEXUS_PASS'
                    )
                ]) {

                    sh '''
                    curl -u "$NEXUS_USER:$NEXUS_PASS" \
                    -o deployment.war \
                    "$NEXUS_URL/repository/$NEXUS_REPOSITORY/$GROUP_ID/$ARTIFACT_ID/$VERSION/$ARTIFACT_ID-$VERSION.war"
                    '''

                }

            }

        }

        stage('Verify Artifact') {

            steps {

                echo "========== VERIFY ARTIFACT =========="

                sh '''
                ls -lh deployment.war
                sha1sum deployment.war
                '''

            }

        }

        stage('Build Docker Image') {

            steps {

                echo "========== BUILD DOCKER IMAGE =========="

                sh '''
                docker build \
                    -t ${IMAGE_NAME}:${IMAGE_TAG} \
                    .
                '''

            }

        }

        stage('Verify Docker Image') {

            steps {

                echo "========== VERIFY DOCKER IMAGE =========="

                sh '''
                docker images | grep ${IMAGE_NAME}
                '''

            }

        }

        stage('Deploy Docker Container') {

            steps {

                echo "========== DEPLOY DOCKER CONTAINER =========="

                sh '''
                docker rm -f ${CONTAINER_NAME} || true

                docker run -d \
                    --name ${CONTAINER_NAME} \
                    -p ${CONTAINER_PORT}:8080 \
                    ${IMAGE_NAME}:${IMAGE_TAG}
                '''

            }

        }

        stage('Container Health Check') {

            steps {

                echo "========== HEALTH CHECK =========="

                sh '''
                sleep 15

                curl -I http://host.docker.internal:${CONTAINER_PORT}
                '''

            }

        }

    }

    post {

        success {

            echo "=========================================="
            echo "PIPELINE COMPLETED SUCCESSFULLY"
            echo "Application Version : ${VERSION}"
            echo "Docker Image : ${IMAGE_NAME}:${IMAGE_TAG}"
            echo "=========================================="

        }

        failure {

            echo "=========================================="
            echo "PIPELINE FAILED"
            echo "=========================================="

        }

        always {

            cleanWs()

        }

    }

}
