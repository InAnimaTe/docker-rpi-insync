FROM arm32v7/debian:stretch

ENV S6_OVERLAY_VERSION=v1.21.7.0

WORKDIR /root

COPY insync-headless /usr/bin/insync-headless

### Install s6 and Insync
RUN set -x && \
    apt-get update && \
    apt-get install -y apt-transport-https ca-certificates gnupg curl bzip2 && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-armhf.tar.gz | tar xzf - -C / && \
    curl https://d2t3ff60b2tol4.cloudfront.net/test_builds/armhf/insync-armhf_1.3.17.36167_i386.tar.bz2 | tar xjf - -C ./ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY install /

ENTRYPOINT ["/init"]
