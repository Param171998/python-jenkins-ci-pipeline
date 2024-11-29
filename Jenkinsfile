pipeline {
    agent any
    environment {
        ENV_TYPE = "develop"
        PROJECT = "python-app"
        VENV_DIR = ".venv"
        MAIL_FROM = "jenkins@example.com"
        MAIL_TO = "paramwalia1998@gmail.com"
    }
    stages {
        stage('Setup Virtual Environment') {
            steps {
                script {
                    sh '''
                    python3 -m venv ${VENV_DIR}
                    source ${VENV_DIR}/bin/activate
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
                    source ${VENV_DIR}/bin/activate
                    flake8 python-app/src
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    sh '''
                    source ${VENV_DIR}/bin/activate
                    pytest python-app/test
                    '''
                }
            }
        }
        stage('Build Package') {
            steps {
                script {
                    sh '''
                    source ${VENV_DIR}/bin/activate
                    echo "Packaging application..."
                    # Add your Python packaging commands here
                    '''
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh '''
                    source ${VENV_DIR}/bin/activate
                    echo "Deploying application..."
                    # Add your deployment commands here
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
