// pipeline {
//     agent any
//     // tools {
//     //   terraform 'terraform'
//     // }
//     // tools {
//     //   maven 'maven3'
//     // }
//     environment{
//         choice(name: 'action', choices: 'create\ndestroy', description: 'Create/update or destroy the eks cluster.')
//         dockerImage = ''
//         registry = 'jaymezon/validator-backend-image'
//         registry = 'jaymezon/validator-frontend-image'
//         registryCredential = 'dockerhub_id'
//     }
//     stages {
//         stage ('Build jar - Backend') {
//             steps {
//                 sh 'mvn -f validator-backend/pom.xml clean install'         
//             }
//         }
//         stage ('Build Frontend') {
//             steps {
//                 sh 'npm install' 
//                 sh 'npm run build'      
//             }
//         }
//         stage('Build Docker image') {
//            steps {
//                script{
//                   dockerImage = docker.build registry 
//                }           
//            }
//         }
//           // Uploading Docker images into Docker Hub
//         stage('Upload Image') {
//             steps{    
//                 script {
//                     docker.withRegistry( '', registryCredential ) {
//                     dockerImage.push()
//                     }
//                 }
//             }
//         }
//         // Stopping Docker containers for cleaner Docker run
//         stage('docker stop container') {
//             steps {
//                 sh 'docker ps -f name=vidaaltor-backend-image -q | xargs --no-run-if-empty docker container stop'
//                 sh 'docker container ls -a -fname=validator-backend-image -q | xargs -r docker container rm'
//                  sh 'docker ps -f name=validator-frontend-image -q | xargs --no-run-if-empty docker container stop'
//                 sh 'docker container ls -a -fname=validator-frontend-image -q | xargs -r docker container rm'
//             }
//         }
//         // Stopping Docker containers for cleaner Docker run
//         stage('docker stop container') {
//             steps {
//                 script{
//                     dockerImage.run("-p 8080:8080 --rm vidaaltor-backend-image")
//                     dockerImage.run("-p 8081:8081 --rm validator-frontend-image")
//                 }
//                 // sh 'docker ps -f name=vidaaltor-backend-image -q | xargs --no-run-if-empty docker container stop'
//                 // sh 'docker container ls -a -fname=vidaaltor-backend-image -q | xargs -r docker container rm'
//                 // sh 'docker ps -f name=validator-frontend-image -q | xargs --no-run-if-empty docker container stop'
//                 // sh 'docker container ls -a -fname=validator-frontend-image -q | xargs -r docker container rm'
//             }
//         }

//         stage('TF Plan') {
//         when {
//             expression { params.action == 'create' }
//             }	
//             steps {
//                 script {
//                 dir('eksterraform') {
//                     withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
//                     sh """
//                         terraform init
//                         terraform workspace new ${params.cluster} || true
//                         terraform workspace select ${params.cluster}
//                         terraform plan \
//                             -var cluster-name=${params.cluster} \
//                             -out ${plan}
//                         echo ${params.cluster}
//                     """
//                     }
//                 }
//             }
//         }
//         }
//         stage('TF Apply') {
//         when {
//             expression { params.action == 'create' }
//             }	
//             steps {
//                 script {
//                 dir('eksterraform') {
//                     withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
//                     if (fileExists('$HOME/.kube')) {
//                         echo '.kube Directory Exists'
//                     } else {
//                     sh 'mkdir -p $HOME/.kube'
//                     }
//                     sh """
//                         terraform apply -input=false -auto-approve ${plan}
//                         terraform output kubeconfig > $HOME/.kube/config
//                     """
//                     sh 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'
//                     sleep 30
//                     sh 'kubectl get nodes'
//                     }
//                 }
//             }
//         }
//         }
//         stage('TF Destroy') {
//         when {
//             expression { params.action == 'destroy' }
//         }
//         steps {
//             script {
//                 dir('eksterraform') {
//                     withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
//                     sh """
//                     terraform workspace select ${params.cluster}
//                     terraform destroy -auto-approve
//                     """
//                     }
//                 }
//             }
//         }
//         }

        // stage('docker-compose') {
        //    steps {
        //     //   sh "docker-compose build"
        //       sh "docker-compose up -d"
        //    }
        // }

        // stage ("Build backend") {
        //     steps {
        //         withMaven(globalMavenSettingsConfig: 'null', jdk: 'null', maven: 'maven3', mavenSettingsConfig: 'null') {
        //             // some block
        //         }
        //     }
        // }
        // stage('Build Frontend') {
        //     steps { 
        //         sh 'npm install'
        //     }
        // }
        
        // stage ("terraform init") {
        //     steps {
        //         sh 'terraform init'
        //     }
        // }
        // stage ("terraform fmt") {
        //     steps {
        //         sh 'terraform fmt'
        //     }
        // }
        // stage ("terraform validate") {
        //     steps {
        //         sh 'terraform validate'
        //     }
        // }
        // stage ("terrafrom plan") {
        //     steps {
        //         sh 'terraform plan '
        //     }
        // }
        // stage ("terraform apply") {
        //     steps {
        //         sh 'terraform apply --auto-approve'
        //     }
        // }
       
        
    //     // Building Docker images
    //     stage('Building image') {
    //         steps{
    //             script {
    //             dockerImage = docker.build registry 
    //             }
    //         }
    //     }

    

    
//     }
// }



// pipeline 2
pipeline {
    agent any

    // tools {
    //   terraform 'terraform'
    // }
    // tools {
    //   maven 'maven3'
    // }

    stages {
        stage ('Build jar - Backend') {
            steps {
                sh 'mvn -f validator-backend/pom.xml clean install'         
            }
        }
        // stage ('Build Frontend') {
        //     steps {
        //         sh 'npm install' 
        //         sh 'npm run build'      
        //     }
        // }      
        
        stage ('Docker Build and push to Dockerhub') {
            steps {
            // Build and push image with Jenkins' docker-plugin
                withDockerRegistry([credentialsId: "dockerhub_id", url: "https://index.docker.io/v1/"]) {
                image = docker.build("jaymezon/jumia-phone-number-validator", "jumia_phone_validator")
                // image = docker.build("jaymezon/validator-backend-image", "jumia-phone-number-validator/validator-backend")
                // image = docker.build("jaymezon/validator-frontend-image", "jumia-phone-number-validator/validator-frontend")
                image.push()    
                }
            }
        }
        // stage ("terraform init") {
        //     steps {
        //         sh 'terraform init'
        //     }
        // }
        // stage ("terrafrom plan") {
        //     steps {
        //         sh 'terraform plan '
        //     }
        // }
        // stage ("terraform apply") {
        //     steps {
        //         sh 'terraform apply --auto-approve'
        //     }
        // }

        // stage ('K8S Deploy') {
        //     steps {
        //         kubernetesDeploy(
        //             configs: 'jumia-phone-number-validator/production.tfvars',
        //             kubeconfigId: 'K8S',
        //             enableConfigSubstitution: true
        //             )               
        //     }
        // }
    }    


}