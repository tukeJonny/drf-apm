FROM python:3.5

ENV DJANGO_SETTINGS_MODULE "drf_apm.settings.prod"
ENV DEBIAN_FRONTEND "noninteractive"

RUN apt update && \
      apt install -y mysql-client python3-dev libmysqlclient-dev

RUN mkdir -p /var/log/gunicorn
RUN mkdir -p /var/run/gunicorn

COPY drf_apm /opt/app/src
COPY Pipfile /opt/app/src/Pipfile
COPY Pipfile.lock /opt/app/src/Pipfile.lock
COPY files/gunicorn_config.py /opt/app/src/gunicorn_config.py
COPY files/entrypoint.sh /opt/app/src/entrypoint.sh
RUN chmod +x /opt/app/src/entrypoint.sh
WORKDIR /opt/app/src

RUN pip install pipenv
RUN pipenv install --system --deploy

EXPOSE 8000

ENTRYPOINT ["/opt/app/src/entrypoint.sh"]
CMD ["db", "drf_apm", "drfapmtest"]
