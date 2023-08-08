# Kubernetes Deployment and StatefulSet for Flask App and MySQL Database

This document provides detailed instructions for deploying a Flask app and MySQL database using Kubernetes Deployment and StatefulSet.

## Project Overview

This project demonstrates how to deploy a Flask app and MySQL database as Kubernetes services using Deployment and StatefulSet controllers.

## Prerequisites

- Kubernetes cluster (EKS, Minikube, etc.).
- `kubectl` CLI installed and configured.

## Deployment
- The Flask app is deployed using a Kubernetes Deployment.

```
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
        - name: flask-app-container
          image: flaskapp
          ports:
            - containerPort: 5002
          resources:   
            limits:
              cpu: "1"   
              memory: "512Mi"   
            requests:
              cpu: "0.5"   
              memory: "128Mi" 

```
Apply the deployment configuration:

```
kubectl apply -f deployment.yaml
```

## StatefulSet
- The MySQL database is deployed using a Kubernetes StatefulSet.

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db-statefulset
spec:
  serviceName: mysql-service
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql
          image: db
          ports:
            - containerPort: 3306
          # Add environment variables, volume mounts, etc.

```
Apply the StatefulSet configuration:

```
kubectl apply -f statefulset.yaml
```
## Services

# service-app.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: flask-app-service
spec:
  selector:
    app: flask-app
  type: LoadBalancer
  ports:
    - port: 80
      targetPort: 5002
```
# service-db.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
spec:
  selector:
    app: mysql
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
```
Apply the service configurations:
```
kubectl apply -f service-app.yaml
kubectl apply -f service-db.yaml
```
Usage
Access the Flask app by visiting the LoadBalancer IP or URL.



