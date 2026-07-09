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

        APP_NAME           = "automation-deployment"
        GROUP_ID           = "com/example"
        ARTIFACT_ID        = "automation-deployment-project"

        VERSION            = "1.0.${BUILD_NUMBER}"

        SONAR_PROJECT_KEY  = "automation-deployment"
        SONAR_PROJECT_NAME = "Automation Deployment Project"

        NEXUS_URL          = "http://nexus:8081"
        NEXUS_REPOSITORY   = "maven-releases1"

        TOMCAT_URL         = "http://tomcat:8080"
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

                echo "========== NEXUS DEPLOY =========="

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

                    sh """
                        curl -u ${NEXUS_USER}:${NEXUS_PASS} \
                        -o deployment.war \
                        ${NEXUS_URL}/repository/${NEXUS_REPOSITORY}/${GROUP_ID}/${ARTIFACT_ID}/${VERSION}/${ARTIFACT_ID}-${VERSION}.war
                    """

                }

            }

        }

        stage('Verify Artifact') {

            steps {

                echo "========== VERIFY =========="

                sh """
                    ls -lh deployment.war
                    sha1sum deployment.war
                """

            }

        }

        stage('Deploy to Tomcat') {

            steps {

                echo "========== DEPLOY =========="

                withCredentials([
                    usernamePassword(
                        credentialsId: 'tomcat-cred',
                        usernameVariable: 'TOMCAT_USER',
                        passwordVariable: 'TOMCAT_PASS'
                    )
                ]) {

                    sh """
                        curl -v \
                        -u ${TOMCAT_USER}:${TOMCAT_PASS} \
                        --upload-file deployment.war \
                        "${TOMCAT_URL}/manager/text/deploy?path=/${APP_NAME}&update=true"
                    """

                }

            }

        }

        stage('Health Check') {

            steps {

                echo "========== HEALTH CHECK =========="

                sh """

                    sleep 10

                    curl -I http://tomcat:8080/${APP_NAME}/

                """

            }

        }

    }

    post {

        success {

            echo "======================================"
            echo "BUILD SUCCESSFUL"
            echo "Version : ${VERSION}"
            echo "======================================"

        }

        failure {

            echo "======================================"
            echo "BUILD FAILED"
            echo "======================================"

        }

        always {

            cleanWs()

        }

    }

}
