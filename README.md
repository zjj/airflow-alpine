# airflow-alpine
Airflow Alpine Docker image for Apache Airflow 2.10.5

# Why this project?
The official Airflow image is based on Debian, a large image size (~1.5GB). 

This Alpine-based version provides significant size optimization:
- **Compressed size**: ~110MB (gzipped)
- **Uncompressed size**: ~360MB

# How to build
```
docker build . -t airflow:2.10.5-alpine3.21.3
```

# How to use it
You can use the docker-compose.yaml from https://airflow.apache.org/docs/apache-airflow/2.10.5/docker-compose.yaml
Set the AIRFLOW_IMAGE_NAME to the image you just built.

Follow the guide at https://airflow.apache.org/docs/apache-airflow/2.10.5/howto/docker-compose/index.html.

This repository provides a way to generate an Airflow Docker image with Alpine Linux. Feel free to use the image as needed.

# More information
The airflow-scheduler-autorestart, clean-logs, and entrypoint files are copied from https://github.com/apache/airflow without any changes.

Tested with Airflow 2.10.5 + Alpine 3.21.3.
