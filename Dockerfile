FROM        ubuntu:16.04
MAINTAINER  einluxlab@gmail.com

# A layer is created for each command ex)RUN, ENV, COPY, etc...
RUN         apt-get -y update
RUN         apt-get -y install python3 python3-pip
RUN         apt-get -y install nginx
RUN         apt-get -y install python-dev libpq-dev
RUN         apt-get -y install supervisor

WORKDIR     /srv
RUN         mkdir app

COPY        . /srv/app
WORKDIR     /srv/app

RUN         pip3 install -r requirements.txt
RUN         pip3 install uwsgi
ENV         DEBUG="False" \
            STATIC="s3" \
            LOG="INFO"

COPY        .conf/uwsgi-app.ini         /etc/uwsgi/sites/app.ini
COPY        .conf/nginx.conf            /etc/nginx/nginx.conf
COPY        .conf/nginx-app.conf        /etc/nginx/sites-available/app.conf
COPY        .conf/supervisor-app.conf   /etc/supervisor/conf.d/
COPY        .conf/docker-entrypoint.sh  /

RUN         ln -s /etc/nginx/sites-available/app.conf   /etc/nginx/sites-enabled/app.conf

EXPOSE      80
CMD         supervisord -n
ENTRYPOINT  ["/docker-entrypoint.sh"]
