pipeline {

    agent any

    tools {
        maven 'Maven'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }

    environment {

        APP_NAME           = 'automation-deployment'

        GROUP_ID           = 'com/example'

        ARTIFACT_ID        = 'automation-deployment-project'

        VERSION            = "1.0.${BUILD_NUMBER}"

        NEXUS_URL          = 'http://nexus:8081'

        NEXUS_REPOSITORY   = 'maven-releases1'

        TOMCAT_URL         = 'http://tomcat:8080'

        SONAR_PROJECT_KEY  = 'automation-deployment'

        SONAR_PROJECT_NAME = 'automation-deployment'

    }

    stages {

        stage('Checkout') {

            steps {

                echo "========== CHECKOUT =========="

                checkout scm
            }
        }

        stage('Build & Unit Tests') {

            steps {

                echo "========== BUILD =========="

                sh """
                    mvn clean verify \
                    -Drevision=${env.VERSION}
                """

            }

        }

        stage('SonarQube Analysis') {

            steps {

                echo "========== SONARQUBE =========="

                withSonarQubeEnv('SonarQube') {

                    sh """
                        mvn sonar:sonar \
                        -Drevision=${env.VERSION} \
                        -Dsonar.projectKey=${env.SONAR_PROJECT_KEY} \
                        -Dsonar.projectName=${env.SONAR_PROJECT_NAME}
                    """

                }

            }

        }

        stage('Quality Gate') {

            steps {

                echo "========== QUALITY GATE =========="

                timeout(time: 5, unit: 'MINUTES') {

                    waitForQualityGate abortPipeline: true

                }

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

                        sh """
                            mvn deploy \
                            -Drevision=${env.VERSION} \
                            -s ${MAVEN_SETTINGS}
                        """

                    }

                }

            }

        }

        stage('Download Artifact From Nexus') {

            steps {

                echo "========== DOWNLOAD ARTIFACT =========="

                withCredentials([
                    usernamePassword(
                        credentialsId: 'nexus-cred',
                        usernameVariable: 'NEXUS_USER',
                        passwordVariable: 'NEXUS_PASS'
                    )
                ]) {

                    sh """
                        curl -L \
                        -u \$NEXUS_USER:\$NEXUS_PASS \
                        -o deployment.war \
                        ${env.NEXUS_URL}/repository/${env.NEXUS_REPOSITORY}/${env.GROUP_ID}/${env.ARTIFACT_ID}/${env.VERSION}/${env.ARTIFACT_ID}-${env.VERSION}.war
                    """

                }

            }

        }

        stage('Verify Artifact') {

            steps {

                echo "========== VERIFY ARTIFACT =========="

                sh """
                    ls -lh deployment.war
                    file deployment.war
                """

            }

        }

        stage('Deploy to Tomcat') {

            steps {

                echo "========== DEPLOY TO TOMCAT =========="

                withCredentials([
                    usernamePassword(
                        credentialsId: 'tomcat-cred',
                        usernameVariable: 'TOMCAT_USER',
                        passwordVariable: 'TOMCAT_PASS'
                    )
                ]) {

                    sh """
                        curl \
                        --fail \
                        -u \$TOMCAT_USER:\$TOMCAT_PASS \
                        --upload-file deployment.war \
                        "${env.TOMCAT_URL}/manager/text/deploy?path=/${env.APP_NAME}&update=true"
                    """

                }

            }

        }

        stage('Health Check') {

            steps {

                echo "========== HEALTH CHECK =========="

                sh """
                    sleep 10

                    curl --fail \
                    ${env.TOMCAT_URL}/${env.APP_NAME}/
                """

            }

        }

    }

    post {

        success {

            echo "===================================="
            echo "BUILD SUCCESSFUL"
            echo "Version : ${env.VERSION}"
            echo "Application deployed successfully."
            echo "===================================="

        }

        failure {

            echo "===================================="
            echo "BUILD FAILED"
            echo "Deployment failed."
            echo "===================================="

        }

        always {

            cleanWs()

        }

    }

}
