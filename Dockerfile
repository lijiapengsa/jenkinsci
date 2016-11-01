FROM   haha123/jenkins

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update  && apt-get purge   lxc-docker*  docker.io*
RUN apt-get install -y  apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN \
echo "deb https://apt.dockerproject.org/repo debian-jessie main" tee /etc/apt/sources.list.d/docker.list && \
apt-get update && \
apt-get install docker-engine


COPY plugins.txt /usr/share/jenkins/plugins.txt
#RUN /usr/local/bin/install-plugins.sh /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt


