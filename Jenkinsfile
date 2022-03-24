
pipeline {
    agent any
    tools {
      terraform 'terraform'
    }
    tools {
      maven 'maven3'
    }
    tools {
        nodejs "node"
    }
    environment{
        // choice(name: 'action', choices: 'create\ndestroy', description: 'Create/update or destroy the eks cluster.')
        dockerImage = ''
        registry = 'jaymezon/jumia_phone_validator' 
        registryCredential = 'docker_hub'
    }
    stages {
        stage ('Build jar - Backend') {
            steps {
                sh 'mvn -f validator-backend/pom.xml clean install'         
            }
        }
        stage ('Build Frontend') {
            steps {
                sh 'npm install' 
                sh 'npm run build'      
            }
        }
        stage('Test') {
            steps {
                sh 'node test'
            }
        }
        stage('Build Backend image push') {
            steps {
                 // Build and push image with Jenkins' docker-plugin
                sh 'docker build --file=validator-backend/Dockerfile  -t validator-backend-image . '
                withDockerRegistry([credentialsId: "docker_hub", url: "https://index.docker.io/v1/"]) {
                    image = docker.build("jaymezon/jumia_phone_validator", "jumia_phone_validator/validator-backend-image")                    
                    image.push()    
                }
            }
        }
        stage('Build Frontend image push') {
            steps {
                 // Build and push image with Jenkins' docker-plugin
                sh 'docker build --file=validator-frontend/Dockerfile  -t validator-frontend-image . '   
                withDockerRegistry([credentialsId: "docker_hub", url: "https://index.docker.io/v1/"]) {
                    image = docker.build("jaymezon/jumia_phone_validator", "jumia_phone_validator/validator-frontend-image")  
                    image.push()    
                }                
            }
        }
        stage('Docker Compose') {
            steps {
                sh 'docker-compose -f docker-compose.yml up '
            }
        }
        
        stage('Terraform Plan') {            
            steps {
                script {
                dir('eksterraform') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh """
                        terraform init
                        terraform workspace new ${params.cluster} || true
                        terraform workspace select ${params.cluster}
                        terraform plan \
                            -var cluster-name=${params.cluster} \
                            -out ${plan}
                        echo ${params.cluster}
                       """
                        }
                    }
                }
            }
        }
        stage('Terraform Apply') {            	
            steps {
                script {
                    dir('eksterraform') {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        if (fileExists('$HOME/.kube')) {
                            echo '.kube Directory Exists'
                        } else {
                        sh 'mkdir -p $HOME/.kube'
                        }
                        sh """
                            terraform apply -input=false -auto-approve ${plan}
                            terraform output kubeconfig > $HOME/.kube/config
                        """
                        sh 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'
                        sleep 30
                        sh 'kubectl get nodes'
                        }
                    }
                }
            }
        }   
        stage ('K8S Deploy') {
            steps {
                kubernetesDeploy(
                    configs: 'jumia_phone_validator/production.tfvars',
                    kubeconfigId: 'K8S',
                    enableConfigSubstitution: true
                    )               
            }
        }           
    //     stage('Terraform Destroy') {           
    //         steps {
    //             script {
    //                 dir('eksterraform') {
    //                 withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
    //                 sh """
    //                 terraform workspace select ${params.cluster}
    //                 terraform destroy -auto-approve
    //                 """
    //                 }
    //             }
    //         }
    //     }         
    // }
    }
}