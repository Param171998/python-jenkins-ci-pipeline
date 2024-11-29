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
                    chmod +x pipeline/quality/quality.sh
                    ./pipeline/quality/quality.sh
                    '''
				}
            }
        }
        
        stage('Security Check') {
            steps {
                script {
		    sh '''
                    echo "Running Security Analysis..."
                    . ${VENV_DIR}/bin/activate
                    chmod +x pipeline/security/security.sh
                    ./pipeline/security/security.sh
                    '''
                }
            }
        }
        
        stage('Testing') {
            steps {
                script {
		    sh '''
                    echo "Running Tests..."
                    . ${VENV_DIR}/bin/activate
                    export PYTHONPATH="$PYTHONPATH:$PWD/python-app"
                    chmod +x pipeline/test/test.sh
                    ./pipeline/test/test.sh
                    '''
                }
            }
          }
        
        stage('Build') {
            steps {
                script {
	            sh '''
                    echo "Building Application..."
                    . ${VENV_DIR}/bin/activate
                    chmod +x pipeline/build/build.sh
                    ./pipeline/build/build.sh
                    '''
                }
            }
        }
        
        stage('Push to Registry') {
            steps {
                script {
                    sh '''
                    echo "Pushing Docker Image to Registry..."
                    . ${VENV_DIR}/bin/activate
                    chmod +x pipeline/push/push.sh
                    ./pipeline/push/push.sh
		    '''
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    sh '''
                    echo "Deploying Application..."
                    . ${VENV_DIR}/bin/activate
                    chmod +x pipeline/deploy/deploy.sh
                    ./pipeline/deploy/deploy.sh
                    '''
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
