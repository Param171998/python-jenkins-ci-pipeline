pipeline {
    agent any
    environment {
        ENV_TYPE = "develop"
        PROJECT = "python-app"
        VENV_DIR = "test"
        MAIL_FROM = "jenkins@example.com"
        MAIL_TO = "paramwalia1998@gmail.com"
    }
    stages {
        stage('Setup Virtual Environment') {
            steps {
                script {
                    sh '''
                    python3 -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -r python-app/requirements.txt
                    '''
                }
            }
        }
        stage('Code Quality') {
            steps {
                script {
		    sh '''
                    echo "Running Code Quality Checks..."
                    . ${VENV_DIR}/bin/activate
                    sh 'chmod +x pipeline/quality/quality.sh'
                    sh './pipeline/quality/quality.sh'
                    '''
		}
            }
        }
        
        stage('Security Check') {
            steps {
                script {
                    echo "Running Security Analysis..."
                    . ${VENV_DIR}/bin/activate
                    sh 'chmod +x pipeline/security/security.sh'
                    sh './pipeline/security/security.sh'
                }
            }
        }
        
        stage('Testing') {
            steps {
                script {
                    echo "Running Tests..."
                    . ${VENV_DIR}/bin/activate
                    sh 'chmod +x pipeline/test/test.sh'
                    sh './pipeline/test/test.sh'
                }
            }
            post {
                always {
                    echo "Publishing Test Report..."
                    publishHTML([
                        allowMissing: false,
                        keepAll: true,
                        reportDir: 'pipeline/test/coverage-report',
                        reportFiles: 'index.html',
                        reportName: 'Code Coverage Report'
                    ])
                }
            }
        }
        
        stage('Build') {
            steps {
                script {
                    echo "Building Application..."
                    . ${VENV_DIR}/bin/activate
                    sh 'chmod +x pipeline/build/build.sh'
                    sh './pipeline/build/build.sh'
                }
            }
        }
        
        stage('Push to Registry') {
            steps {
                script {
                    echo "Pushing Docker Image to Registry..."
                    . ${VENV_DIR}/bin/activate
                    sh 'chmod +x pipeline/push/push.sh'
                    sh './pipeline/push/push.sh'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    echo "Deploying Application..."
                    . ${VENV_DIR}/bin/activate
                    sh 'chmod +x pipeline/deploy/deploy.sh'
                    sh './pipeline/deploy/deploy.sh'
                }
            }
        }
    }


    post {
        always {
            echo 'Sending status via email'
            mail from: "${MAIL_FROM}",
                 to: "${MAIL_TO}",
                 subject: "[${currentBuild.currentResult}]: Jenkins PythonApp | ${env.JOB_NAME} | #${env.BUILD_NUMBER}",
                 body: """
            Job Details:
            Name      : ${env.JOB_NAME}
            Number    : ${env.BUILD_NUMBER}
            Status    : ${currentBuild.result}
            URL       : ${env.BUILD_URL}

            Note: Auto-generated email.
            """
        }
    }
}
