pipeline {
    agent any


       tools {
        maven 'maven3'
    }

    stages {
      stage('checkout') {
            steps {
                echo 'Cloning GIT HUB Repo '
				git branch: 'main', url: 'https://github.com/devopstraininghub/mindcircuit13.git'
            }  
        }
		
		
		
	 stage('sonar') {
            steps {
                echo 'scanning project'
                sh 'ls -ltr'
                
                sh ''' mvn sonar:sonar \\
                      -Dsonar.host.url=http://44.210.116.12:9000 \\
                      -Dsonar.login=squ_a46b6947d43a812180415ff94219120d2ddebcea'''
            }
    	}
		
		
		
        stage('Build Artifact') {
            steps {
                echo 'Build Artifact'
				sh 'mvn clean package'
            }
        }
		
		
		
        stage('Docker Image') {
            steps {
                echo 'Docker Image building'
				sh 'docker build -t devopshubg333/batch13:${BUILD_NUMBER} .'
            }
        }
		
		
       stage('Push to Dockerhub') {
            steps {
			 script {
			withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) 
			{
            sh 'docker login -u devopshubg333 -p ${dockerhub}'
			
			 }
			   sh 'docker push devopshubg333/batch13:${BUILD_NUMBER}'
			   
           
				}
				
            }
        }
		
		
    stage('Update Deployment File') {
		
		 environment {
            GIT_REPO_NAME = "mindcircuit13"
            GIT_USER_NAME = "devopstraininghub"
        }
		
            steps {
                echo 'Update Deployment File'
				withCredentials([string(credentialsId: 'githubtoken', variable: 'githubtoken')]) 
				{
                  sh '''
                    git config user.email "gorekarmadhu@gmail.com"
                    git config user.name "Madhu"
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s/batch13:.*/batch13:${BUILD_NUMBER}/g" deploymentfiles/deployment.yml
                    git add .
                    
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"

                    git push https://${githubtoken}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                '''
				  
                 }
				
            }
        }
		
		
			
    }

}
