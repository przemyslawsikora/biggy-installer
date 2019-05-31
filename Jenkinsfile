pipeline {
    agent any
    stages {
        stage('Build') {
            when {
                expression { BRANCH_NAME ==~ /(master)/ }
            }
            steps {
                withCredentials([file(credentialsId: 'vault', variable: 'VAULT_FILE')]) {
                    sh 'chmod u+x build_installer.sh'
                    sh './build_installer.sh $VAULT_FILE'
                }
                archiveArtifacts artifacts: '**/*.run', fingerprint: true
            }
        }
        stage('Publish to Nexus') {
            when {
                expression { BRANCH_NAME ==~ /(master)/ }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'nexus_admin', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASSWORD')]) {
                    sh 'curl -v -u $NEXUS_USER:$NEXUS_PASSWORD --upload-file *.run $nexus_address/repository/raw-hosted/biggy/$(find . -name "*.run" -exec basename \{} .po \;)'
                }
            }
        }
    }
}