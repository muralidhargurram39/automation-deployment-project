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
	
	// Docker CLI (host daemon)
	DOCKER_REGISTRY = "localhost:8083"

	// Registry API (inside Jenkins container)

        REGISTRY_API = "nexus:8083"

        DOCKER_REPOSITORY = "docker-hosted"

        IMAGE_NAME = "automation-deployment"

        // ------------------------------------------------------------------
        // Deployment
        // ------------------------------------------------------------------

        CONTAINER_NAME = "automation-app"

        HOST_PORT = "9091"

        DOCKER_NETWORK = "ci-cd-lab_cicd-network"

        HEALTH_URL = "http://host.docker.internal:9091"

        // ------------------------------------------------------------------
        // Kubernetes
        // ------------------------------------------------------------------

        KIND_CLUSTER_NAME = "automation-deployment-cluster"

        K8S_NAMESPACE = "automation-deployment"

        DEPLOYMENT_NAME = "automation-deployment"

        SERVICE_NAME = "automation-service"

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
    // Validate Workspace
    // ==============================================================

        stage('Validate Workspace') {

            steps {

                echo "======================================"
                echo "VALIDATE WORKSPACE"
                echo "======================================"
                sh '''
                chmod +x scripts/common/validate_workspace.sh
                ./scripts/common/validate_workspace.sh
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
        stage('Deploy to Kubernetes') {

            steps {

                echo "======================================"
                echo "DEPLOY TO KUBERNETES"
                echo "======================================"

                withCredentials([

                    usernamePassword(

                        credentialsId: 'nexus-docker-cred',

                        usernameVariable: 'NEXUS_USERNAME',

                        passwordVariable: 'NEXUS_PASSWORD'
                    )
                ]) {

                    sh '''

                    chmod +x scripts/kubernetes/*.sh
                    chmod +x scripts/pipeline/*.sh
                    ./scripts/pipeline/deploy_kubernetes.sh

                    '''
                }
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
            echo "Build Number      : ${BUILD_NUMBER}"
            echo "Application       : ${APP_NAME}"
            echo "Version           : ${VERSION}"
            echo "Docker Registry   : ${DOCKER_REGISTRY}"
            echo "Docker Repository : ${DOCKER_REPOSITORY}"
            echo "Image Name        : ${IMAGE_NAME}"
            echo "K8S Namespace     : ${K8S_NAMESPACE}"
            echo "Deployment        : ${DEPLOYMENT_NAME}"
            echo "Service           : ${SERVICE_NAME}"
            '''

            //
            // Archive Reports
            //
            archiveArtifacts(
                artifacts: 'reports/**/*',
                fingerprint: true,
                allowEmptyArchive: true
            )

            archiveArtifacts(
                artifacts: 'diagnostics/**/*',
                fingerprint: true,
                allowEmptyArchive: true
            )

            //
            // Publish HTML Reports
            //
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

        }

        success {

            echo ""
            echo "======================================"
            echo "BUILD SUCCESSFUL"
            echo "======================================"

            echo "Application : ${APP_NAME}"
            echo "Version     : ${VERSION}"

            echo ""
            echo "Docker Image"
            echo "${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}"

            echo ""
            echo "Deployment Platform : Kubernetes"
            echo "Namespace           : ${K8S_NAMESPACE}"
            echo "Deployment          : ${DEPLOYMENT_NAME}"
            echo "Service             : ${SERVICE_NAME}"

            sh '''
            echo
            echo "========== Deployment =========="
            kubectl get deployment ${DEPLOYMENT_NAME} \
            -n ${K8S_NAMESPACE}

            echo
            echo "========== Pods =========="
            kubectl get pods \
            -n ${K8S_NAMESPACE}

            echo
            echo "========== Service =========="
            kubectl get svc \
            -n ${K8S_NAMESPACE}
            '''

            echo ""
            echo "Pipeline completed successfully."

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
            echo "Collecting Kubernetes diagnostics..."

            chmod +x scripts/kubernetes/*.sh

            ./scripts/kubernetes/collect_diagnostics.sh || true
            
            '''

            archiveArtifacts(
                artifacts: 'diagnostics/**/*',
                fingerprint: true,
                allowEmptyArchive: true
            )

            echo ""
            echo "Diagnostics collection completed."

            echo "======================================"
        }
        //
        // Cleanup Workspace
        //
        cleanup {
            echo ""
            echo "======================================"
            echo "CLEANUP WORKSPACE"
            echo "======================================"
            cleanWs(
                deleteDirs: true,
                disableDeferredWipeout: true
            )
        }
    }
}
