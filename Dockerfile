FROM frolvlad/alpine-glibc as downloader

RUN apk add --no-cache ca-certificates openssl

ARG MIGRATE_VERSION

RUN if [[ -z "$MIGRATE_VERSION" ]]; then echo "MIGRATE_VERSION argument MUST be set" && exit 1; fi

ENV DOWNLOAD_URL https://github.com/mattes/migrate/releases/download/v$MIGRATE_VERSION/migrate.linux-amd64.tar.gz

RUN set -xe \
    && wget $DOWNLOAD_URL \
    && tar xvfz migrate.linux-amd64.tar.gz -C /tmp


FROM frolvlad/alpine-glibc

COPY --from=downloader /tmp/migrate.linux-amd64 /migrate

ENTRYPOINT ["/migrate"]
CMD ["--help"]
