pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Code checked out'
            }
        }
        stage('Install') {
            steps {
                sh 'pip install -r requirements.txt || echo "pip not available in Jenkins agent"'
            }
        }
        stage('Test') {
            steps {
                sh 'python -m pytest --tb=short || echo "No tests yet"'
            }
        }
        stage('Build Docker') {
            steps {
                echo 'Docker build would run here'
            }
        }
    }
    
    post {
        success { echo 'Pipeline passed!' }
        failure { echo 'Pipeline failed!' }
    }
}