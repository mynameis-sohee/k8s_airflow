FROM apache/airflow:2.2.4-python3.8
USER root
LABEL maintainer="hansohee"

# install own apt dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         vim \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# change back to the airflow user
USER airflow

# copy dags
COPY ./dags /opt/airflow/dags

# requirements.txt install
COPY requirements.txt ./requirements.txt
RUN pip3 install -r requirements.txt
