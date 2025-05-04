FROM alpine:3.21.3


ENV AIRFLOW_UID="50000"
ENV AIRFLOW_USER_HOME_DIR=/home/airflow
ENV AIRFLOW_HOME=/opt/airflow
ENV PATH=${AIRFLOW_USER_HOME_DIR}/.local/bin:${PATH}
ENV PIP=${AIRFLOW_USER_HOME_DIR}/.local/bin/pip
ENV AIRFLOW_EXTRAS="async,celery,postgres,redis,fab,pandas"

COPY ./Dockerfile /Dockerfile
COPY ./entrypoint /entrypoint
COPY ./clean-logs /clean-logs
COPY ./airflow-scheduler-autorestart /airflow-scheduler-autorestart

USER root
RUN apk update && \
    apk add bash curl python3 py3-pybind11 tzdata re2 && \
    apk add py3-pybind11-dev re2-dev gcc python3-dev musl-dev linux-headers g++ && \
    adduser -h ${AIRFLOW_USER_HOME_DIR} -s /bin/bash -G root -D -u ${AIRFLOW_UID} airflow && \
    python -m venv ${AIRFLOW_USER_HOME_DIR}/.local && \
    #${PIP} install "apache-airflow[celery,async,postgres,redis]==3.0.0" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-3.0.0/constraints-3.12.txt" && \
    ${PIP} install "apache-airflow[$AIRFLOW_EXTRAS]==3.0.0" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-3.0.0/constraints-3.12.txt" && \
    apk del py3-pybind11-dev re2-dev gcc python3-dev musl-dev linux-headers g++ && \
    rm -rf ${AIRFLOW_USER_HOME_DIR}/.cache /root/.cache  && \
    (mkdir -p /opt/airflow || true) && \
    chown -R airflow:0 ${AIRFLOW_USER_HOME_DIR} ${AIRFLOW_HOME} && \
    chmod -R g+rw  "${AIRFLOW_USER_HOME_DIR}/.local" ${AIRFLOW_HOME} && \
    chmod g=u /etc/passwd && \
    ln -sfv /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

WORKDIR ${AIRFLOW_HOME}
EXPOSE 8080
USER ${AIRFLOW_UID}
ENTRYPOINT ["/entrypoint"]
CMD []
