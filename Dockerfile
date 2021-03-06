# select operating system
FROM alpine:latest

# install operating system packages 
RUN apk add --update git gettext curl bash make
RUN apk add --update softflowd nfdump

# use bpkg to handle complex bash entrypoints
#RUN curl -Lo- "https://raw.githubusercontent.com/bpkg/bpkg/master/setup.sh" | bash
RUN curl "https://raw.githubusercontent.com/bpkg/bpkg/master/setup.sh" -O setup.sh
RUN chmod +x setup.sh
RUN bash setup.sh
RUN bpkg install cha87de/bashutil -g

# add config and init files 
ADD config /etc/docker-config
ADD init /opt/docker-init

# prepare data locations
RUN mkdir -p /opt/flowexport/nfcapd ; mkdir -p /opt/flowexport/nfdump

# start from init folder
WORKDIR /opt/docker-init
ENTRYPOINT ["./entrypoint"]
