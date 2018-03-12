FROM centos:7
MAINTAINER 'Jordan Wamser <jwamser@redpandacoding.com>'

ENV DEV_SERVER='' PROJECT_NAME='Symfony' DOMAINS='_' FPM_HOST=127.0.0.1 FPM_HOST=9000

RUN yum update -y && \
    yum install -y epel-release

RUN yum install -y nginx

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./sites/. /etc/nginx/conf.d
COPY ./config/create_nginx_server /usr/local/bin

#RUN useradd -M -d /opt/app -s /bin/false nginx
#RUN chown -R nginx:nginx /opt/app

RUN yum clean all

CMD create_nginx_server && nginx