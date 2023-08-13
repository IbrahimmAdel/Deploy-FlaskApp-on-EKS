# Jenkins Pipeline 

> This document provides an overview of the Jenkins pipeline for building and deploying Dockerized applications to AWS EKS.

## Requirements
- install [AWS Steps plugin](https://plugins.jenkins.io/pipeline-aws/#plugin-content-withaws)


## Pipeline Overview

The Jenkins pipeline follows these stages to build, push, and deploy Docker images to AWS ECR and an EKS cluster:

1. **Build Images:** Build and tag Docker images for the Flask App and MySQL DB.

2. **Push Images:** Push Docker images to AWS ECR after logging in using AWS credentials.

3. **Remove Images:** Remove local Docker images from the Jenkins server.

4. **Deploy k8s Manifests:** Update Kubernetes deployment and statefulset manifests with new ECR image versions and deploy them to an EKS cluster.

5. **Website URL:** Retrieve the URL of the deployed website and display it in the console.

## Environment Variables

The following environment variables are used in the Jenkins pipeline:

- `ECR_REPO`: ECR repository URI.
- `APP_IMAGE_NAME`: Name of the Flask App image.
- `DB_IMAGE_NAME`: Name of the MySQL DB image.
- `APP_PATH`: Path to the App Dockerfile in the GitHub repo.
- `DB_PATH`: Path to the DB Dockerfile in the GitHub repo.
- `DEPLOTMENT_PATH`: Path to the deployment.yml in the GitHub repo.
- `STATEFULSET_PATH`: Path to the statefulset.yml in the GitHub repo.
- `AWS_CREDENTIALS_ID`: AWS credentials variable ID in jenkins-credentials.
- `KUBECONFIG_ID`: EKS-cluster credentials variable ID in jenkins-credentials.

## Pipeline Steps

### Build Images

Builds Docker images for the Flask App and MySQL DB:

```
 stage('Build Images') {
            steps {
                // build and tag images to push them to ECR
                sh "docker build -t ${ECR_REPO}:${APP_IMAGE_NAME}-${BUILD_NUMBER} -f ${APP_PATH} ."
                sh "docker build -t ${ECR_REPO}:${DB_IMAGE_NAME}-${BUILD_NUMBER} -f ${DB_PATH} ."
            }
        }
```

### Push Images
Pushes Docker images to AWS ECR:

```
stage('Push Images') {
            steps {
                withAWS(credentials: "${AWS_CREDENTIALS_ID}"){
                    sh "(aws ecr get-login-password --region us-east-1) | docker login -u AWS --password-stdin ${ECR_REPO}"
                    sh "docker push ${ECR_REPO}:${APP_IMAGE_NAME}-${BUILD_NUMBER}"
                    sh "docker push ${ECR_REPO}:${DB_IMAGE_NAME}-${BUILD_NUMBER}" 
                }
            }
        }
```

### Remove Images
Removes local Docker images:

```
stage('Remove Images') {
            steps {
                // delete images from jenkins server
                sh "docker rmi ${ECR_REPO}:${APP_IMAGE_NAME}-${BUILD_NUMBER}"
                sh "docker rmi ${ECR_REPO}:${DB_IMAGE_NAME}-${BUILD_NUMBER}"
            }
        }

```

### Deploy k8s Manifests
Updates Kubernetes deployment and statefulset manifests and deploys them to an EKS cluster:

```
 stage('Deploy k8s Manifests') {
            steps {
                // update images in deployment & statefulset manifists with ECR new images
                sh "sed -i 's|image:.*|image: ${ECR_REPO}:${APP_IMAGE_NAME}-${BUILD_NUMBER}|g' ${DEPLOTMENT_PATH}"
                sh "sed -i 's|image:.*|image: ${ECR_REPO}:${DB_IMAGE_NAME}-${BUILD_NUMBER}|g' ${STATEFULSET_PATH}"
                    
                //Deploy kubernetes manifists in EKS cluster
                withAWS(credentials: "${AWS_CREDENTIALS_ID}"){
                    withCredentials([file(credentialsId: "${KUBECONFIG_ID}", variable: 'KUBECONFIG')]) {
                        sh "kubectl apply -f Kubernetes"   // 'Kubernetes' is a directory contains all kubernetes manifists
                    }                          
                }
            }
        }
```

### Website URL
displays the deployed website URL:

```
stage('Website URL') {
            steps {
                script {
                    withAWS(credentials: "${AWS_CREDENTIALS_ID}"){
                        withCredentials([file(credentialsId: "${KUBECONFIG_ID}", variable: 'KUBECONFIG')]) {
                            def url = sh(script: 'kubectl get svc flask-app-service -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"', returnStdout: true).trim()
                            echo "Website url: http://${url}/"
                        }
                    }
                }
            }
        }


```
### Post-Build Actions
In case of pipeline success or failure, the following messages will be displayed:

```
post {
        success {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline succeeded"
        }
        failure {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline failed"
        }
    }
```
----
### - Webhook i created with `ngrok`
![](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Screenshots/webhook.png)
---

### - App URL output 
![](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Screenshots/print_app_url.png)
---
### - Application 
![](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Screenshots/app.png)

---
### - Kubernetes objects
![](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Screenshots/k8s%20objects.png)

