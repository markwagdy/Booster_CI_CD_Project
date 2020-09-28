pipeline {
    agent {label 'slavenode'}
    stages {

        stage('build') {
            steps {
              sh 'docker build -f Dockerfile . -t markwagdy/projectdev:v1.0 '
            }
            }

        stage('push') {
            steps {
              withCredentials([usernamePassword(credentialsId:"docker",usernameVariable:"USERNAME",passwordVariable:"PASSWORD")]){
              sh 'docker login --username $USERNAME --password $PASSWORD'
              sh 'docker push markwagdy/projectdev:v1.0'
              }
            }
        }

        stage('deploy') {
          steps {
            sh 'docker run -d -p 8001:8000 markwagdy/projectdev:v1.0'
        }
        }
    }

    post {
      success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME}  [${env.BUILD_NUMBER}]' (${env.BUILD_URL}console)")
      }
      failure{
      slackSend (color: '#E83009', message: "Failure: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL}console)") 
    }

    }
}
