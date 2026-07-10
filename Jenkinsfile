pipeline {

    agent any

    tools {
        maven 'Maven3'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
        timeout(time: 60, unit: 'MINUTES')
    }

    environment {

        // ------------------------------------------------------------------
        // Application
        // ------------------------------------------------------------------

        APP_NAME = "automation-deployment"

        GROUP_ID = "com/example"

        ARTIFACT_ID = "automation-deployment-project"

        VERSION = "1.0.${BUILD_NUMBER}"

        // ------------------------------------------------------------------
        // SonarQube
        // ------------------------------------------------------------------

        SONAR_PROJECT_KEY = "automation-deployment"

        SONAR_PROJECT_NAME = "automation-deployment"

        // ------------------------------------------------------------------
        // Nexus Maven
        // ------------------------------------------------------------------

        NEXUS_URL = "http://nexus:8081"

        NEXUS_REPOSITORY = "maven-releases1"

        // ------------------------------------------------------------------
        // Docker Registry
        // ------------------------------------------------------------------

        DOCKER_REGISTRY = "localhost:8083"

        DOCKER_REPOSITORY = "docker-hosted"

        IMAGE_NAME = "automation-deployment"

        // ------------------------------------------------------------------
        // Deployment
        // ------------------------------------------------------------------

        CONTAINER_NAME = "automation-app"

        HOST_PORT = "9091"

        DOCKER_NETWORK = "ci-cd-lab_cicd-network"

        HEALTH_URL = "http://host.docker.internal:9091"

    }

    stages {

    // ==============================================================
    // Checkout
    // ==============================================================

        stage('Checkout') {

            steps {

             echo "======================================"
             echo "CHECKOUT"
             echo "======================================"

                checkout scm

            }
        }

    // ==============================================================
    // Compile
    // ==============================================================

        stage('Compile') {

            steps {

                echo "======================================"
                echo "COMPILE"
                echo "======================================"

                sh '''
                    mvn clean compile \
                    -Drevision=${VERSION}
                '''

            }
        }

    // ==============================================================
    // Unit Test
    // ==============================================================

        stage('Unit Test') {

            steps {

                echo "======================================"
                echo "UNIT TEST"
                echo "======================================"

                sh '''
                mvn test \
                -Drevision=${VERSION}
                '''
            }
        }


    // ==============================================================
    // SonarQube Analysis
    // ==============================================================

        stage('SonarQube Analysis') {

            steps {

                echo "======================================"
                echo "SONARQUBE"
                echo "======================================"

                withSonarQubeEnv('SonarQube') {

                    sh '''
                    mvn sonar:sonar \
                    -Drevision=${VERSION} \
                    -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                    -Dsonar.projectName="${SONAR_PROJECT_NAME}"
                    '''
                }
            }    

        }

    // ==============================================================
    // Quality Gate
    // ==============================================================

        stage('Quality Gate') {

            steps {

                echo "======================================"
                echo "QUALITY GATE"
                echo "======================================"

                timeout(time: 10, unit: 'MINUTES') {

                    waitForQualityGate abortPipeline: true

                }
            }
        }
        stage('Filesystem Security Scan') {

            steps {

                sh '''
                chmod +x scripts/security/filesystem_scan.sh
                ./scripts/security/filesystem_scan.sh
                '''
            }
        }

    // ==============================================================
    // Package
    // ==============================================================

        stage('Package') {

            steps {

                echo "======================================"
                echo "PACKAGE"
                echo "======================================"

                sh '''
                mvn package \
                -DskipTests \
                -Drevision=${VERSION}
                '''
            }
        }

    // ==============================================================
    // Publish WAR
    // ==============================================================

        stage('Publish WAR to Nexus') {

            steps {

                echo "======================================"
                echo "PUBLISH WAR"
                echo "======================================"

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
    // ==============================================================
    // Download Artifact
    // ==============================================================

        stage('Download Artifact From Nexus') {

            steps {

                echo "======================================"
                echo "DOWNLOAD ARTIFACT"
                echo "======================================"

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

    // ==============================================================
    // Verify Artifact
    // ==============================================================

        stage('Verify Artifact') {

            steps {

                echo "======================================"
                echo "VERIFY ARTIFACT"
                echo "======================================"

                sh '''
                ls -lh deployment.war
                sha1sum deployment.war
                '''
            }
        }

    // ==============================================================
    // Docker Login
    // ==============================================================

        stage('Docker Login') {

            steps {

                echo "======================================"
                echo "DOCKER LOGIN"
                echo "======================================"

                withCredentials([

                    usernamePassword(

                        credentialsId: 'nexus-docker-cred',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {

                sh '''
                chmod +x scripts/docker/login.sh
                ./scripts/docker/login.sh
                '''
                }
            }
        }

    // ==============================================================
    // Build Docker Image
    // ==============================================================

        stage('Build Docker Image') {

            steps {

                echo "======================================"
                echo "BUILD DOCKER IMAGE"
                echo "======================================"

                sh '''
                chmod +x scripts/docker/build.sh
                ./scripts/docker/build.sh
                '''
            }
        }
        stage('Container Image Security Scan') {

            steps {

                sh '''
                chmod +x scripts/security/image_scan.sh
                ./scripts/security/image_scan.sh
                '''
            }
        }
        stage('Security Gate') {

            environment {

                FAIL_ON_CRITICAL = "true"
                FAIL_ON_HIGH = "false"
            }

            steps {

                sh '''
                chmod +x scripts/security/security_gate.sh
                ./scripts/security/security_gate.sh
                '''
            }
        }


    // ==============================================================
    // Push Docker Image
    // ==============================================================

        stage('Push Docker Images') {

            steps {

                echo "======================================"
                echo "PUSH DOCKER IMAGE"
                echo "======================================"

                sh '''
                chmod +x scripts/docker/push.sh
                ./scripts/docker/push.sh
                '''
            }
        }

    // ==============================================================
    // Pull Docker Image
    // ==============================================================

        stage('Pull Docker Image') {

            steps {

                echo "======================================"
                echo "PULL DOCKER IMAGE"
                echo "======================================"

                sh '''
                chmod +x scripts/docker/pull.sh
                ./scripts/docker/pull.sh
                '''
            }
        }

    // ==============================================================
    // Deploy
    // ==============================================================

        stage('Deploy') {

            steps {

                echo "======================================"
                echo "DEPLOY APPLICATION"
                echo "======================================"

                sh '''
                chmod +x scripts/deploy/deploy.sh
                ./scripts/deploy/deploy.sh
                '''
            }
        }

    // ==============================================================
    // Health Check
    // ==============================================================

        stage('Health Check') {

            steps {

                echo "======================================"
                echo "APPLICATION HEALTH CHECK"
                echo "======================================"

                sh '''
                chmod +x scripts/deploy/healthcheck.sh
                ./scripts/deploy/healthcheck.sh
                '''
            }
        }
    } // End of stages

    // ==============================================================
    // Post Actions
    // ==============================================================

    post {

        always {

            echo "======================================"
            echo "PIPELINE FINISHED"
            echo "======================================"

            sh '''
            echo
            echo "Build Number     : ${BUILD_NUMBER}"
            echo "Application      : ${APP_NAME}"
            echo "Version          : ${VERSION}"
            echo "Docker Registry  : ${DOCKER_REGISTRY}"
            echo "Docker Repository: ${DOCKER_REPOSITORY}"
            echo "Image Name       : ${IMAGE_NAME}"
            '''
            // Archive all security reports
            archiveArtifacts(
                artifacts: 'reports/**/*',
                fingerprint: true,
                allowEmptyArchive: true
            )
            // Publish HTML reports (requires HTML Publisher plugin)
            publishHTML(target: [
                reportName: 'Filesystem Security Report',
                reportDir: 'reports/filesystem',
                reportFiles: 'trivy.html',
                keepAll: true,
                alwaysLinkToLastBuild: true,
                allowMissing: true
            ])

            publishHTML(target: [
                reportName: 'Container Image Security Report',
                reportDir: 'reports/image',
                reportFiles: 'trivy.html',
                keepAll: true,
                alwaysLinkToLastBuild: true,
                allowMissing: true
            ])

            cleanWs(
                deleteDirs: true,
                disableDeferredWipeout: true
            )

        }

        success {

            echo ""
            echo "======================================"
            echo "BUILD SUCCESSFUL"
            echo "======================================"

            echo "Application : ${APP_NAME}"

            echo "Version     : ${VERSION}"

            echo "Docker Image: ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}"

            echo "Deployment  : SUCCESS"

            echo "======================================"

        }

        unstable {

            echo ""
            echo "======================================"
            echo "BUILD UNSTABLE"
            echo "======================================"

        }

        failure {

            echo ""
            echo "======================================"
            echo "BUILD FAILED"
            echo "======================================"

            sh '''
            echo
            echo "========== Docker Containers =========="
            docker ps -a || true

            echo
            echo "========== Docker Images =============="
            docker images || true

            echo
            echo "========== Application Logs ==========="

            docker logs ${CONTAINER_NAME} --tail 100 2>/dev/null || true
            '''

        }
    }
}
