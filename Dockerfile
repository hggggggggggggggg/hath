FROM amazoncorretto:8-alpine-jdk

LABEL maintainer hgg <>

ENV HATH_PORT 6969

RUN apk add --no-cache --update \
    ca-certificates \
    tzdata \
 && update-ca-certificates

ARG HATH_VERSION=1.6.2

RUN apk add --no-cache --update --virtual build-dependencies wget unzip && \
    wget -O /tmp/hath-$HATH_VERSION.zip https://repo.e-hentai.org/hath/HentaiAtHome_$HATH_VERSION.zip && \
    ls -l /tmp && \
    mkdir -p /opt/hath /hath && \
    unzip /tmp/hath-$HATH_VERSION.zip HentaiAtHome.jar -d /opt/hath && \
    rm /tmp/hath-$HATH_VERSION.zip && \
    apk del build-dependencies

ADD run/* /opt/hath/

RUN chmod +x /opt/hath/start.sh

WORKDIR /hath

EXPOSE "$HATH_PORT"

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/tmp"]

CMD ["/opt/hath/start.sh"]
