FROM ubuntu:12.04
MAINTAINER Francesco Sullo, sullof@sullof.com, http://sullof.com

RUN apt-get update && apt-get upgrade
RUN apt-get install -y openssh-server python-setuptools && /usr/bin/easy_install supervisor

ADD ./authorized_keys /authorized_keys
ADD ./configure.sh /configure.sh
RUN bin/bash /configure.sh && rm /configure.sh

ADD ./supervisord.conf /etc/supervisord.conf

EXPOSE 22

CMD ["/usr/local/bin/supervisord","-n"]

