# Jenkins Pipeline Documentation

This document provides an overview of the Jenkins pipeline for building and deploying Dockerized applications to AWS ECR and Kubernetes.

## Pipeline Overview

The Jenkins pipeline follows these stages to build, push, and deploy Docker images to AWS ECR and a Kubernetes cluster:

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

```shell
docker build -t ${ECR_REPO}:${APP_IMAGE_NAME}-${BUILD_NUMBER} -f ${APP_PATH} .
docker build -t ${ECR_REPO}:${DB_IMAGE_NAME}-${BUILD_NUMBER} -f ${DB_PATH} .
```

### Push Images
Pushes Docker images to AWS ECR:

```shell
(aws ecr get-login-password --region us-east-1) | docker login -u AWS --password-stdin ${ECR_REPO}
docker push ${ECR_REPO}:${APP_IMAGE_NAME}-${BUILD_NUMBER}
docker push ${ECR_REPO}:${DB_IMAGE_NAME}-${BUILD_NUMBER}
```

### Remove Images
Removes local Docker images:

```shell
docker rmi ${ECR_REPO}:${APP_IMAGE_NAME}-${BUILD_NUMBER}
docker rmi ${ECR_REPO}:${DB_IMAGE_NAME}-${BUILD_NUMBER}
```

### Deploy k8s Manifests
Updates Kubernetes deployment and statefulset manifests and deploys them to an EKS cluster:

```shell
sed -i 's|image:.*|image: ${ECR_REPO}:${APP_IMAGE_NAME}-${BUILD_NUMBER}|g' ${DEPLOTMENT_PATH}
sed -i 's|image:.*|image: ${ECR_REPO}:${DB_IMAGE_NAME}-${BUILD_NUMBER}|g' ${STATEFULSET_PATH}
kubectl apply -f Kubernetes
```

### Website URL
displays the deployed website URL:

```shell
def url = sh(script: 'kubectl get svc flask-app-service -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"', returnStdout: true).trim()
echo "Website url: http://${url}/"
```
### Post-Build Actions
In case of pipeline success or failure, the following messages will be displayed:

```
Success: ${JOB_NAME}-${BUILD_NUMBER} pipeline succeeded
Failure: ${JOB_NAME}-${BUILD_NUMBER} pipeline failed
```

# resources:
- AWS Steps plugin: https://plugins.jenkins.io/pipeline-aws/#plugin-content-withaws

