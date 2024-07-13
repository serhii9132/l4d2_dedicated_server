pipeline{
    agent {
        label 'master'
    }

    options{
        skipDefaultCheckout()
    }

    environment {
        DOCKER_TAG_IMAGE = 'serhiiartiukh5465/l4d2_dedicated_server'
        USER_NAME = 'steam_user'
        USER_ID = 47120
        PORT_SERVER = 27015
        PATH_SERVER = "/home/${USER_NAME}/files_server"
    }

    stages {
        stage('Checkout'){
            steps {
                git branch: 'main', 
                credentialsId: 'github_repo_cred', 
                poll: false, 
                url: 'git@github.com:Serhii5465/l4d2_dedicated_server.git'
            }
        }

        stage('Build image'){
            steps{
                script{
                    sh "docker build . -t ${env.DOCKER_TAG_IMAGE} --build-arg PORT_SERVER=${env.PORT_SERVER} \
                        --build-arg PATH_SERVER=${env.PATH_SERVER}  --build-arg USER_NAME=${env.USER_NAME} \
                        --build-arg USER_ID=${env.USER_ID}"
                    
                }
            }
        }

        stage('Push to DockerHub'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-token', passwordVariable: 'pass', usernameVariable: 'username')]) {
                        sh('echo ${pass} | docker login -u $username --password-stdin')
                        sh "docker push ${env.DOCKER_TAG_IMAGE}"
                    }
                }
            }
            post {
                always {
                    sh "docker logout"
                }
            }
        }
    }

    post {
        success {
            sh "docker image rm ${env.DOCKER_TAG_IMAGE} && docker buildx prune -f"
        }
    }
}