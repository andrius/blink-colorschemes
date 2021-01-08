# vim: set fenc=utf-8 ts=2 sw=2 sts=2 et ft=Dockerfile :
FROM alpine:3.12

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

ENV WORKDIR /themes
WORKDIR ${WORKDIR}

RUN apk --update --no-cache add \
			ca-certificates \
			python3 \
			ruby \
	    git \
&& git clone --depth 1 https://github.com/mbadolato/iTerm2-Color-Schemes.git /tmp/iTerm2-Color-Schemes \
&& cd /tmp/iTerm2-Color-Schemes/tools \
&& chmod +x . \
&& cp -R . /usr/local/bin

RUN git clone --depth 1 https://github.com/hwyncho/ayu-iTerm.git \
&& cp -R ayu-iTerm/*.itermcolors . \
&& rm -rf ayu-iTerm \
&& iterm2xrdb "ayu Dark.itermcolors"   > "ayu Dark.xrdb" \
&& xrdb2hterm "ayu Dark.xrdb"          > "ayu Dark.js" \
&& iterm2xrdb "ayu Light.itermcolors"  > "ayu Light.xrdb" \
&& xrdb2hterm "ayu Light.xrdb"         > "ayu Light.js" \
&& iterm2xrdb "ayu Mirage.itermcolors" > "ayu Mirage.xrdb" \
&& xrdb2hterm "ayu Mirage.xrdb"        > "ayu Mirage.js"

CMD ["sleep", "infinity"]

