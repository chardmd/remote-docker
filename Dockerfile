FROM alpine:3.5

# default Docker API version: override to work with older docker server
ENV DOCKER_API_VERSION 1.30
# default docker client version
ENV DOCKER_VERSION 19.03.7

# add some packages
RUN apk --no-cache add curl bash openssl openssh-client python

# install docker client
RUN curl -o "/tmp/docker-${DOCKER_VERSION}.tgz" -LS "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar -xvzf "/tmp/docker-${DOCKER_VERSION}.tgz" -C /tmp/ && \
    chmod u+x /tmp/docker/docker && mv /tmp/docker/docker /usr/bin/ && \
    rm -rf /tmp/*

# install rdocker script
COPY rdocker.sh /usr/local/bin/rdocker
RUN chmod +x /usr/local/bin/rdocker

CMD ["rdocker"]

# labels for https://microbadger.com/ service
ARG GH_SHA
LABEL org.label-schema.vcs-ref=$GH_SHA \
      org.label-schema.vcs-url="https://github.com/codefresh-io/remote-docker"
