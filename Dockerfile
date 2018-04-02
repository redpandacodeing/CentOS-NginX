FROM centos:7
MAINTAINER 'Jordan Wamser <jwamser@redpandacoding.com>'

ENV DEV_SERVER='1' PROJECT_NAME='Symfony' DOMAINS='_' FPM_HOST=127.0.0.1 FPM_PORT=9000
#ENV APP_ENV='prod'

RUN yum update -y && \
    yum install -y epel-release \
    && yum install -y nginx

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./sites/. /etc/nginx/conf.d
COPY ./config/create_nginx_server /usr/local/bin

RUN mkdir /opt/app \
#    && useradd -M -d /opt/app -s /bin/false nginx \
    && chown -R root:nginx /opt

RUN yum clean all

CMD 'create_nginx_server'