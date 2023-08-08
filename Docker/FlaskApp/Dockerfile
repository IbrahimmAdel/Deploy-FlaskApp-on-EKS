FROM python:2.7.18-slim-stretch
EXPOSE 5002
WORKDIR /python-docker
COPY Docker/FlaskApp/requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY Docker/FlaskApp .

CMD [ "python", "app.py" ]
