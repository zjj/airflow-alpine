FROM alpine:3.21.3


ENV AIRFLOW_UID="50000"
ENV AIRFLOW_USER_HOME_DIR=/home/airflow
ENV AIRFLOW_HOME=/opt/airflow
ENV PATH=${AIRFLOW_USER_HOME_DIR}/.local/bin:${PATH}
ENV PIP=${AIRFLOW_USER_HOME_DIR}/.local/bin/pip


COPY ./Dockerfile /Dockerfile
COPY ./entrypoint /entrypoint
COPY ./clean-logs /clean-logs
COPY ./airflow-scheduler-autorestart /airflow-scheduler-autorestart

USER root
RUN apk update && \
    apk add bash curl && \
    apk add python3 py3-pybind11 py3-pybind11-dev re2-dev gcc python3-dev musl-dev linux-headers g++ tzdata re2 && \
    adduser -h ${AIRFLOW_USER_HOME_DIR} -s /bin/bash -G root -D -u ${AIRFLOW_UID} airflow && \
    python -m venv ${AIRFLOW_USER_HOME_DIR}/.local && \
    ${PIP} install psycopg2-binary && \
    ${PIP} install "apache-airflow[celery,async,postgres,redis]==2.10.5" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.10.5/constraints-3.12.txt" && \
    ${PIP} install pendulum==3.1.0 && \
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
