# Based on <https://github.com/sullof/docker-sshd>

FROM debian:testing

MAINTAINER Álvaro Justen <alvarojusten@gmail.com>


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y openssh-server supervisor && apt-get clean

ADD adds/authorized_keys /authorized_keys
ADD adds/configure.sh /configure.sh
RUN bin/bash /configure.sh && rm /configure.sh
ADD adds/supervisord.conf /etc/supervisord.conf


EXPOSE 22

CMD ["/usr/bin/supervisord", "-n"]
