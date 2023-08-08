# Flask App & MySQL
> A small web app that allow users to create account, login, and make a bucket list.
> This app is implemented using MySQL and Python. Copied from the tutorial http://code.tutsplus.com/tutorials/creating-a-web-app-from-scratch-using-python-flask-and-mysql--cms-22972

# Dockerized Flask App and MySQL Database
> This document provides an overview of the Dockerized Flask app and MySQL database setup using Docker Compose.

## Overview

This document demonstrates how to run a simple Flask app and MySQL database in Docker containers using Docker Compose. The repository contains Dockerfiles for both the Flask app and MySQL database, as well as a `docker-compose.yml` file to define the services and their configuration.

## Getting Started
- Make sure you have Docker and Docker Compose installed on your system.

1. Clone the repository:

```
git clone https://https://github.com/IbrahimmAdel/Full-CICD-Project/
```

2. Build and run the Docker containers using Docker Compose:  [compose.yaml](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Docker/compose.yaml)
```
docker-compose up -d
```
3. Access the Flask app in your web browser at http://localhost:5000.


- Docker file for flask app : ![Dockerfile](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Docker/FlaskApp/Dockerfile)
- Docker file for DataBase : ![Dockerfile](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Docker/MySQL_DB/Dockerfile)



