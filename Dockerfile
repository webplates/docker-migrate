FROM ubuntu

ENV VERSION 3.0.0
ENV DOWNLOAD_URL https://github.com/mattes/migrate/releases/download/v$VERSION/migrate.linux-amd64.tar.gz

RUN set -xe \
    && apt-get update \
    && apt-get install -y curl \
    && curl -L $DOWNLOAD_URL | tar xvz -C /tmp \
    && mv /tmp/migrate.linux-amd64 /usr/local/bin/migrate \
    && apt-get purge -y curl \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["migrate"]
CMD ["--help"]
