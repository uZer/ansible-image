FROM alpine:latest
LABEL Description="Ansible Base image" Vendor="TheVoid" Version="1.0"
MAINTAINER Youenn Piolet <piolet.y@gmail.com>

# Install base packages and ansible
ADD requirements.txt /opt/
RUN ln -s /lib /lib64 \
    && apk --upgrade add --no-cache \
            sudo \
            git \
            python \
            py-pip \
            openssl \
            ca-certificates \
            sshpass \
            openssh-client \
            rsync \
    && apk --upgrade add --no-cache --virtual \
            build-dependencies \
            build-base \
            python-dev \
            openssl-dev \
            libffi-dev \
    && pip install --upgrade --no-cache-dir -r /opt/requirements.txt \
    && apk del --no-cache \
            build-dependencies \
            build-base \
            python-dev \
            openssl-dev \
            libffi-dev \
            linux-headers \
    && \
        rm -rf /var/cache/apk/* \
        rm -rf /tmp/*

# Default command: display local setup
CMD ["ansible", "-c", "local", "-m", "setup", "all"]

