FROM python:3.6.5-alpine3.7

WORKDIR /app
ADD . /app

RUN apk add --no-cache \
  libc-dev \
  gcc \
  libc-dev \
  linux-headers \
  mariadb-dev \
  python3-dev \
  postgresql-dev

RUN pip install --trusted-host pypi.python.org flask
RUN pip install --trusted-host pypi.python.org mysqlclient

EXPOSE 80

cmd ["python", "app.py"]

