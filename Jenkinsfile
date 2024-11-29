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
                    . ${VENV_DIR}/bin/activate
                    sh 'bash pipeline/quality/quality.sh'
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    sh '''
                    . ${VENV_DIR}/bin/activate
                    sh 'bash pipeline/test/test.sh'
                    '''
                }
            }
        }
        stage('Build Package') {
            steps {
                script {
                    sh '''
                    . ${VENV_DIR}/bin/activate
                    echo "Packaging application..."
                    # Add your Python packaging commands here
		    sh 'bash pipeline/build/build.sh'
                    '''
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh '''
                    . ${VENV_DIR}/bin/activate
                    echo "Deploying application..."
                    # Add your deployment commands here
		    sh 'bash pipeline/deploy/deploy.sh'
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
