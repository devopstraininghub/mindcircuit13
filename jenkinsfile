pipeline {
    agent any

    stages {
        stage('CLONE SCM') {
            steps {
                echo 'Cloning Mc-app project code'
				git branch: 'main', url: 'https://github.com/devopstraininghub/mindcircuit13.git'
            }
        }
		
		stage('Build Artifact ') {
            steps {
                echo 'generating artifact with maven build tool'
				sh 'mvn clean install'
            }
        }
		
		stage('Deploy to tomcat') {
            steps {
                echo 'Deploying artifact to tomcat webserver '
				deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://52.201.234.58:8091/')], contextPath: 'facebook-app', war: '**/*.war'
            }
        }
    }
}
