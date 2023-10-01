# vim: set fenc=utf-8 ts=2 sw=2 sts=2 et ft=Dockerfile :
FROM alpine:3.18.3

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

ENV WORKDIR /themes
WORKDIR ${WORKDIR}

RUN apk --update --no-cache add \
			ca-certificates \
			python3 \
			ruby \
	    bash \
	    git \
      wget \
&& git clone --depth 1 https://github.com/mbadolato/iTerm2-Color-Schemes.git /tmp/iTerm2-Color-Schemes \
&& cd /tmp/iTerm2-Color-Schemes/tools \
&& chmod +x . \
&& cp -R . /usr/local/bin

COPY convert.sh /
CMD ["/convert.sh"]

