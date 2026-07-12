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
