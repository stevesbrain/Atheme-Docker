FROM alpine:3.6
MAINTAINER Stevesbrain
ARG BUILD_DATE
ARG VERSION
LABEL build_version="stevesbrain version:- ${VERSION} Build-date:- ${BUILD_DATE}"
ARG CONFIGUREFLAGS="--prefix=/services --disable-nls"

ENV ATHEME_RELEASE 7.2.9

# Build Charybdis
RUN set -x \
    && apk add --no-cache --virtual runtime-dependencies \
    	git \
	openssl \
	openssl-dev \
        build-base \
        curl \
	libmowgli \
	libmowgli-dev \
	pkgconfig \
    && mkdir /atheme-src && cd /atheme-src \
    && curl -fsSL "https://github.com/atheme/atheme/releases/download/v${ATHEME_RELEASE}/atheme-${ATHEME_RELEASE}.tar.bz2" -o atheme.tar.bz2 \
    && tar -jxf atheme.tar.bz2 --strip-components=1 \
    && mkdir /services \
    && ./configure ${CONFIGUREFLAGS} \
    && make \
    && make install \
    && apk del --purge build-dependencies \
	openssl-dev \
    && cd /root \
    && rm -rf /atheme-src \
    && rm -rf /src; exit 0


# Add our users for charybdis
RUN adduser -u 1000 -S services
RUN addgroup -g 1000 -S services


#Change ownership as needed
RUN chown -R services:services /services
#The user that we enter the container as, and that everything runs as
USER services
ENV BUILD 0.2.0
#ENTRYPOINT ["/irc/bin/ircd", "-pidfile", "/irc/ircd.pid", "-foreground"]
