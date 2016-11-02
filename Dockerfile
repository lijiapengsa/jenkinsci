FROM   haha123/jenkins

#USER root
#ENV DEBIAN_FRONTEND noninteractive
#RUN \ 
#apt-get update  && \
#apt-get install -y  apt-transport-https ca-certificates && \
#apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D  && \
#echo "deb https://apt.dockerproject.org/repo debian-jessie main"  >>  /etc/apt/sources.list.d/docker.list  && \
#apt-get update && \
#apt-get purge docker.io && \
#apt-get install -y docker-engine
#RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
COPY ./plugins.txt /usr/share/jenkins/plugins.txt
COPY ./plugins.txt /usr/share/jenkins/ref/
#RUN /usr/local/bin/install-plugins.sh   /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh  /usr/share/jenkins/plugins.txt


USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -qqy \
apt-transport-https \
ca-certificates \
curl \
lxc \
git \
gcc \
make \
zlib1g \
zlib1g.dev \
openssl \
libssl-dev \
iptables && \
rm -rf /var/lib/apt/lists/*
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.11.2
ENV DOCKER_SHA256 8c2e0c35e3cda11706f54b2d46c2521a6e9026a7b13c7d4b8ae1f3a706fc55e1
RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && chmod +x /usr/local/bin/docker

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
