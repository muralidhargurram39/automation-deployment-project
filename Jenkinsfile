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

        // -------------------------------------------------------
        // Application
        // -------------------------------------------------------
        APP_NAME = "automation-deployment"
        GROUP_ID = "com/example"
        ARTIFACT_ID = "automation-deployment-project"

        // -------------------------------------------------------
        // Version
        // -------------------------------------------------------
        VERSION = "1.0.${BUILD_NUMBER}"

        // -------------------------------------------------------
        // Nexus Maven
        // -------------------------------------------------------
        NEXUS_URL = "http://nexus:8081"
        NEXUS_REPOSITORY = "maven-releases1"

        // -------------------------------------------------------
        // Nexus Docker Registry
        // -------------------------------------------------------
        DOCKER_REGISTRY = "nexus:8083"
        DOCKER_REPOSITORY = "automation-deployment"

        // -------------------------------------------------------
        // SonarQube
        // -------------------------------------------------------
        SONAR_PROJECT_KEY = "automation-deployment"
        SONAR_PROJECT_NAME = "automation-deployment"

        // -------------------------------------------------------
        // Docker Deployment
        // -------------------------------------------------------
        CONTAINER_NAME = "automation-app"
        DOCKER_NETWORK = "ci-cd-lab_cicd-network"

        HOST_PORT = "9091"
        CONTAINER_PORT = "8080"
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
                            -Dsonar.projectName=${SONAR_PROJECT_NAME}
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

                echo "========== PUBLISH WAR =========="

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

                        sh """
                            mvn deploy \
                                -DskipTests \
                                -Drevision=${VERSION} \
                                -s ${MAVEN_SETTINGS}
                        """

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

                echo "========== VERIFY WAR =========="

                sh '''
                    ls -lh deployment.war
                    sha1sum deployment.war
                '''

            }

        }

        stage('Build Docker Image') {

            steps {

                echo "========== BUILD DOCKER IMAGE =========="

                script {

                    env.IMAGE_VERSION = "${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}:${VERSION}"
                    env.IMAGE_LATEST = "${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}:latest"

                    sh """
                        docker build \
                            --build-arg APP_VERSION=${VERSION} \
                            -t ${IMAGE_VERSION} \
                            -t ${IMAGE_LATEST} \
                            .
                    """

                }

            }

        }

        stage('Verify Docker Image') {

            steps {

                echo "========== VERIFY DOCKER IMAGE =========="

                sh '''
                    docker image inspect "$IMAGE_VERSION"
                    docker images | grep automation-deployment
                '''

            }

        }

        stage('Deploy Docker Container') {

            steps {

                echo "========== DEPLOY =========="

                sh '''
                    docker rm -f "$CONTAINER_NAME" || true

                    docker run -d \
                        --name "$CONTAINER_NAME" \
                        --network "$DOCKER_NETWORK" \
                        -p "$HOST_PORT:8080" \
                        "$IMAGE_VERSION"
                '''

            }

        }

        stage('Container Health Check') {

            steps {

                echo "========== HEALTH CHECK =========="

                sh '''
                    echo "Waiting for application..."

                    i=1

                    while [ $i -le 12 ]
                    do
                        if curl -fs http://automation-app:8080/ >/dev/null
                        then
                            echo "Application is healthy."
                            exit 0
                        fi

                        echo "Retry $i..."
                        i=$((i+1))

                        sleep 5
                    done

                    echo "Health check failed."

                    docker ps

                    docker logs automation-app || true

                    exit 1
                '''

            }

        }

    }

    post {

        success {

            echo "======================================="
            echo "PIPELINE COMPLETED SUCCESSFULLY"
            echo "Application Version : ${VERSION}"
            echo "Docker Image : ${IMAGE_VERSION}"
            echo "======================================="

        }

        failure {

            echo "======================================="
            echo "PIPELINE FAILED"
            echo "======================================="

        }

        always {

            cleanWs()

        }

    }

}
