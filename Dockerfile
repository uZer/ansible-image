FROM alpine:latest
ARG ANSIBLE_VERSION=2.6.4

LABEL io.voidal.description="Ansible baseimage for ci usage" \
      io.voidal.vendor="TheVoid" \
      io.voidal.ansible_version="${ANSIBLE_VERSION}" \
      io.voidal.maintainers="Youenn Piolet <piolet.y@gmail.com>"

# Runtime + build requirements
RUN ln -s /lib /lib64 && \
    apk add --no-cache \
            sudo \
            git \
            python \
            py-pip \
            openssl \
            ca-certificates \
            sshpass \
            openssh-client \
            rsync

# Build requirements + install ansible
RUN apk add --virtual .build-deps --no-cache \
            build-base \
            python-dev \
            openssl-dev \
            libffi-dev \
            linux-headers \
            && \
    pip install --upgrade --no-cache-dir ansible==${ANSIBLE_VERSION} && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/* /tmp/*

CMD ["ansible", "--version"]
