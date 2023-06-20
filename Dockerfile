FROM ubuntu:22.04

MAINTAINER Tin Benjamin Matuka <mail@tbmatuka.com>

# install apps all in one run and clean up afterwards to reduce the snapshot size
RUN apt-get clean && \
    apt-get -y update && \
    apt-get install -y --force-yes \
        curl \
        jq \
        wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add www-data to sudoers
COPY ./sudoers /etc/sudoers.d/www-data

# prepare www-data to be used as main user
RUN usermod -s /bin/bash -G staff www-data && \
    mkdir -p /var/www /app && \
    touch /var/www/.bash_profile && \
    chown -R www-data. /var/www /app

# this lets us make our run behave differently if needed
ENV DOCKER="yes"

WORKDIR /app/

USER www-data

ENTRYPOINT []

CMD []
