pipeline{
	environment {
    IMAGE_ID="$JOB_NAME:$BUILD_NUMBER"
	IMAGE="snaidu/$IMAGE_ID"
  }
    agent any
    parameters {        
		string(name: 'email', defaultValue: 'tamellaravi789@gmail.com', description: 'Email build notification')        
    }
        stages{
        stage('git clone'){
            steps{
                git 'https://github.com/satishnaidu143/petclinic.git'
            }
        }
        stage('package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('archive artifacts'){
            steps{
                archiveArtifacts 'target/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar'
            }
        }
        stage('junit reports'){
            steps{
                junit 'target/surefire-reports/*.xml'
            }
        }

	    stage('SonarQube analysis') {
 			steps{
    // performing sonarqube analysis with "withSonarQubeENV(<Name of Server configured in Jenkins>)"
       withSonarQubeEnv('petclinic') {
       // requires SonarQube Scanner for Maven 3.2+
       sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.2:sonar'
      sh 'mvn sonar:sonar \
       -Dsonar.host.url=https://13.126.223.192:9000 \
       -Dsonar.login=f01b79ae83096855a6918e2a530c455f5ccc2ef8'
 	    }
      }	
   }
		stage('Pushing image to DockerHub') {
            steps {
             sh label: '', script: '''pwd
			 whoami
			 sudo scp /var/lib/jenkins/workspace/$JOB_NAME/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar /var/lib/jenkins/workspace/$JOB_NAME
			  docker image build -t $IMAGE_ID .
              docker tag $IMAGE_ID $IMAGE
			  docker push $IMAGE
			  docker rmi openjdk:8u212-jdk-alpine3.9 $IMAGE_ID $IMAGE '''
       }
	}
	stage('updating latest image'){
            steps{
                sh("sed -i.bak 's#snaidu/petclinic:1#${IMAGE}#' ./deployment.yml")
            }
        }
	  stage('k8s Deployment') {
            steps {
             sh label: '', script: '''
			  kubectl apply -f namespaces.yml
			  kubectl apply -f deployment.yml 
			  kubectl apply -f service.yml '''
      }
   }
}
    post {		
		success {
			echo "Sending successful email"
			emailext (
				subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
				body: """build success ra pulka poye chusukooo""",
				to: "${params.email}",
				mimeType: 'text/html'
			)
			echo "Sent email"
		}
		failure {
			echo "Emailing failed build"
			emailext (
				subject: "FAILURE: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
				body: """build fail ra pulka poye chusuko""",
				to: "${params.email}",
				mimeType: 'text/html'
			)
			echo "Sent email!"
		}
		unstable {
			echo "Emailing unstable build"
			emailext (
				subject: "UNSTABLE: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
				body: """build theda iyendhi ra pulka poye chusukooo""",
				to: "${params.email}",
				mimeType: 'text/html'
			)
			echo "Sent email!"
		}		
	}      
}
