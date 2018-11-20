FROM tiangolo/uwsgi-nginx-flask:python3.6

ENV UWSGI_CHEAPER 4
ENV UWSGI_PROCESSES 64

ENV NGINX_WORKER_PROCESSES auto

COPY ./app /app
