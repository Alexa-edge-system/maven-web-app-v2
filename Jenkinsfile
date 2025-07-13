pipeline {
  
  agent { label 'node1' }

  tools {
      maven 'maven3.9.10'
  }

  triggers {
      pollSCM('* * * * *')
  }

  options {
      timestamps()
      buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5'))
  }

  environment {
      RECIPIENTS = 'dev-team@example.com'
  }

  stages {

      stage('1. CheckOut Code') {
          steps {
              git branch: 'main',
                  credentialsId: '67641d7e-9990-402d-99bb-c0df8ecccaeb',
                  url: 'https://github.com/Alexa-edge-system/maven-web-app-v2'
          }
      }

      stage('2. Build') {
          steps {
              sh "mvn clean package"
          }
      }
      
      stage('3. SonarQube Code Analysis') {
          steps {
              sh "mvn clean sonar:sonar"
          }
      }

      stage('4. Upload Artifacts to Nexus') {
          steps {
              sh "mvn clean deploy"
          }
      }

      stage('5. Deploy to Tomcat Staging') {
          steps {
              deploy adapters: [
                  tomcat9(
                      credentialsId: 'tomcat-credentials',
                      path: '',
                      url: 'http://3.93.76.143:8080/'
                  )
              ],
              contextPath: null,
              war: 'target/*.war'
          }
      }

      stage('6. Manual Approval for Production') {
          steps {
              input message: "Approve Deployment to Production?", ok: "Deploy Now"
          }
      }

      /*
      stage('7. Deploy to Production') {
          steps {
              deploy adapters: [
                  tomcat9(
                      credentialsId: 'tomcat-credentials',
                      path: '',
                      url: 'http://3.93.76.143:8080/' // Replace with actual prod URL
                  )
              ],
              contextPath: null,
              war: 'target/*.war'
          }
      }
      */
  }

  /*
  post {
      success {
          mail to: "${env.RECIPIENTS}",
               subject: "✅ SUCCESS: Job '${env.JOB_NAME} [#${env.BUILD_NUMBER}]'",
               body: "Build succeeded!\n\nCheck console: ${env.BUILD_URL}"
      }
      failure {
          mail to: "${env.RECIPIENTS}",
               subject: "❌ FAILURE: Job '${env.JOB_NAME} [#${env.BUILD_NUMBER}]'",
               body: "Build failed!\n\nCheck console: ${env.BUILD_URL}"
      }
  }
  */
}
