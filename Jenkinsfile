pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                withCredentials([file(credentialsId: 'vault', variable: 'vault_file')]) {
                    sh 'chmod u+x build_installer.sh'
                    sh './build_installer.sh $vault_file'
                }
                archiveArtifacts artifacts: '**/*.run', fingerprint: true
            }
        }
    }
}