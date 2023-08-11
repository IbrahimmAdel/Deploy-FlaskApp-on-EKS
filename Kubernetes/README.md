# Kubernetes Deployment and StatefulSet for Flask App and MySQL Database

> This document provides detailed instructions for deploying a Flask app and MySQL database using Kubernetes Deployment and StatefulSet.

## Overview

This project demonstrates how to deploy a Flask app and MySQL database as Kubernetes services using Deployment and StatefulSet controllers.

## Prerequisites

- Kubernetes cluster (EKS, Minikube, etc.).
- `kubectl` CLI installed and configured.

## Deployment
- The Flask app is deployed using a Kubernetes Deployment.

```
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
              
          env:
            - name: MYSQL_DATABASE_DB
              valueFrom:
                configMapKeyRef:
                  name: configmap
                  key: MYSQL_DATABASE
                  
            - name: MYSQL_DATABASE_HOST
              valueFrom:
                configMapKeyRef:
                  name: configmap
                  key: MYSQL_DATABASE_HOST
                  
            - name: MYSQL_DATABASE_USER
              valueFrom:
                configMapKeyRef:
                  name: configmap
                  key: MYSQL_DATABASE_USER
                  
            - name: MYSQL_DATABASE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: secrets
                  key: MYSQL_DATABASE_PASSWORD

          readinessProbe:
            httpGet:
              path: /           
              port: 5002
            initialDelaySeconds: 10   
            periodSeconds: 5         

          livenessProbe:
            httpGet:
              path: /           
              port: 5002
            initialDelaySeconds: 30   
            periodSeconds: 10         

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

          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: secrets
                  key: MYSQL_ROOT_PASSWORD

          ports:
            - containerPort: 3306

          volumeMounts:
            - name: mysql-persistent-storage
              mountPath: /var/lib/mysql

      volumes:
        - name: mysql-persistent-storage
          persistentVolumeClaim:
            claimName: pvc
```
Apply the StatefulSet configuration:

```
kubectl apply -f statefulset.yaml
```
# Services

## deployment_service.yaml
- loadbalancer service for the deployment
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
## statefulset_service.yaml
- ClusterIP service for the statefulset
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
kubectl apply -f deployment_service.yaml
kubectl apply -f statefulset_service.yaml
```
# configmap.yaml
```
apiVersion: v1
kind: ConfigMap 
metadata:
  name: configmap 
data:
  MYSQL_DATABASE_USER: "root"
  MYSQL_DATABASE_HOST: "mysql-service"
  MYSQL_DATABASE: "BucketList"
```
# secrets.yaml
```
apiVersion: v1
kind: Secret
metadata:
  name: secrets
data:
  MYSQL_DATABASE_PASSWORD: aWJyYWhpbTEyMw==
  MYSQL_ROOT_PASSWORD: aWJyYWhpbTEyMw==
```
# pv.yaml
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  capacity:
    storage: 5Gi  
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: ebs-storage-class
  hostPath:
    path: /var/lib/mysql    
```
# pvc.yaml
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi 
  storageClassName: ebs-storage-class 
```
# ingress.yaml
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: cluster-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
      - http:
         paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: flask-app-service
                port:
                  number: 80
```
----
## Usage
Access the Flask app by visiting the LoadBalancer IP or URL.



