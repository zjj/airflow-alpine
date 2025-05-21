# How to build
```
docker build . -t airflow:2.11.0-alpine3.21.3
```

# How to use it
You can use the docker-compose.yaml from https://airflow.apache.org/docs/apache-airflow/2.11.0/docker-compose.yaml
Set the AIRFLOW_IMAGE_NAME to the image you just built.

Follow the guide at https://airflow.apache.org/docs/apache-airflow/2.11.0/howto/docker-compose/index.html.

This repository provides a way to generate an Airflow Docker image with Alpine Linux. Feel free to use the image as needed.

# More information
The airflow-scheduler-autorestart, clean-logs, and entrypoint files are copied from https://github.com/apache/airflow without any changes.
```
docker pull zhong2plus/airflow:2.11.0-alpine3.21.3
```
